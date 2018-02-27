//
//  ZXTabBarConfig.m
//  ZXStructure
//
//  Created by JuanFelix on 2016/11/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXTabBarConfig.h"
#import "NSBundle+ZXSetting.h"
#import "ZXFontSize.h"

static NSDictionary * zxTabBarConfig = nil;


@implementation ZXTabBarConfig

+ (void)initialize{
    zxTabBarConfig = [self loadConfig];
}

+ (NSDictionary *)loadConfig{
    return [NSDictionary dictionaryWithContentsOfFile:[NSBundle pathForTabBarConfig]];
}

+ (BOOL)showSeparatorLine{
    if (zxTabBarConfig) {
        return [zxTabBarConfig[@"zx_showSeparatorLine"] boolValue];
    }
    return true;
}

+ (BOOL)isTranslucent{
    if (zxTabBarConfig) {
        return [zxTabBarConfig[@"zx_isTranslucent"] boolValue];
    }
    return true;
}

+ (NSString *)backgroundColor{
    if (zxTabBarConfig) {
        NSString * color = zxTabBarConfig[@"zx_backgroundColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#ffffff";
}

+ (NSString *)textNormalColor{
    if (zxTabBarConfig) {
        NSString * color = zxTabBarConfig[@"zx_textNomalColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#afaaae";
}

+ (NSString *)textSelectedColor{
    if (zxTabBarConfig) {
        NSString * color = zxTabBarConfig[@"zx_textSelectedColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#3b87ef";
}


+ (BOOL)isCustomFontSize{
    if (zxTabBarConfig) {
        return [zxTabBarConfig[@"zx_customFontSize"] boolValue];
    }
    return true;
}

+ (CGFloat)titleFontSize{
    if (zxTabBarConfig) {
        return [ZXFontSize fontSizeWithDic:zxTabBarConfig[@"zx_titleFontSize"] defaultSize:10];
    }
    return 10;
}

+ (NSArray<ZXTabbarItem *> *)tabbarItems{
    NSMutableArray * arrItems = [NSMutableArray array];
    if (zxTabBarConfig) {
        NSArray * tempA = zxTabBarConfig[@"zx_items"];
        if (tempA) {
            for (NSDictionary * dicT in tempA) {
                ZXTabbarItem * item = [[ZXTabbarItem alloc] init];
                [item setValuesForKeysWithDictionary:dicT];
                [arrItems addObject:item];
            }
        }
    }
    return arrItems;
}



@end
