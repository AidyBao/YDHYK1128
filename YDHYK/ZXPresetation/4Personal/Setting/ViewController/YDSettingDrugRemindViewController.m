//
//  YDSettingDrugRemindViewController.m
//  ydhyk
//
//  Created by 120v on 2016/11/9.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDSettingDrugRemindViewController.h"
#import "ZXCommonViewModel.h"
/** 通知授权*/
#import "AppDelegate+Notice.h"

@interface YDSettingDrugRemindViewController ()
/** 重复提醒*/
@property (weak, nonatomic) IBOutlet UIButton *btnRepeatRemind;
@property (weak, nonatomic) IBOutlet UISwitch *repeatRemindSwitch;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle1;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle2;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle3;
@property (weak, nonatomic) IBOutlet UISwitch *switchVoiceRemind;

@end

@implementation YDSettingDrugRemindViewController


+(instancetype)instantiateFromStoryboard{
    return [[UIStoryboard storyboardWithName:@"Setting" bundle:nil] instantiateViewControllerWithIdentifier:@"YDSettingDrugRemindViewController"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [_lbTitle1 setFont:[UIFont zx_titleFontWithSize:zx_title1FontSize()]];
    [_lbTitle1 setTextColor:[UIColor zx_textColor]];
    [_lbTitle2 setFont:[UIFont zx_titleFontWithSize:zx_title1FontSize()]];
    [_lbTitle2 setTextColor:[UIColor zx_textColor]];
    [_lbTitle3 setFont:[UIFont zx_titleFontWithSize:zx_title1FontSize()]];
    [_lbTitle3 setTextColor:[UIColor zx_textColor]];
    
    [_btnRepeatRemind setTitleColor:[UIColor zx_sub2TextColor] forState:UIControlStateNormal];
    [_btnRepeatRemind.titleLabel setFont:[UIFont zx_titleFontWithSize:zx_title1FontSize()]];
    
    
    
    self.navigationItem.title = @"用药提醒设置";
    self.tableView.backgroundColor = [UIColor zx_assistColor];
    
    NSString *isRepeated = [[YDAPPManager shareManager] getUserIsRepeatedReminders];
    
    if (isRepeated.integerValue == 0) {
        [self.repeatRemindSwitch setOn:TRUE];
    }else if (isRepeated.integerValue == 1){
        [self.repeatRemindSwitch setOn:FALSE];
    }
    
    id isOn = [[YDAPPManager shareManager] getUserIsVoiceRemind];
    if ([isOn isKindOfClass:[NSString class]] && [isOn isEqualToString:@"1"]) {
        [self.switchVoiceRemind setOn:true];
    }else{
        [self.switchVoiceRemind setOn:false];
    }
    
    //首次判断通知是否开启
    [self firstConfirmNotAuthor];
    
    //监听是否开启通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(confirmNotificationIsAuthor:) name:ZXNOTICE_NOTIFICATION_ISOPEN object:nil];
}

#pragma mark - 判断通知是否授权
-(void)firstConfirmNotAuthor{
    [AppDelegate isAllowedNotification:^(BOOL isAuthor) {
        if (isAuthor == TRUE) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.btnRepeatRemind setTitle:@"已打开" forState:UIControlStateNormal];
            });
        }
    }];
}

-(void)confirmNotificationIsAuthor:(NSNotification *)obj{
    NSString *title = nil;
    if ([obj.object isEqualToString:@"TRUE"]) {
        title = @"已打开";
    }else if ([obj.object isEqualToString:@"FALSE"]){
        title = @"点击打开";
     }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.btnRepeatRemind setTitle:title forState:UIControlStateNormal];
    });
}


#pragma mark - 点击打开
- (IBAction)openNotification:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@""} completionHandler:^(BOOL success) {
    }];
}

#pragma mark - 用药提醒
- (IBAction)repeatRemind:(id)sender {
    UISwitch *switchBut = sender;
    BOOL openStatus;
    if (switchBut.on) {//打开重复提醒
        openStatus = true;
    }else{//关闭重复提醒
        openStatus = false;
    }
    [self httpRequestForRepeatedRemindersWithBool:openStatus];
}

- (IBAction)voiceRemind:(UISwitch *)sender {
    if (sender.on) {//尝试开启
        [ZXHUD MBShowLoadingInView:self.view text:@"" delay:0];
        [ZXCommonViewModel setVoiceRemindOn:true memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken] completion:^(BOOL success, NSString *errorMsg) {
            [ZXHUD MBHideForView:self.view animate:true];
            if (success) {
                [sender setOn:true];
                [[YDAPPManager  shareManager] getLoginBaseUser].isVoiceRemind = @"1";
                [[YDAPPManager shareManager] saveUserIsVoiceRemind];
            }else{
                [[YDAPPManager  shareManager] getLoginBaseUser].isVoiceRemind = @"0";
                [[YDAPPManager shareManager] saveUserIsVoiceRemind];
                [sender setOn:false];
                [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.5];
            }
        }];
    }else{//尝试关闭
        [ZXHUD MBShowLoadingInView:self.view text:@"" delay:0];
        [ZXCommonViewModel setVoiceRemindOn:false memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken] completion:^(BOOL success, NSString *errorMsg) {
            [ZXHUD MBHideForView:self.view animate:true];
            if (success) {
                [sender setOn:false];
                [[YDAPPManager  shareManager] getLoginBaseUser].isVoiceRemind = @"0";
                [[YDAPPManager shareManager] saveUserIsVoiceRemind];
            }else{
                [sender setOn:true];
                [[YDAPPManager  shareManager] getLoginBaseUser].isVoiceRemind = @"1";
                [[YDAPPManager shareManager] saveUserIsVoiceRemind];
                [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.5];
            }
        }];
    }
}

#pragma mark - HTTPRequest
#pragma mark 开启关闭重复提醒
-(void)httpRequestForRepeatedRemindersWithBool:(BOOL)openStatus{

    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager]getUserToken];
    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }
    //0 开启 1关闭
    [dicParams setObject:openStatus?@"0":@"1" forKey:@"isRepeatedReminders"];
    
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Modify_Repeated_Reminders) params:dicParams token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                [ZXHUD MBShowSuccessInView:self.view text:content[@"msg"] delay:1.2];
                if (openStatus) {
                    [[YDAPPManager  shareManager] getLoginBaseUser].isRepeatedReminders = @"0";//0 开启 1关闭
                    [[YDAPPManager shareManager] saveUserIsRepeatedReminders];

                }else{
                    [[YDAPPManager  shareManager] getLoginBaseUser].isRepeatedReminders = @"1";//0 开启 1关闭
                    [[YDAPPManager shareManager] saveUserIsRepeatedReminders];

                }
            }else{
                [ZXHUD MBShowFailureInView:self.view text:content[@"msg"] delay:1.2];
                if (openStatus) {
                    [_repeatRemindSwitch setOn:false];
                }else{
                    [_repeatRemindSwitch setOn:true];

                }
            }
        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
            if (openStatus) {
                [_repeatRemindSwitch setOn:false];
            }else{
                [_repeatRemindSwitch setOn:true];
                
            }
        }
    }];
    
}


#pragma mark - UITabeleViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    
    return 34;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1 || section == 2) {
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZX_BOUNDS_WIDTH, 34)];
        footerView.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(14, 0, ZX_BOUNDS_WIDTH - 28, 34)];
        label.font = [UIFont zx_titleFontWithSize:zx_bodyFontSize()];
        label.textColor = [UIColor lightGrayColor];
        [footerView addSubview:label];
        if (section == 1) {
            label.text = @"开启后,稍后服药代表系统将每隔5分钟提醒一次";
        }else if (section == 2){
            label.text = @"开启后,用药提醒会以语音的方式播送";
        }
        return footerView;
    }
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
