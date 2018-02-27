//
//  YDClosesListModel.m
//  YDHYK
//
//  Created by 120v on 2016/12/16.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "YDClosesListModel.h"

@implementation YDClosesListModel
//将key值id更换为uid
-(instancetype)init{
    if (self = [super init]) {
        [YDClosesListModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"uid":@"id"};
        }];
    }
    return self;
}
@end
