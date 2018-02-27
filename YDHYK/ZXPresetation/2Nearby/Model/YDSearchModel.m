//
//  YDSearchModel.m
//  ydhyk
//
//  Created by 120v on 2016/10/31.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDSearchModel.h"
#import "LKDBTool.h"

@implementation YDSearchModel
//将key值id更换为uid
-(instancetype)init{
    if (self = [super init]) {
        [YDSearchModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"uid":@"id"};
        }];
    }
    return self;
}

//必须重写此方法
+ (NSDictionary *)describeColumnDict{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    LKDBColumnDes *account = [LKDBColumnDes new];
    account.primaryKey = YES;//是否为主键
    account.columnName = @"uid";//别名
    
    LKDBColumnDes *name = [[LKDBColumnDes alloc] initWithgeneralFieldWithAuto:NO unique:NO isNotNull:YES check:nil defaultVa:nil];
    
    LKDBColumnDes *noField = [LKDBColumnDes new];
    noField.useless = YES;
    
    [dict setObject:account forKey:@"uid"];
    [dict setObject:name forKey:@"name"];
    [dict setObject:noField forKey:@"noField"];
    
//    return @{@"account":account,@"name":name,@"noField":noField};
    return dict;
}

@end
