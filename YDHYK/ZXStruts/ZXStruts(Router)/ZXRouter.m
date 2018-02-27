//
//  ZXRouter.m
//  ZXStructure
//
//  Created by JuanFelix on 2016/11/25.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXRouter.h"

@implementation ZXRouter

+ (void)changeRootViewController:(UIViewController *)rootVC{
    UIWindow * window = [ZXRootViewControllers window];
    window.rootViewController = rootVC;
}

+ (void)shouldSelectTabbarIndex:(NSInteger)index{
    UITabBarController * tabbarvc = [ZXRootViewControllers zx_tabbarController];
    [tabbarvc.delegate tabBarController:tabbarvc shouldSelectViewController:[[tabbarvc viewControllers] objectAtIndex:index]];
}

+ (void)selectTabbarIndex:(NSInteger)index{
    UITabBarController * tabbarvc = [ZXRootViewControllers zx_tabbarController];
    [tabbarvc setSelectedIndex:index];
}

@end