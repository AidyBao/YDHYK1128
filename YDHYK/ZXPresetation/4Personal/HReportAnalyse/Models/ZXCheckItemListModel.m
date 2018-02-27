//
//  ZXCheckItemListModel.m
//  YDHYK
//
//  Created by screson on 2016/12/20.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXCheckItemListModel.h"

@implementation ZXCheckItemListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"itemId":@"id"};
}

- (void)setItemName:(NSString *)itemName{
    _itemName = itemName;
    _pinyin = [self getNamePinYin];
    _firstLetters = [self getNameFirstLetters];
}

- (NSString *)getNamePinYin{
    NSMutableString *pinyin = [_itemName mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);//去掉音标
    return [[pinyin lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)getNameFirstLetters{
    NSMutableString *pinyin = [_itemName mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);//去掉音标
    NSArray<NSString *> * pyList = [pinyin componentsSeparatedByString:@" "];
    NSMutableString * strList = [NSMutableString string];
    [pyList enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [strList appendString:[[obj substringWithRange:NSMakeRange(0, 1)] lowercaseString]];
    }];
    return strList;
}

@end
