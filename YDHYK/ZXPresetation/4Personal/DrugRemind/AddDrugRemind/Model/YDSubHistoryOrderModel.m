//
//  YDSubHistoryOrderModel.m
//  YDHYK
//
//  Created by 120v on 2016/12/21.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "YDSubHistoryOrderModel.h"

@implementation YDSubHistoryOrderModel
//将key值id更换为uid
-(instancetype)init{
    if (self = [super init]) {
        [YDSubHistoryOrderModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"keyId":@"id"};
        }];
    }
    return self;
}
@end
