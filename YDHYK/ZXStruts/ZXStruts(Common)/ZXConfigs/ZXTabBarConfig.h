//
//  ZXTabBarConfig.h
//  ZXStructure
//
//  Created by JuanFelix on 2016/11/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZXTabbarItem.h"

@interface ZXTabBarConfig : NSObject

+ (BOOL)showSeparatorLine;
+ (BOOL)isTranslucent;
+ (NSString *)backgroundColor;
+ (NSString *)textNormalColor;
+ (NSString *)textSelectedColor;
/**是否自定义tabar  item 文字大小*/
+ (BOOL)isCustomFontSize;
+ (CGFloat)titleFontSize;

+ (NSArray<ZXTabbarItem *> *)tabbarItems;

@end
