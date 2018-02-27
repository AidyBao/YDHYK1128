//
//  ZXFontConfig.m
//  ZXStructure
//
//  Created by JuanFelix on 2016/11/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXFontConfig.h"
#import "NSBundle+ZXSetting.h"
#import "ZXFontSize.h"

static NSDictionary * zxFontConfig = nil;

@implementation ZXFontConfig

+ (void)initialize{
    zxFontConfig = [self loadConfig];
}

+ (NSDictionary *)loadConfig{
    return [NSDictionary dictionaryWithContentsOfFile:[NSBundle pathForFontConfig]];
}


+ (NSString *)titleFontName{
    return zxFontConfig[@"zx_tilteFontName"];
}

+ (NSString *)bodyFontName{
    return zxFontConfig[@"zx_bodyFontName"];
}

+ (NSString *)customAFontName{
    return zxFontConfig[@"zx_customAFontName"];
}

+ (NSString *)customBFontName{
    return zxFontConfig[@"zx_customBFontName"];
}

+ (NSString *)iconFontName{
    return zxFontConfig[@"zx_iconfontName"];
}


+ (CGFloat)title1FontSize{
    if (zxFontConfig) {
        return [ZXFontSize fontSizeWithDic:zxFontConfig[@"zx_title1FontSize"] defaultSize:17];
    }
    return 17;
}

+ (CGFloat)title2FontSize{
    if (zxFontConfig) {
        return [ZXFontSize fontSizeWithDic:zxFontConfig[@"zx_title2FontSize"] defaultSize:15];
    }
    return 15;
}

+ (CGFloat)bodyFontSize{
    if (zxFontConfig) {
        return [ZXFontSize fontSizeWithDic:zxFontConfig[@"zx_bodyFontSize"] defaultSize:14];
    }
    return 14;
}

+ (NSString *)textColor{
    if (zxFontConfig) {
        NSString * color = zxFontConfig[@"zx_textColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#3b3e43";
}

+ (NSString *)sub1TextColor{
    if (zxFontConfig) {
        NSString * color = zxFontConfig[@"zx_sub1TextColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#5e6269";

}

+ (NSString *)sub2TextColor{
    if (zxFontConfig) {
        NSString * color = zxFontConfig[@"zx_sub2TextColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#9fa4ac";
}

@end
