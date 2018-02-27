//
//  UIDevice+ZX.m
//  ZXStructure
//
//  Created by JuanFelix on 2016/11/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "UIDevice+ZX.h"

#define ZX_SCREEN_MAX_LENGTH (MAX(ZX_BOUNDS_WIDTH, ZX_BOUNDS_HEIGHT))
#define ZX_SCREEN_MIN_LENGTH (MIN(ZX_BOUNDS_WIDTH, ZX_BOUNDS_HEIGHT))
#define ZX_IS_IPHONE_4_OR_LESS (ZX_IS_IPHONE && ZX_SCREEN_MAX_LENGTH < 568.0)
#define ZX_IS_IPHONE_5 (ZX_IS_IPHONE && ZX_SCREEN_MAX_LENGTH == 568.0)
#define ZX_IS_IPHONE_6 (ZX_IS_IPHONE && ZX_SCREEN_MAX_LENGTH == 667.0)
#define ZX_IS_IPHONE_6P (ZX_IS_IPHONE && ZX_SCREEN_MAX_LENGTH == 736.0)
#define ZX_IS_IPHONE_IPAD (ZX_IS_IPHONE && ZX_SCREEN_MAX_LENGTH >= 1024)


@implementation UIDevice (ZX)

+ (ZX_DeviceSizeType)zx_deviceSizeType{
    if (ZX_IS_IPHONE_4_OR_LESS) {
        return ZX_IPHONE4;
    }
    if (ZX_IS_IPHONE_5) {
        return ZX_IPHONE5;
    }
    if (ZX_IS_IPHONE_6) {
        return ZX_IPHONE6;
    }
    if (ZX_IS_IPHONE_6P) {
        return ZX_IPHONE6P;
    }
    if (ZX_IS_IPHONE_IPAD) {
        return ZX_IPAD;
    }
    return ZX_IPHONE5;
}

@end
