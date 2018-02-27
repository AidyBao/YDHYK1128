//
//  UINavigationController+ZX.m
//  ZXStructure
//
//  Created by JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "UINavigationController+ZX.h"
#import <objc/runtime.h>

@implementation UINavigationController (ZX)

/*
+ (void)load{
    Method method1 = class_getInstanceMethod(self, @selector(preferredStatusBarStyle));
    Method method2 = class_getInstanceMethod(self, @selector(xxx_preferredStatusBarStyle));
    method_exchangeImplementations(method1, method2);
}

- (UIStatusBarStyle)xxx_preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
*/


@end
