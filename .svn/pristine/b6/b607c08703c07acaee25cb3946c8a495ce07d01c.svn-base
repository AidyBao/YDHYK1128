//
//  NSMutableAttributedString+ZX.m
//  ZXStructure
//
//  Created by JuanFelix on 26/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "NSMutableAttributedString+ZX.h"

@implementation NSMutableAttributedString (ZX)

- (NSMutableAttributedString *)zx_appendColor:(UIColor *)color
                                      atRange:(NSRange)range{
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
    return self;
}

- (NSMutableAttributedString *)zx_appendFont:(UIFont *)font
                                     atRange:(NSRange)range{
    [self addAttribute:NSFontAttributeName value:font range:range];
    return self;
}

@end
