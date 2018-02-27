//
//  UIViewController+ZXPortrait.m
//  ZXStructure
//
//  Created by JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "UIViewController+ZXPortrait.h"
#import <objc/runtime.h>
#import "ZXNavBarConfig.h"
#import "NSBundle+ZXSetting.h"

@implementation UIViewController (ZXPortrait)

+ (void)load{
    
    Method method1 = class_getInstanceMethod(self, @selector(init));
    Method method2 = class_getInstanceMethod(self, @selector(xxx_init));
    method_exchangeImplementations(method1, method2);
    
    Method methodA1 = class_getInstanceMethod(self, @selector(shouldAutorotate));
    Method methodA2 = class_getInstanceMethod(self, @selector(xxx_shouldAutorotate));
    method_exchangeImplementations(methodA1, methodA2);
    
    Method methodB1 = class_getInstanceMethod(self, @selector(supportedInterfaceOrientations));
    Method methodB2 = class_getInstanceMethod(self, @selector(xxx_supportedInterfaceOrientations));
    method_exchangeImplementations(methodB1, methodB2);
    
    Method methodC1 = class_getInstanceMethod(self, @selector(viewDidLoad));
    Method methodC2 = class_getInstanceMethod(self, @selector(xxx_viewDidLoad));
    method_exchangeImplementations(methodC1, methodC2);
    
    Method methodD1 = class_getInstanceMethod(self, @selector(viewDidAppear:));
    Method methodD2 = class_getInstanceMethod(self, @selector(xxx_viewDidAppear:));
    method_exchangeImplementations(methodD1, methodD2);
}

-(instancetype)xxx_init{
    [self setHidesBottomBarWhenPushed:true];
    return [self xxx_init];
}

- (void)xxx_viewDidLoad{
    [self xxx_viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    //在FDFullScreenPop 中的 pushviewcontroller 处理，
    //避免UI设置操作调用 viewdidload 时，当前controller还没有赋值navigation
//    if (![ZXNavBarConfig userSystemBackButton]) {
//        if (self.navigationController.viewControllers.count > 1) {
//            UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[NSBundle zx_navBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(zx_backAction)];
//            [self.navigationItem setLeftBarButtonItem:backItem];
//        }
//    }
}

//- (void)zx_backAction{
//    [self.navigationController popViewControllerAnimated:true];
//}
- (void)xxx_viewDidAppear:(BOOL)animated{
    [self xxx_viewDidAppear:animated];
    UIViewController * vc = self;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        vc = [[(UINavigationController *)vc viewControllers] firstObject];
    }
    if (![vc isKindOfClass:NSClassFromString(@"YDLaunchRootViewController")]&&
        ![vc isKindOfClass:NSClassFromString(@"YDLoginRootViewController")]&&
        ![vc isKindOfClass:NSClassFromString(@"YDRegistViewController")]&&
        ![vc isKindOfClass:NSClassFromString(@"UICompatibilityInputViewController")]&&
        ![vc isKindOfClass:NSClassFromString(@"UIInputWindowController")]&&
        ![vc isKindOfClass:NSClassFromString(@"UIApplicationRotationFollowingControllerNoTouches")]) {
        [ZXRouter checkNoticeCache];
    }
}

- (BOOL)xxx_shouldAutorotate{
    return true;
}

- (UIInterfaceOrientationMask)xxx_supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}


@end
