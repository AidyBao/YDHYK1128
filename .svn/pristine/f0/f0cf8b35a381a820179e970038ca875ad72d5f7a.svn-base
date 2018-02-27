//
//  ZXRootViewControllers.m
//  YDHYK
//
//  Created by screson on 2016/11/28.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXRootViewControllers.h"
#import "HDiscoverViewController.h"
#import "YDBuyRootViewController.h"
#import "HPersonalViewController.h"
#import "YDNearbyRootViewController.h"



@implementation ZXRootViewControllers

static UITabBarController * zx_tarbarvc = nil;

+ (UITabBarController *)zx_tabbarController{
    if (!zx_tarbarvc) {
        zx_tarbarvc = [[UITabBarController alloc] init];
        
        [zx_tarbarvc.tabBar.layer setShadowColor:[UIColor zx_colorWithHEXString:@"4f8ee5" alpha:1.0].CGColor];
        [zx_tarbarvc.tabBar.layer setShadowRadius:5];
        [zx_tarbarvc.tabBar.layer setShadowOffset:CGSizeMake(0, -2)];
        [zx_tarbarvc.tabBar.layer setShadowOpacity:0.25];
        
        //Plist 中已设置嵌入NavigationController
        [zx_tarbarvc zx_addChildViewController:[[HDiscoverViewController alloc] init] atPlistIndex:0];//发现
        [zx_tarbarvc zx_addChildViewController:[[YDNearbyRootViewController alloc] init] atPlistIndex:1];//附近
        [zx_tarbarvc zx_addChildViewController:[[YDBuyRootViewController alloc] init] atPlistIndex:2];//卡购药
        [zx_tarbarvc zx_addChildViewController:[[HPersonalViewController alloc] init] atPlistIndex:3];//我的
    }
    return zx_tarbarvc;
}

+ (void)reload{
    zx_tarbarvc = nil;
    id delegate = [UIApplication sharedApplication].delegate;
    if (delegate) {
        [self zx_tabbarController].delegate = delegate;
    }
}

+ (UIWindow *)window{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow * window = delegate.window;
    return window;
//    return [[[UIApplication sharedApplication] windows] lastObject];
}

+ (void)setStatusBarBackgroundColor:(UIColor *)color{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

+ (void)setStatusBarForegroundColor:(UIColor *)color{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setForegroundColor:)]) {
        [statusBar performSelector:@selector(setForegroundColor:) withObject:color];
    }
}

@end
