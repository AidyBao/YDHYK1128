//
//  ZXFontSize.m
//  ZXStructure
//
//  Created by JuanFelix on 2016/11/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXFontSize.h"
#import "UIDevice+ZX.h"

@implementation ZXFontSize

+ (CGFloat)fontSizeWithDic:(NSDictionary *)dicP defaultSize:(CGFloat)dSize{
    if ([dicP isKindOfClass:[NSDictionary class]]) {
        switch ([UIDevice zx_deviceSizeType]) {
            case ZX_IPHONE4:
            case ZX_IPHONE5:
            {
                return [dicP[@"iPhone5"] floatValue];
            }
                break;
            case ZX_IPHONE6:
            {
                return [dicP[@"iPhone6"] floatValue];
            }
                break;
            case ZX_IPHONE6P:
            case ZX_IPAD:
            {
                return [dicP[@"iPhone6P"] floatValue];
            }
                break;
            default:
                break;
        }
    }
    return dSize;
}

@end
