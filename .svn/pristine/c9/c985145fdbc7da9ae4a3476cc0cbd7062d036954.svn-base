//
//  NSBundle+ZXSetting.m
//  ZXStructure
//
//  Created by JuanFelix on 23/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "NSBundle+ZXSetting.h"
#import "ZXCommonEngine.h"

@implementation NSBundle (ZXSetting)

+ (instancetype)zx_settingBundle{
    static NSBundle * settingBundle = nil;
    if (settingBundle == nil) {
        settingBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[ZXCommonEngine class]] pathForResource:@"ZXSettings" ofType:@"bundle"]];
    }
    return settingBundle;
}

+ (NSString *)pathForButtonConfig{
    return [[self zx_settingBundle]  pathForResource:@"UIConfig/ZXButtonConfig" ofType:@"plist"];
}

+ (NSString *)pathForFontConfig{
    return [[self zx_settingBundle]  pathForResource:@"UIConfig/ZXFontConfig" ofType:@"plist"];
}

+ (NSString *)pathForNavBarConfig{
    return [[self zx_settingBundle]  pathForResource:@"UIConfig/ZXNavBarConfig" ofType:@"plist"];
}

+ (NSString *)pathForTabBarConfig{
    return [[self zx_settingBundle]  pathForResource:@"UIConfig/ZXTabBarConfig" ofType:@"plist"];
}

+ (NSString *)pathForTintColorConfig{
    return [[self zx_settingBundle]  pathForResource:@"UIConfig/ZXTintColorConfig" ofType:@"plist"];
}

+ (UIImage *)zx_navBackImage{
    static UIImage * navBackImage = nil;
    if (!navBackImage) {
        navBackImage = [UIImage imageWithContentsOfFile:[[self zx_settingBundle] pathForResource:@"zx_navback@2x" ofType:@"png"]];
    }
    return navBackImage;
}

@end
