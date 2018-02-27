//
//  ZXCashCouponModel.m
//  YDHYK
//
//  Created by screson on 2016/12/16.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXCashCouponModel.h"

@implementation ZXCashCouponModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"couponId":@"id"};
}


- (NSString *)expiredDesc{
    NSArray * dateL = [_endDateStr componentsSeparatedByString:@" "];
    if (dateL && dateL.count) {
        return [NSString stringWithFormat:@"%@前使用",[dateL firstObject]];
    }
    return @"无数据";
}

- (NSString *)couponDescription{
    if (_fullMoney <= 0) {
        return [NSString stringWithFormat:@"%@元现金券",@(_couponMoney)];
    }
    return [NSString stringWithFormat:@"满%@元减%@元券",@(_fullMoney),@(_couponMoney)];
}

@end
