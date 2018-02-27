//
//  HItemModel.m
//  YDHYK
//
//  Created by screson on 2016/12/13.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HItemModel.h"

@implementation HItemModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"itemId":@"id"};
}

/**不序列话*/
+ (NSArray *)mj_ignoredPropertyNames{
    return @[@"unusualDescription",@"sectionRefrenceValueDesc",@"resultValueTypeKey"];
}

- (NSString *)sectionRefrenceValueDesc{
    if (_referenceMaxValue) {
        return [NSString stringWithFormat:@"%@-%@",_referenceMinValue,_referenceMaxValue];
    }
    return nil;
}

- (NSString *)strReferenceAddSub{
    if ([_referenceAddSub isEqualToString:@"1"]) {
        return @"+";
    }else if ([_referenceAddSub isEqualToString:@"0"]) {
        return @"-";
    }
    return nil;
}

- (NSString *)strResultAddSub{

    if ([_resultAddSub isEqualToString:@"1"]) {
        return @"+";
    }else if ([_resultAddSub isEqualToString:@"0"]) {
        return @"-";
    }
    return nil;
}

- (NSString *)strReferenceNegativePositive{
    if ([_referenceNegativePositive isEqualToString:@"1"]) {
        return @"阳性";
    }else if ([_referenceNegativePositive isEqualToString:@"0"]) {
        return @"阴性";
    }
    return nil;
}

- (NSString *)strResultNegativePositive{
    if ([_resultNegativePositive isEqualToString:@"1"]) {
        return @"阳性";
    }else if ([_resultNegativePositive isEqualToString:@"0"]) {
        return @"阴性";
    }
    return nil;
}


@end
