//
//  UIColor+ZXColor.m
//  ZXStructure
//
//  Created by JuanFelix on 23/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "UIColor+ZXColor.h"
#import "ZXTintColorConfig.h"
#import "ZXNavBarConfig.h"
#import "ZXTabBarConfig.h"
#import "ZXFontConfig.h"
#import "ZXButtonConfig.h"

@implementation UIColor (ZXColor)

//MARK: -
+ (UIColor *)zx_colorWithHEX:(long)hex
                       alpha:(CGFloat)opacity{
    float red = ((float)((hex & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hex & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hex & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

+ (UIColor *)zx_colorWithHEX:(long)hex{
    return [self zx_colorWithHEX:hex alpha:1.0];
}

+ (UIColor *)zx_colorWithHEXString:(NSString *)color
                             alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}


//MARK: - MAIN COLOR
+ (UIColor *)zx_tintColor{
    return [self zx_colorWithHEXString:[ZXTintColorConfig mainColor] alpha:1.0];
}

+ (UIColor *)zx_assistColor{
    return [self zx_colorWithHEXString:[ZXTintColorConfig assistColor] alpha:1.0];
}

+ (UIColor *)zx_backgroundColor{
    return [self zx_colorWithHEXString:[ZXTintColorConfig backgroundColor] alpha:1.0];
}

+ (UIColor *)zx_separatorColor{
    return [self zx_colorWithHEXString:[ZXTintColorConfig separatorColor] alpha:1.0];
}

+ (UIColor *)zx_borderColor{
    return [self zx_colorWithHEXString:[ZXTintColorConfig borderColor] alpha:1.0];
}

+ (UIColor *)zx_customAColor{
    return [self zx_colorWithHEXString:[ZXTintColorConfig customAColor] alpha:1.0];
}

+ (UIColor *)zx_customBColor{
    return [self zx_colorWithHEXString:[ZXTintColorConfig customBColor] alpha:1.0];
}

+ (UIColor *)zx_customCColor{
    return [self zx_colorWithHEXString:[ZXTintColorConfig customCColor] alpha:1.0];
}

//MARK: - 导航栏色调
+ (UIColor *)zx_navbarColor{
    return [self zx_colorWithHEXString:[ZXNavBarConfig backgroundColor] alpha:1.0];
}

+ (UIColor *)zx_navbarTitleColor{
    return [self zx_colorWithHEXString:[ZXNavBarConfig textColor] alpha:1.0];
}

+ (UIColor *)zx_navbarButtonTitleColor{
    return [self zx_colorWithHEXString:[ZXNavBarConfig buttonColor] alpha:1.0];
}


//MARK: - 标签栏色调
+ (UIColor *)zx_tabbarColor{
    return [self zx_colorWithHEXString:[ZXTabBarConfig backgroundColor] alpha:1.0];
}

+ (UIColor *)zx_tabbarTitleNormalColor{
    return [self zx_colorWithHEXString:[ZXTabBarConfig textNormalColor] alpha:1.0];
}

+ (UIColor *)zx_tabbarTitleSelectedColor{
    return [self zx_colorWithHEXString:[ZXTabBarConfig textSelectedColor] alpha:1.0];
}

//MARK: - 字体色调

+ (UIColor *)zx_textColor{
     return [self zx_colorWithHEXString:[ZXFontConfig textColor] alpha:1.0];
}

+ (UIColor *)zx_sub1TextColor{
    return [self zx_colorWithHEXString:[ZXFontConfig sub1TextColor] alpha:1.0];
}

+ (UIColor *)zx_sub2TextColor{
    return [self zx_colorWithHEXString:[ZXFontConfig sub2TextColor] alpha:1.0];
}

//MARK: - 按钮色调

+ (UIColor *)zx_buttonBGNormalColor{
    return [self zx_colorWithHEXString:[ZXButtonConfig backgroundNormalColor] alpha:1.0];
}

+ (UIColor *)zx_buttonBGSelectedColor{
    return [self zx_colorWithHEXString:[ZXButtonConfig backgroundSelectedColor] alpha:1.0];
}


+ (UIColor *)zx_buttonBGDisabledColor{
    return [self zx_colorWithHEXString:[ZXButtonConfig backgroundDisabledColor] alpha:1.0];
}


+ (UIColor *)zx_buttonTitleNormalColor{
    return [self zx_colorWithHEXString:[ZXButtonConfig titleNormalColor] alpha:1.0];
}


+ (UIColor *)zx_buttonTitleSelectedColor{
    return [self zx_colorWithHEXString:[ZXButtonConfig titleSelectedColor] alpha:1.0];
}


+ (UIColor *)zx_buttonTitleDisabledColor{
    return [self zx_colorWithHEXString:[ZXButtonConfig titleDisabledColor] alpha:1.0];
}




@end
