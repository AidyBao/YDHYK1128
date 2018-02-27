//
//  YDReceiverAddressModel.m
//  YDHYK
//
//  Created by 120v on 2016/12/9.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "YDReceiverAddressModel.h"

@implementation YDReceiverAddressModel

//将key值id更换为uid
-(instancetype)init{
    if (self = [super init]) {
        [YDReceiverAddressModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"uid":@"id"};
        }];
    }
    return self;
}


@end
