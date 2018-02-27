//
//  YDRemindTimeModel.m
//  YDHYK
//
//  Created by 120v on 2016/12/15.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "YDRemindTimeModel.h"

@implementation YDRemindTimeModel
//将key值id更换为uid
-(instancetype)init{
    if (self = [super init]) {
        [YDRemindTimeModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"uid":@"id"};
        }];
    }
    return self;
}
@end
