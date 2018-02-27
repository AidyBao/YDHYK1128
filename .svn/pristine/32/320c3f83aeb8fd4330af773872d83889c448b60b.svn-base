//
//  ZXPrescriptionViewModel.m
//  YDHYK
//
//  Created by screson on 2016/12/15.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXPrescriptionViewModel.h"

@implementation ZXPrescriptionViewModel

+ (void)getPrescriptionListWithMemberId:(NSString *)memberId pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize token:(NSString *)token completion:(void (^)(NSArray<ZXPrescriptionModel *> *, NSInteger, NSInteger, BOOL, NSString *))completion{
    NSMutableDictionary * dicp = [NSMutableDictionary dictionary];
    if (memberId) {
        [dicp setObject:memberId forKey:@"memberId"];
    }
    pageNum  = pageNum  <= 0 ? 1 : pageNum;
    pageSize = pageSize <= 0 ? 1 : pageSize;
    [dicp setObject:@(pageNum) forKey:@"pageNum"];
    [dicp setObject:@(pageSize) forKey:@"pageSize"];
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_PRESCRIPTION_LIST) params:dicp token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            NSInteger totalPage = [content[@"data"][@"pageTotal"]  integerValue];
            id list = content[@"data"][@"listData"];
            NSMutableArray<ZXPrescriptionModel *> * arrList = [NSMutableArray array];
            if ([list isKindOfClass:[NSArray class]] && [list count]) {
                for (NSDictionary * dicP in list) {
                    ZXPrescriptionModel * model = [ZXPrescriptionModel mj_objectWithKeyValues:dicP];
                    [arrList addObject:model];
                }
            }
            if (completion) {
                completion(arrList,totalPage,status,success,errorMsg);
            }
        }else{
            if (completion) {
                completion(nil,0,status,success,errorMsg);
            }
        }
    }];
}

+ (void)addPrescriptionWithMemberId:(NSString *)memberId title:(NSString *)title attachFiles:(NSString *)filesPath token:(NSString *)token completion:(void (^)(BOOL, NSInteger, BOOL, NSString *))completion{
    
    
    NSMutableDictionary * dicp = [NSMutableDictionary dictionary];
    if (title) {
        [dicp setObject:title forKey:@"title"];
    }
    if (filesPath) {
        [dicp setObject:filesPath forKey:@"attachFiles"];
    }
    if (memberId) {
        [dicp setObject:memberId forKey:@"memberId"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_PRESCRIPTION_ADD) params:dicp token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            if (completion) {
                completion(true,status,success,nil);
            }
        }else{
            if (completion) {
                completion(false,status,success,errorMsg);
            }
        }
    }];
}

+ (void)deletePrescriptionById:(NSString *)pId memberId:(NSString *)memberId token:(NSString *)token completion:(void (^)(BOOL, NSInteger, BOOL, NSString *))completion{
    
    NSMutableDictionary * dicp = [NSMutableDictionary dictionary];
    if (pId) {
        [dicp setObject:pId forKey:@"id"];
    }
    if (memberId) {
        [dicp setObject:memberId forKey:@"memberId"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_PRESCRIPTION_DELETE) params:dicp token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            if (completion) {
                completion(true,status,success,nil);
            }
        }else{
            if (completion) {
                completion(false,status,success,errorMsg);
            }
        }
    }];
}

@end
