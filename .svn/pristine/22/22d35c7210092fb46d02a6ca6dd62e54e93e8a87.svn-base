//
//  YDAgeGroupModel.m
//  ydhyk
//
//  Created by 120v on 2016/11/24.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDAgeGroupModel.h"

@implementation YDAgeGroupModel

-(instancetype)init{
    if ([super init]) {
        //将key值id更换为uid
        [YDAgeGroupModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"uid":@"id"};
        }];
    }
    return self;
}

@end
