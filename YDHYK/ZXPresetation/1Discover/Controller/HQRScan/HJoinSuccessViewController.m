//
//  HJoinSuccessViewController.m
//  YDHYK
//
//  Created by screson on 2016/12/6.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HJoinSuccessViewController.h"
#import "YDHYK-Swift.h"

@interface HJoinSuccessViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgSuccess;

@property (weak, nonatomic) IBOutlet ZXImageView *imgIcon;//店铺图标
@property (weak, nonatomic) IBOutlet UILabel *lbName;//店铺名称
@property (weak, nonatomic) IBOutlet UIButton *lbBottomInfo;//店铺底部信息

@end

@implementation HJoinSuccessViewController

- (instancetype)init{
    if (self = [super init]) {
        [self setFd_prefersNavigationBarHidden:true];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self zx_setNavBarBackgroundColor:[UIColor clearColor]];
    
    [_imgSuccess setBackgroundColor:[UIColor zx_tintColor]];
    
    [_imgIcon setBackgroundColor:[UIColor zx_separatorColor]];
    
    [_lbName setText:@""];
    [_lbName setTextColor:[UIColor zx_textColor]];
    [_lbName setFont:[UIFont zx_titleFontWithSize:zx_buttonTitleFontSize()]];
    
    
    [_lbBottomInfo.titleLabel setFont:[UIFont zx_titleFontWithSize:13]];
    NSString * strInfo = @"您可以在首页-卡•购药查看该药店会员卡";
    NSMutableAttributedString * str = [NSAttributedString zx_addLineToText:strInfo type:ZXUnderLine atRange:NSMakeRange(4, 7)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor zx_sub1TextColor] range:NSMakeRange(0, strInfo.length)];
    
    [_lbBottomInfo setAttributedTitle:str forState:UIControlStateNormal];
    
    if (_storeInfo) {
        [_lbName  setText:_storeInfo.name];
        [_imgIcon setImageWithURL:[NSURL URLWithString:_storeInfo.headPortraitStr]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//进入药店
- (IBAction)accessStore:(id)sender {
    if (_storeInfo) {
        if (![[[ZXGlobalData shareInstance] userTelephone] isEqualToString:ZXAPP_Common_TestAccount]) {
            ZXStoreRootViewController * webStore = [ZXStoreRootViewController configVCWith:_storeInfo.storeId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken]];
            NSMutableArray *ViewCtr = [NSMutableArray arrayWithObject:[self.navigationController.viewControllers firstObject]];
            [ViewCtr addObject:webStore];
            [self.navigationController setViewControllers:ViewCtr animated:YES];
            //[webStore.navigationController setNavigationBarHidden:true animated:true];
        }
    }else{
        [ZXAlertUtils showAAlertMessage:@"无法获取店铺信息" title:@"提示" buttonText:@"确定" buttonAction:^{
            [self.navigationController popToRootViewControllerAnimated:true];
        }];
    }
}

- (IBAction)jumpToCards:(id)sender {
    if (self.navigationController) {
        [self.navigationController popToRootViewControllerAnimated:false];
        [ZXRouter selectTabbarIndex:2];
    }else{
        
        [self dismissViewControllerAnimated:false completion:nil];
        [ZXRouter selectTabbarIndex:2];
    }

}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
