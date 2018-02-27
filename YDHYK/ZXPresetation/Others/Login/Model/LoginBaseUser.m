//
//  LoginBaseUser.m
//  ydhyk
//
//  Created by 120v on 2016/11/18.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "LoginBaseUser.h"

@implementation LoginBaseUser

-(instancetype)init{
    if ([super init]) {
        //将key值id更换为uid
        [LoginBaseUser mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"uid":@"id"};
        }];
    }
    return self;
}

@end
