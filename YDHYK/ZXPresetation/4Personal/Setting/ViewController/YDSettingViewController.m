//
//  YDSettingViewController.m
//  ydhyk
//
//  Created by 120v on 2016/11/9.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDSettingViewController.h"

/** 设置用药提醒*/
#import "YDSettingDrugRemindViewController.h"
/** 登录视图*/
#import "YDLoginRootViewController.h"
#import "YDSearchModel.h"
#import "ZXWebStoreViewController.h"

@interface YDSettingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *drugMemindLabel;
@property (weak, nonatomic) IBOutlet UILabel *clearCatheLabel;
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;
@property (weak, nonatomic) IBOutlet UILabel *logoutLabel;
@property (weak, nonatomic) IBOutlet UILabel *cacheSizeLabel;

@end

@implementation YDSettingViewController

+(instancetype)instantiateFromStoryboard{
    return [[UIStoryboard storyboardWithName:@"Setting" bundle:nil] instantiateViewControllerWithIdentifier:@"YDSettingViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"系统设置";
    self.drugMemindLabel.textColor = [UIColor zx_textColor];
    self.clearCatheLabel.textColor = [UIColor zx_textColor];
    self.aboutLabel.textColor = [UIColor zx_textColor];
    self.logoutLabel.textColor = [UIColor zx_tintColor];
    
    self.tableView.backgroundColor = [UIColor zx_assistColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.cacheSizeLabel.text = [NSString stringWithFormat:@"%0.2fM",[YDAPPManager folderSizeAtPath:nil]];
}



#pragma mark - UITabeleViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return CGFLOAT_MIN;
    }
    
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        
        switch (indexPath.row) {
            case 0://用药提醒
            {
                YDSettingDrugRemindViewController *drugVC = [YDSettingDrugRemindViewController instantiateFromStoryboard];
                drugVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:drugVC animated:YES];
            }
                
                break;
                
            case 1://清理缓存
            {
                [ZXAlertUtils showAAlertMessage:@"确定清除缓存数据吗？" title:@"提示" buttonTexts:@[@"取消",@"确定"] buttonAction:^(int buttonIndex) {
                    switch (buttonIndex) {
                        case 1:
                            //清除缓存数据
                            [self cleanCacheData];
                            break;
                            
                        default:
                            break;
                    }
                }];
            }
                break;
                
            default:
                break;
        }
        
    }
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {//关于云药店
            case 0:
                {
                    [self.navigationController pushViewController:[ZXWebStoreViewController loadWebStoreURLString:[NSString stringWithFormat:@"%@%@%@",ZXROOT_STATIC_URL,ZXAPI_ABOUT,[ZXCommonUtils getBundleVersion]]]  animated:YES];
                }
                break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 2) {
        switch (indexPath.row) {//退出登录
            case 0:
                //退出登录
            {
                [ZXAlertUtils showAAlertMessage:@"确认退出登录？" title:@"提示" buttonTexts:@[@"取消",@"确定"] buttonAction:^(int buttonIndex) {
                    switch (buttonIndex) {
                        case 0:
                            break;
                        case 1:
                            [self logout];
                            break;
                        default:
                            break;
                    }
                }];
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark - 清除缓存数据
-(void)cleanCacheData{
    [[SDImageCache sharedImageCache] cleanDisk];
    [YDAPPManager clearCache:nil];
    self.cacheSizeLabel.text = [NSString stringWithFormat:@"%0.2fM",[YDAPPManager folderSizeAtPath:nil]];
}

#pragma mark - 退出登录
-(void)logout{
    //1.清空
    [[YDAPPManager shareManager] cleanUserAllInfo];
    
    //2.保存登录状态
    [[YDAPPManager shareManager] getLoginBaseUser].isLoginSataus = NO;
    [[YDAPPManager shareManager] saveLoginSataus];
    
    //3.清空数据库
    [YDSearchModel clearTable];
    
    //4.清空tabBar
    [ZXRootViewControllers reload];

    //5.跳转
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    UIWindow *window =delegate.window;
    YDLoginRootViewController *loginVC = [[YDLoginRootViewController alloc]initWithNibName:@"YDLoginRootViewController" bundle:nil];
    UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
    navVC.navigationController.navigationBarHidden = YES;
    window.rootViewController = navVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
