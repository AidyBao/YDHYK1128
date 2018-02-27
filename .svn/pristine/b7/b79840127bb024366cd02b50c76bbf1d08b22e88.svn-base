//
//  ZXOrderListModel.m
//  YDHYK
//
//  Created by screson on 2016/12/15.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXOrderListModel.h"

@implementation ZXOrderListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"orderId":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"orderDetailList":[ZXGoodsModel class]};
}


- (NSInteger)goodsCount{
    if (_orderDetailList && _orderDetailList.count) {
        int count = 0;
        for (ZXGoodsModel * goods in _orderDetailList) {
            count += [goods.num integerValue];
        }
        return count;
    }
    return 0;
}
//- (NSString *)webStoreURL{
//    return ZXWebStore_Address(_drugstoreId, [[ZXGlobalData shareInstance] memberId], [[ZXGlobalData shareInstance] userToken]);
//}

- (NSString *)expiredDateStr{
    NSString * currentDate = [ZXDateUtils getCurrentDate_TimeWithSecond:true isChinese:false];
    long long currentMillSeconds = [[ZXDateUtils millSecondFromDate:currentDate hasSecond:true splitChar:@"-"] longLongValue];
    long long dis = currentMillSeconds - [_orderDate longLongValue];
    int hour = (int)(dis / (60 * 60 * 1000));
    if (hour <= 24) {
        return [NSString stringWithFormat:@"请在%d小时内完成支付,逾期系统会自动取消订单",hour];
    }
    return @"订单已超过有效支付时间";
}

@end
