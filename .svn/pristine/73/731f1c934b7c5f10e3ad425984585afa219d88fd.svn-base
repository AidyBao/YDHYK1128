//
//  ZXCommonEngine.m
//  ZXStructure
//
//  Created by JuanFelix on 2016/11/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXCommonEngine.h"
#import <UIKit/UIKit.h>

#import "NSBundle+ZXSetting.h"
#import "UIColor+ZXColor.h"
#import "UIFont+ZXFont.h"
#import "ZXNavBarConfig.h"
#import "ZXTabBarConfig.h"

@implementation ZXCommonEngine

+ (void)loadAllConfig{
    [self loadNavBarConfig];
    [self loadTabBarConfig];
}

+ (void)loadNavBarConfig{
    [[UINavigationBar appearance] setBarTintColor:[UIColor zx_navbarColor]];
//    if (![ZXNavBarConfig userSystemBackButton]) {
//        [[UINavigationBar appearance] setBackIndicatorImage:[NSBundle zx_navBackImage]];
//        [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[NSBundle zx_navBackImage]];
//    }
    [[UINavigationBar appearance] setTranslucent:[ZXNavBarConfig isTranslucent]];
    [[UINavigationBar appearance] setTintColor:[UIColor zx_navbarButtonTitleColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName:
                                                               [UIColor zx_navbarTitleColor],
                                                           NSFontAttributeName:
                                                               [UIFont systemFontOfSize:
                                                                zx_navBarTitleFontSize()]
                                                           }];
    if (![ZXNavBarConfig showSeparatorLine]) {
        [[UINavigationBar appearance]  setBackgroundImage:[[UIImage alloc] init]
                                           forBarPosition:UIBarPositionAny
                                               barMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    }
}

+ (void)loadTabBarConfig{
    [[UITabBar appearance] setBarTintColor:[UIColor zx_tabbarColor]];
    [[UITabBar appearance] setTranslucent:[ZXTabBarConfig isTranslucent]];
    
    if (![ZXTabBarConfig isCustomFontSize]) {
        [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                            NSForegroundColorAttributeName:
                                                                [UIColor zx_tabbarTitleNormalColor]
                                                            }
                                                 forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                            NSForegroundColorAttributeName:
                                                                [UIColor zx_tabbarTitleSelectedColor]
                                                            }
                                                 forState:UIControlStateSelected];
    }else{
        [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                            NSForegroundColorAttributeName:
                                                                [UIColor zx_tabbarTitleNormalColor],
                                                            NSFontAttributeName:
                                                                [UIFont systemFontOfSize:
                                                                 zx_tabBarItemTitleFontSize()]
                                                            }
                                                 forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                            NSForegroundColorAttributeName:
                                                                [UIColor zx_tabbarTitleSelectedColor],
                                                            NSFontAttributeName:
                                                                [UIFont systemFontOfSize:
                                                                 zx_tabBarItemTitleFontSize()]
                                                            }
                                                 forState:UIControlStateSelected];
    }
    
    if (![ZXTabBarConfig showSeparatorLine]) {
        [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
        [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    }
}

@end
