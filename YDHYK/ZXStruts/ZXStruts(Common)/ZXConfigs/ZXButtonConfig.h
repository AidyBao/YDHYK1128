//
//  ZXButtonConfig.h
//  ZXStructure
//
//  Created by JuanFelix on 2016/11/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZXButtonConfig : NSObject

+ (NSString *)backgroundNormalColor;
+ (NSString *)backgroundSelectedColor;
+ (NSString *)backgroundDisabledColor;

+ (NSString *)titleNormalColor;
+ (NSString *)titleSelectedColor;
+ (NSString *)titleDisabledColor;

+ (CGFloat)titleFontSize;


@end
