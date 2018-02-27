//
//  HMessageSortModel.m
//  YDHYK
//
//  Created by screson on 2016/12/14.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXMessageSortModel.h"

@implementation ZXMessageSortModel

//必须配合这个使用 mj_objectWithKeyValues
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"msgId":@"id"};
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (NSString *)msgDesc{
    if ([_type integerValue] == 1) {
        return @"您有一张新的现金券";
    }
    return @"有一个新的促销活动";
}

- (BOOL)readed{
    if ([_isRead integerValue] == 0) {
        return false;
    }
    return true;
}

- (NSString *)dateString{
    if ([_sendDateStr isKindOfClass:[NSString class]]) {
        return [[_sendDateStr componentsSeparatedByString:@" "] firstObject];
    }
    return @"";
}

@end
