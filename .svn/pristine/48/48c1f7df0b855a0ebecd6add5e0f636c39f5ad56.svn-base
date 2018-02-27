//
//  YDFlashScreenModel.m
//  YDHYK
//
//  Created by 120v on 2016/11/30.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "YDFlashScreenModel.h"

@implementation YDFlashScreenModel

-(instancetype)init{
    if ([super init]) {
        //将key值"id"更换为"uid"
        [LoginBaseUser mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"uid":@"id"};
        }];
    }
    return self;
}


@end
