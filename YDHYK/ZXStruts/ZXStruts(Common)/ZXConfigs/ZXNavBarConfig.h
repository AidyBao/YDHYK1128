//
//  ZXNavBarConfig.h
//  ZXStructure
//
//  Created by JuanFelix on 2016/11/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZXNavBarConfig : NSObject

+ (BOOL)userSystemBackButton;
+ (BOOL)showSeparatorLine;
+ (BOOL)isTranslucent;
+ (NSString *)backgroundColor;
+ (NSString *)textColor;
+ (NSString *)buttonColor;
+ (CGFloat)titleFontSize;
+ (CGFloat)buttonFontSize;

@end
