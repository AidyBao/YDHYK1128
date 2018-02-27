//
//  UIColor+ZXColor.h
//  ZXStructure
//
//  Created by JuanFelix on 23/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ZXRGB_COLOR(_R,_G,_B) [UIColor colorWithRed:(_R)/255.0f green:(_G)/255.0f blue:(_B)/255.0f alpha:1.0]
#define ZXRGBA_COLOR(_R,_G,_B,_A) [UIColor colorWithRed:(_R)/255.0f green:(_G)/255.0f blue:(_B)/255.0f alpha:(_A)]
#define ZXCLEAR_COLOR      [UIColor clearColor]
#define ZXWHITE_COLOR      [UIColor whiteColor]
#define ZXHBLACK_COLOR     [UIColor blackColor]

@interface UIColor (ZXColor)

/*!
 16进制颜色
 */
+ (UIColor *)zx_colorWithHEX:(long)hex;
+ (UIColor *)zx_colorWithHEX:(long)hex
                       alpha:(CGFloat)opacity;
+ (UIColor *)zx_colorWithHEXString:(NSString *)color
                             alpha:(CGFloat)alpha;

//MARK: - 主色调
/*!程序主色调*/
+ (UIColor *)zx_tintColor;

/**程序辅助色*/
+ (UIColor *)zx_assistColor;

/**通用背景色*/
+ (UIColor *)zx_backgroundColor;

/**分割线颜色*/
+ (UIColor *)zx_separatorColor;

/**边框颜色*/
+ (UIColor *)zx_borderColor;

/**自定义颜色A (默认橙色系)*/
+ (UIColor *)zx_customAColor;

/**自定义颜色B (默认红色系)*/
+ (UIColor *)zx_customBColor;

/**自定义颜色C (默认红色系)*/
+ (UIColor *)zx_customCColor;

//MARK: - 字体色调

/**一级文字颜色 （黑色）*/
+ (UIColor *)zx_textColor;

/**二级文字颜色 (浅黑)*/
+ (UIColor *)zx_sub1TextColor;

/**三级文字颜色 (灰色)*/
+ (UIColor *)zx_sub2TextColor;

//MARK: - 导航栏色调

/**导航栏背景色*/
+ (UIColor *)zx_navbarColor;

/**导航栏标题文字*/
+ (UIColor *)zx_navbarTitleColor;

/**导航栏按钮文字颜色*/
+ (UIColor *)zx_navbarButtonTitleColor;

//MARK: - 标签栏色调

/**标签栏背景色*/
+ (UIColor *)zx_tabbarColor;

/**标签栏文字颜色*/
+ (UIColor *)zx_tabbarTitleNormalColor;

/**标签栏文字选中颜色*/
+ (UIColor *)zx_tabbarTitleSelectedColor;

//MARK: - 按钮色调

/**按钮背景色 (默认蓝色系)*/
+ (UIColor *)zx_buttonBGNormalColor;

/**按钮点击背景色 (默认蓝色系)*/
+ (UIColor *)zx_buttonBGSelectedColor;

/**按钮禁用状态背景色 (默认淡蓝色系) */
+ (UIColor *)zx_buttonBGDisabledColor;

/**按钮文字颜色 (默认白色) */
+ (UIColor *)zx_buttonTitleNormalColor;

/**按钮点击时文字颜色 (默认白色)*/
+ (UIColor *)zx_buttonTitleSelectedColor;

/**按钮禁用时文字颜色 (默认白色)*/
+ (UIColor *)zx_buttonTitleDisabledColor;




@end
