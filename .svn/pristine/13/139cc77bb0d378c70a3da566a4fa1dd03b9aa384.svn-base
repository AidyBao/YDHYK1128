//
//  ZXNavBarConfig.m
//  ZXStructure
//
//  Created by JuanFelix on 2016/11/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXNavBarConfig.h"
#import "NSBundle+ZXSetting.h"
#import "ZXFontSize.h"

static NSDictionary * zxNavBarConfig = nil;

@implementation ZXNavBarConfig

+ (void)initialize{
    zxNavBarConfig = [self loadConfig];
}

+ (NSDictionary *)loadConfig{
    return [NSDictionary dictionaryWithContentsOfFile:[NSBundle pathForNavBarConfig]];
}

+ (BOOL)userSystemBackButton{
    if (zxNavBarConfig) {
        return [zxNavBarConfig[@"zx_useSystemBackButton"] boolValue];
    }
    return true;
}

+ (BOOL)showSeparatorLine{
    if (zxNavBarConfig) {
        return [zxNavBarConfig[@"zx_showSeparatorLine"] boolValue];
    }
    return true;
}

+ (BOOL)isTranslucent{
    if (zxNavBarConfig) {
        return [zxNavBarConfig[@"zx_isTranslucent"] boolValue];
    }
    return true;
}

+ (NSString *)backgroundColor{
    if (zxNavBarConfig) {
        NSString * color = zxNavBarConfig[@"zx_backgroundColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#3B87EE";
}

+ (NSString *)textColor{
    if (zxNavBarConfig) {
        NSString * color = zxNavBarConfig[@"zx_textColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#ffffff";
}

+ (NSString *)buttonColor{
    if (zxNavBarConfig) {
        NSString * color = zxNavBarConfig[@"zx_buttonColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#ffffff";
}

+ (CGFloat)titleFontSize{
    if (zxNavBarConfig) {
        return [ZXFontSize fontSizeWithDic:zxNavBarConfig[@"zx_titleFontSize"] defaultSize:18];
    }
    return 18;
}

+ (CGFloat)buttonFontSize{
    if (zxNavBarConfig) {
        return [ZXFontSize fontSizeWithDic:zxNavBarConfig[@"zx_buttonFontSize"] defaultSize:14];
    }
    return 14;
}

@end
