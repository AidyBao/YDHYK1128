//
//  YDHistoryOrderModel.m
//  YDHYK
//
//  Created by 120v on 2016/12/21.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "YDHistoryOrderModel.h"
#import "YDSubHistoryOrderModel.h"
//#import "NSObject+MJKeyValue.h"

//@interface YDHistoryOrderModel()
//
//@property (nonatomic ,strong) NSMutableArray *tempArray;
//
//@end

@implementation YDHistoryOrderModel

//将key值id更换为uid
-(instancetype)init{
    if (self = [super init]) {
        [YDHistoryOrderModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"keyId":@"id"};
        }];
    }
    return self;
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"orderDetailList":[YDSubHistoryOrderModel class]};
}

@end
