//
//  UIDevice+ZX.h
//  ZXStructure
//
//  Created by JuanFelix on 2016/11/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ZX_IOS7_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending)
#define ZX_IOS8_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending)
#define ZX_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define ZX_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define ZX_BOUNDS_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define ZX_BOUNDS_HEIGHT ([[UIScreen mainScreen] bounds].size.height)


typedef enum : NSUInteger {
    ZX_IPHONE4,/**3.5及以下英寸*/
    ZX_IPHONE5,/**4.0英寸 (5 5S 5SE)*/
    ZX_IPHONE6,/**4.7英寸 (6 6S 7)*/
    ZX_IPHONE6P,/**5.5英寸 (6P 6SP 7P)*/
    ZX_IPAD/**iPad 尺寸*/
} ZX_DeviceSizeType;


@interface UIDevice (ZX)

/**设备尺寸类型*/
+ (ZX_DeviceSizeType)zx_deviceSizeType;

@end
