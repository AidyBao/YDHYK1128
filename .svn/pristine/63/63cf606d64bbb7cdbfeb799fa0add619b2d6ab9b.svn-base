//
//  ZXTintColorConfig.m
//  ZXStructure
//
//  Created by JuanFelix on 23/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "ZXTintColorConfig.h"
#import "NSBundle+ZXSetting.h"

static NSDictionary * zxTintColorConfig = nil;

@implementation ZXTintColorConfig
+ (void)initialize{
    zxTintColorConfig = [self loadConfig];
}



+ (NSDictionary *)loadConfig{
    return [NSDictionary dictionaryWithContentsOfFile:[NSBundle pathForTintColorConfig]];
}

+ (NSString *)mainColor{
    if (zxTintColorConfig) {
        NSString * color = zxTintColorConfig[@"zx_tintColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#3b87ef";
}

+ (NSString *)assistColor{
    if (zxTintColorConfig) {
        NSString * color = zxTintColorConfig[@"zx_assistColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#eff7fd";
}

+ (NSString *)backgroundColor{
    if (zxTintColorConfig) {
        NSString * color = zxTintColorConfig[@"zx_backgroundColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#ffffff";
}

+ (NSString *)separatorColor{
    if (zxTintColorConfig) {
        NSString * color = zxTintColorConfig[@"zx_separatorColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#eaeef4";
}

+ (NSString *)borderColor{
    if (zxTintColorConfig) {
        NSString * color = zxTintColorConfig[@"zx_borderColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#ffffff";
}

+ (NSString *)customAColor{
    if (zxTintColorConfig) {
        NSString * color = zxTintColorConfig[@"zx_customAColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#f29252";
}

+ (NSString *)customBColor{
    if (zxTintColorConfig) {
        NSString * color = zxTintColorConfig[@"zx_customBColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#ff4221";
}

+ (NSString *)customCColor{
    if (zxTintColorConfig) {
        NSString * color = zxTintColorConfig[@"zx_customCColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#ff4200";
}

@end
