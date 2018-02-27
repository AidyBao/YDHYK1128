//
//  UIFont+ZXFont.m
//  ZXStructure
//
//  Created by JuanFelix on 23/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "UIFont+ZXFont.h"
#import "ZXNavBarConfig.h"
#import "ZXTabBarConfig.h"
#import "ZXFontConfig.h"
#import "ZXButtonConfig.h"

//MARK: - 字体大小

//MARK: -- 标题1
CGFloat zx_title1FontSize() {
    return [ZXFontConfig title1FontSize];
}
//MARK: -- 标题1
CGFloat zx_title2FontSize() {
    return [ZXFontConfig title2FontSize];
}
//MARK: -- 正文
CGFloat zx_bodyFontSize() {
    return [ZXFontConfig bodyFontSize];
}

//MARK: -- 导航栏

CGFloat zx_navBarTitleFontSize() {
    return [ZXNavBarConfig titleFontSize];
}

CGFloat zx_navBarButtonTitleFontSize() {
    return [ZXNavBarConfig buttonFontSize];
}

//MARK: -- 标签栏

CGFloat zx_tabBarItemTitleFontSize() {
    return [ZXTabBarConfig titleFontSize];
}

//MARK: -- 通用按钮


CGFloat zx_buttonTitleFontSize() {
    return [ZXButtonConfig titleFontSize];
}

@implementation UIFont (ZXFont)


//MARK: - 字体名称相关

+ (UIFont *)zx_titleFontWithSize:(CGFloat)fontSize{
    UIFont * font = [UIFont fontWithName:[ZXFontConfig titleFontName] size:fontSize];
    if (font) {
        return font;
    }
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)zx_bodyFontWithSize:(CGFloat)fontSize{
    UIFont * font = [UIFont fontWithName:[ZXFontConfig bodyFontName] size:fontSize];
    if (font) {
        return font;
    }
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)zx_customAFontWithSize:(CGFloat)fontSize{
    UIFont * font = [UIFont fontWithName:[ZXFontConfig customAFontName] size:fontSize];
    if (font) {
        return font;
    }
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)zx_customBFontWithSize:(CGFloat)fontSize{
    UIFont * font = [UIFont fontWithName:[ZXFontConfig customBFontName] size:fontSize];
    if (font) {
        return font;
    }
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)zx_iconfontWithSize:(CGFloat)fontSize{
    UIFont * font = [UIFont fontWithName:[ZXFontConfig iconFontName] size:fontSize];
    if (font) {
        return font;
    }
    return [UIFont systemFontOfSize:fontSize];
}


//MARK: - 字号名称相关



@end
