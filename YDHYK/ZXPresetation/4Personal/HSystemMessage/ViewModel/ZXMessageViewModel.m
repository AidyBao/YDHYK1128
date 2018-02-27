//
//  ZXMessageViewModel.m
//  YDHYK
//
//  Created by screson on 2016/12/14.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXMessageViewModel.h"

@implementation ZXMessageViewModel

+ (void)getMessageListWithMemberId:(NSString *)memberId pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize token:(NSString *)token completion:(void (^)(NSInteger, NSArray<ZXMessageSortModel *> *, NSInteger, BOOL, NSString *))completion{
    NSMutableDictionary * dicP = [NSMutableDictionary dictionary];
    if (memberId) {
        [dicP setObject:memberId forKey:@"memberId"];
    }
    if (pageNum <= 0) {
        pageNum = 1;
    }
    if (pageSize <= 0) {
        pageSize = 1;
    }
    [dicP setObject:@(pageNum)forKey:@"pageNum"];
    [dicP setObject:@(pageSize) forKey:@"pageSize"];
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_MESSAGE_LIST) params:dicP token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            NSInteger totalPage = [content[@"data"][@"pageTotal"]  integerValue];
            id list = content[@"data"][@"listData"];
            NSMutableArray<ZXMessageSortModel *> * arrList = [NSMutableArray array];
            if ([list isKindOfClass:[NSArray class]] && [list count]) {
                for (NSDictionary * dicP in list) {
                    ZXMessageSortModel * model = [ZXMessageSortModel mj_objectWithKeyValues:dicP];
                    [arrList addObject:model];
                }
            }
            if (completion) {
                completion(totalPage,arrList,status,success,errorMsg);
            }
        }else{
            if (completion) {
                completion(0,nil,status,success,errorMsg);
            }
        }
    }];
}

+ (void)getMessageDetailById:(NSString *)msgId memerbId:(NSString *)memberId type:(NSString *)type token:(NSString *)token completion:(void (^)(ZXMessageDetailModel *, NSInteger, BOOL, NSString *))completion{
    NSMutableDictionary * dicP = [NSMutableDictionary dictionary];
    if (msgId) {
        [dicP setObject:msgId forKey:@"id"];
    }
    if (type) {
        [dicP setObject:type forKey:@"type"];
    }
    if (memberId) {
        [dicP setObject:memberId forKey:@"memberId"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_MESSAGE_DETAIL) params:dicP token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            id msg = content[@"data"];
            if ([msg isKindOfClass:[NSDictionary class]] && [msg count]) {
                ZXMessageDetailModel * model = [[ZXMessageDetailModel alloc] init];
                [model setValuesForKeysWithDictionary:msg];
                if (completion) {
                    completion(model,status,success,errorMsg);
                }
            }else{
                if (completion) {
                    completion(nil,status,success,errorMsg);
                }
            }
        }else{
            if (completion) {
                completion(nil,status,success,errorMsg);
            }
        }
    }];
    
}

@end
