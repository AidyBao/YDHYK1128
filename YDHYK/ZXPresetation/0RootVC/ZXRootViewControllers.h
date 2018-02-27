//
//  ZXRootViewControllers.h
//  YDHYK
//
//  Created by screson on 2016/11/28.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**管理程序主控制器*/
@interface ZXRootViewControllers : NSObject

/**主页 Tabbar控制器*/
+ (UITabBarController *)zx_tabbarController;
+ (void)reload;


/**Window*/
+ (UIWindow *)window;

+ (void)setStatusBarBackgroundColor:(UIColor *)color;
+ (void)setStatusBarForegroundColor:(UIColor *)color;

@end
