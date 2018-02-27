//
//  AppDelegate.m
//  YDHYK
//
//  Created by screson on 2016/11/28.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+BMap.h"
#import "ZXRootViewControllers.h"
#import "AppDelegate+Notice.h"
#import "UMessage.h"

/** 启动*/
#import "YDLaunchRootViewController.h"
/** 登录*/
#import "YDLoginRootViewController.h"
/** 广告启动页*/
#import "YDFlashScreenViewController.h"
/** 更新用户信息接口*/
#import "YDUpdateUserInformation.h"
#import "YDSearchModel.h"

@interface AppDelegate ()<UITabBarControllerDelegate,CLLocationManagerDelegate>{
    BOOL netWorkIsNotFirstChecked;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    isProcessed = true;
    
    //
    [[ZXRootViewControllers zx_tabbarController] setDelegate:self];
    //启用界面主体风格配置
    [ZXCommonEngine loadAllConfig];
    
    /** 网络监控*/
    [self monitorNetWorkingStatus];
    
    /** 百度地图*/
    [self launchBaiDuMap];
    
    /** 获取经纬度*/
    [self getLocation];
    
    //广告页面
    YDLaunchRootViewController *launchVC = [[YDLaunchRootViewController alloc] init];
    self.window.rootViewController = launchVC;

    [self.window makeKeyAndVisible];
    
    /** 缓存图片最多存10M */
    //Notice+UM
    [self zxn_application:application didFinishLaunchingWithOptions:launchOptions];
    
    /** 登录失效*/
    [ZXNotificationCenter addObserver:self selector:@selector(loginInvalid) name:ZXNOTICE_LOGIN_OFFLINE object:nil];

    /** 通知是否授权*/
    [self judgeNotificationStatus];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {}

- (void)applicationWillEnterForeground:(UIApplication *)application {}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //判断定位服务是否开启
    [self judgmentLocationServiceEnabled];
    
    //本地通知开启状态
    [self judgeNotificationStatus];
}

- (void)applicationWillTerminate:(UIApplication *)application {}

-(BOOL)application:(UIApplication *)app openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation{
    if ([url.host isEqualToString:@"baidumap"]) {
        return YES;
    }
    return YES;
}

#pragma mark - 登录失效
- (void)loginInvalid{
    if (!isProcessed) {
        return;
    }
    isProcessed = false;
    id keyVC = [ZXAlertUtils keyController];
    if ([keyVC isKindOfClass:[UINavigationController class]]) {
        keyVC = [[keyVC viewControllers] firstObject];
    }
    if (!([keyVC isKindOfClass:[YDFlashScreenViewController class]] || [keyVC isKindOfClass:[YDLoginRootViewController class]]|| [keyVC isKindOfClass:[YDFlashScreenViewController class]])) {
        [ZXAlertUtils showAAlertMessage:@"您的登录已失效,请重新登录!" title:@"提示" buttonText:@"重新登录" buttonAction:^{
            isProcessed = true;
            //1.清空
            [[YDAPPManager shareManager] cleanUserAllInfo];
            
            //2.保存登录状态
            [[YDAPPManager shareManager] getLoginBaseUser].isLoginSataus = NO;
            [[YDAPPManager shareManager] saveLoginSataus];
            
            //3.清空数据库
            [YDSearchModel clearTable];
            
            //4.清空tabBar
            [ZXRootViewControllers reload];
            
            //5.切换控制器
            YDLoginRootViewController *loginVC = [[YDLoginRootViewController alloc]initWithNibName:@"YDLoginRootViewController" bundle:nil];
            UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
            loginVC.logonFailue = true;
            loginVC.lastLoginID = [[YDAPPManager shareManager] getUserTelephone];
            [[ZXAlertUtils keyController] presentViewController:navVC animated:YES completion:nil];
        }];
    }else{
        isProcessed = true;
    }
}


#pragma mark - 处理Tabbar界面切换
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return [UITabBarController zx_tabBarController:tabBarController shouldSelectViewController:viewController];
}

#pragma mark -监控网络
- (void)monitorNetWorkingStatus{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 当网络状态改变时调用
    [mgr setReachabilityStatusChangeBlock:^ (AFNetworkReachabilityStatus status) {
        [self willChangeValueForKey:@"isConnected"];
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
            case AFNetworkReachabilityStatusNotReachable: // 没有网络
                [ZXHUD MBShowFailureInView:self.window text:@"网络错误" delay:0.5];
                self.isConnected = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                if (netWorkIsNotFirstChecked == NO) {
                    [ZXHUD MBShowSuccessInView:self.window text:@"网络已连接" delay:0.5];
                } else {
                    netWorkIsNotFirstChecked = YES;
                }
                self.isConnected = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                if (netWorkIsNotFirstChecked == YES) {
                    [ZXHUD MBShowSuccessInView:self.window text:@"WiFi已连接" delay:0.5];
                } else {
                    netWorkIsNotFirstChecked = YES;
                }
                self.isConnected = YES;
                break;
        }
        [self didChangeValueForKey:@"isConnected"];
    }];
    // 开始监控
    [mgr startMonitoring];
}

#pragma mark - 判断定位是否可用
-(void)judgmentLocationServiceEnabled{
    
    if ([CLLocationManager locationServicesEnabled]) {//手机定位是否打开
//        NSLog(@"设备定位可用");
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        if (kCLAuthorizationStatusAuthorizedAlways == status || kCLAuthorizationStatusAuthorizedWhenInUse == status) {//判断应用定位开启
            //开启百度地图定位
            self.isOpenLoction = @"True";
            [[NSNotificationCenter defaultCenter] postNotificationName:ZXNOTICE_LOCATION_ISOPEN object:self.isOpenLoction];
        }else if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status || kCLAuthorizationStatusNotDetermined == status){//应用定位没有开启
//            NSLog(@"应用定位没有打开!");
            self.isOpenLoction = @"False";
            [[NSNotificationCenter defaultCenter] postNotificationName:ZXNOTICE_LOCATION_ISOPEN object:self.isOpenLoction];
        }
    }else{//设备定位没有开启
//        NSLog(@"设备定位不可用");
    }
}

#pragma mark -  判断通知是否开启
-(void)judgeNotificationStatus{
    __block NSString *isNotificationAuthor = @"FALSE";
    self.isOpenNotice = @"FALSE";
    [AppDelegate isAllowedNotification:^(BOOL isAuthor) {
        if (isAuthor == TRUE) {
            isNotificationAuthor = @"TRUE";
            self.isOpenNotice = @"TRUE";
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:ZXNOTICE_NOTIFICATION_ISOPEN object:isNotificationAuthor];
    }];
}

#pragma mark -------
#pragma mark - RemoteNotifcation

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString * strToken = [NSString stringWithFormat:@"%@",deviceToken];
    strToken = [strToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    strToken = [strToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    strToken = [strToken stringByReplacingOccurrencesOfString:@">" withString:@""];
    [[ZXGlobalData shareInstance] setDeviceToken:strToken];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:ZXNOTICE_NOTIFICATION_GETDEVICETOKEN object:strToken];

}


//iOS10以下使用这个方法接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
    NSLog(@"<iOS10 :%@",userInfo);
    //from foreground
    //from background
    [ZXRouter showNoticeDetail:userInfo];
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
//    response.notification.request.content.title
    NSMutableDictionary * userInfo = [notification.request.content.userInfo mutableCopy];
    [userInfo setObject:@(0) forKey:@"fromUserTap"];
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭友盟自带的弹出框
        [UMessage setAutoAlert:NO];
        [UMessage didReceiveRemoteNotification:userInfo];
        [ZXRouter showNoticeDetail:userInfo];
    }else{//应用处于前台时的本地推送接受
        NSLog(@"iOS10 接受本地通知:%@",userInfo);
    }
}

//iOS10新增：处理[点击]通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
//    response.notification.request.content.title
    NSMutableDictionary * userInfo = [response.notification.request.content.userInfo mutableCopy];
    [userInfo setObject:@(1) forKey:@"fromUserTap"];
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        [UMessage setAutoAlert:NO];
        [UMessage didReceiveRemoteNotification:userInfo];
        [ZXRouter showNoticeDetail:userInfo];
    }else{//应用处于后台时的本地推送接受
        NSLog(@"iOS10 点击本地通知:%@",userInfo);
    }
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)tabBarControllerPreferredInterfaceOrientationForPresentation:(UITabBarController *)tabBarController{
    return UIInterfaceOrientationPortrait;
}

@end
