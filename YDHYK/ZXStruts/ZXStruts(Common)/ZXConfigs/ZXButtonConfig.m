//
//  ZXButtonConfig.m
//  ZXStructure
//
//  Created by JuanFelix on 2016/11/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXButtonConfig.h"
#import <UIKit/UIKit.h>
#import "NSBundle+ZXSetting.h"
#import "ZXFontSize.h"

static NSDictionary * zxButtongConfig = nil;

@implementation ZXButtonConfig

+ (void)initialize{
    [self loadConfig];
}

+ (NSDictionary *)loadConfig{
    return [NSDictionary dictionaryWithContentsOfFile:[NSBundle pathForButtonConfig]];
}

+ (NSString *)backgroundNormalColor{
    if (zxButtongConfig) {
        NSString * color = zxButtongConfig[@"zx_backgroundNormalColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#3b87ef";
}

+ (NSString *)backgroundSelectedColor{
    if (zxButtongConfig) {
        NSString * color = zxButtongConfig[@"zx_backgroundSelectedColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#2773da";
}


+ (NSString *)backgroundDisabledColor{
    if (zxButtongConfig) {
        NSString * color = zxButtongConfig[@"zx_backgroundDisabledColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#b8d6ff";
}

+ (NSString *)titleNormalColor{
    if (zxButtongConfig) {
        NSString * color = zxButtongConfig[@"zx_titleNormalColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#ffffff";
}

+ (NSString *)titleSelectedColor{
    if (zxButtongConfig) {
        NSString * color = zxButtongConfig[@"zx_titleSelectedColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#ffffff";
}


+ (NSString *)titleDisabledColor{
    if (zxButtongConfig) {
        NSString * color = zxButtongConfig[@"zx_titleDisabledColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#ffffff";
}

+ (CGFloat)titleFontSize{
    if (zxButtongConfig) {
        return [ZXFontSize fontSizeWithDic:zxButtongConfig[@"zx_titleFontSize"] defaultSize:18];
    }
    return 18;
}

@end
