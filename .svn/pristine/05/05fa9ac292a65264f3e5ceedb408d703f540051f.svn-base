//
//  YDDrugRemindModel.m
//  YDHYK
//
//  Created by 120v on 2016/12/14.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "YDDrugRemindModel.h"

@implementation YDDrugRemindModel
//将key值id更换为uid
-(instancetype)init{
    if (self = [super init]) {
        [YDDrugRemindModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"uid":@"id"};
        }];
    }
    return self;
}
@end
