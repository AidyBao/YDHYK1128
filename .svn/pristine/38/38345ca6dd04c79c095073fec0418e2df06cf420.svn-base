//
//  YDLaunchRootViewController.m
//  YDHYK
//
//  Created by 120v on 2017/2/28.
//  Copyright © 2017年 screson. All rights reserved.
//

#import "YDLaunchRootViewController.h"
#import "YDLoginRootViewController.h"
#import "YDFlashScreenViewController.h"
#import "YDUpdateUserInformation.h"

@interface YDLaunchRootViewController ()

@property (nonatomic, copy) NSString *deviceToken;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) CLLocation *location;

@end

@implementation YDLaunchRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    //控制器切换
    [self changeRootViewController];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark - 控制器切换
-(void)changeRootViewController{
    //判断是否登录
    if ([[YDAPPManager shareManager] getIsLoginSataus]) {
        //切换主控制器场景
        [self httpRequestLogin];
    } else {
        //
        [self changeRootController];
    }
}

#pragma mark 登录请求
-(void)httpRequestLogin{
    
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    
    //此UUID通过保存在KeyChain中，保证了UUID的相对唯一性
    NSString *telePhoneUUID = [ZXCommonUtils getUUID];
    if (telePhoneUUID.length) {
        [dicParams setObject:telePhoneUUID forKey:@"uuid"];
    }
    if ([[YDAPPManager shareManager] getUserTelephone]) {
        [dicParams setObject:[[YDAPPManager shareManager] getUserTelephone] forKey:@"tel"];
    }
    
    [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:0];
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Login) params:dicParams token:nil method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        [ZXHUD MBHideForView:self.view animate:YES];
        if (success) {
            if (status == ZXAPI_SUCCESS) {//登录成功
                /*保存用户登录信息*/
                [self saveLoginUserInfro:(NSDictionary *)content[@"data"]];
                /*进入广告页面*/
                [ZXRouter changeRootViewController:[[YDFlashScreenViewController alloc] init]];
                
            }else{//登录失败
                [ZXHUD MBShowFailureInView:self.view text:content[@"msg"] delay:1.2];
                
                //
                [[YDAPPManager shareManager] getLoginBaseUser].isLoginSataus = NO;
                [[YDAPPManager shareManager] saveLoginSataus];

                
                [self changeRootController];
                
            }
        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
            
            //
            [[YDAPPManager shareManager] getLoginBaseUser].isLoginSataus = NO;
            [[YDAPPManager shareManager] saveLoginSataus];
            
            [self changeRootController];
        }
    }];
}

#pragma mark 保存用户登录信息
-(void)saveLoginUserInfro:(NSDictionary *)dict{
    //储存登录状态
    [[YDAPPManager shareManager] getLoginBaseUser].isLoginSataus = YES;
    [[YDAPPManager shareManager] saveLoginSataus];
    
    /*存登录所有数据*/
    [[YDAPPManager shareManager] setLoginDict:dict];
}

#pragma mark - 切换控制器
-(void)changeRootController{
    YDLoginRootViewController *loginVC = [[YDLoginRootViewController alloc]initWithNibName:@"YDLoginRootViewController" bundle:nil];
    UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
    navVC.navigationController.navigationBarHidden = YES;
    [ZXRouter changeRootViewController:navVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
