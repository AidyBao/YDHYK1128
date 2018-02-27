//
//  NSAttributedString+ZX.m
//  ZXStructure
//
//  Created by JuanFelix on 26/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "NSAttributedString+ZX.h"

@implementation NSAttributedString (ZX)

+ (NSMutableAttributedString *)zx_addLineToText:(NSString *)text
                                           type:(ZXAttributeStringLineType)type
                                        atRange:(NSRange)range{
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:text];
    switch (type) {
        case ZXDeleteLine:
        {
            [attrString addAttribute:NSStrikethroughStyleAttributeName
                               value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)
                               range:range];
        }
            break;
        case ZXUnderLine:
        {
            [attrString addAttribute:NSUnderlineStyleAttributeName
                               value:@(NSUnderlineStyleSingle)
                               range:range];
        }
            break;
        default:
        {
            [attrString addAttribute:NSUnderlineStyleAttributeName
                               value:@(NSUnderlineStyleSingle)
                               range:range];
        }
            break;
    }
    return attrString;
}

+ (NSMutableAttributedString *)zx_addColorToText:(NSString *)text
                                       withColor:(UIColor *)color
                                         atRange:(NSRange)range{
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:text];
    if (range.length) {
        [attrString addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    return attrString;
}

+ (NSMutableAttributedString *)zx_addFontToText:(NSString *)text
                                       withFont:(UIFont *)font
                                        atRange:(NSRange)range{
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:text];
    if (range.length) {
        [attrString addAttribute:NSFontAttributeName value:font range:range];
    }
    return attrString;
}


@end
