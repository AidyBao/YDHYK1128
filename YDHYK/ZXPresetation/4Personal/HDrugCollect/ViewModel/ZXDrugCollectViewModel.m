//
//  ZXDrugCollectViewModel.m
//  YDHYK
//
//  Created by screson on 2016/12/27.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXDrugCollectViewModel.h"

@implementation ZXDrugCollectViewModel

+ (void)getDrugCollectListWithMemberId:(NSString *)memberId token:(NSString *)token completion:(void (^)(NSArray<ZXDrugCollectModel *> *, NSInteger, BOOL, NSString *))completion{
    
    NSMutableDictionary * dicp = [NSMutableDictionary dictionary];
    if (memberId) {
        [dicp setObject:memberId forKey:@"memberId"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_DRUGCOLLECT_LIST) params:dicp token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            id list = content[@"data"];
            NSMutableArray<ZXDrugCollectModel *> * arrList = nil;
            if ([list isKindOfClass:[NSArray class]] && [list count]) {
                arrList = [NSMutableArray array];
                for (NSDictionary * dicP in list) {
                    ZXDrugCollectModel * model = [ZXDrugCollectModel mj_objectWithKeyValues:dicP];
                    [arrList addObject:model];
                }
            }
            if (completion) {
                completion(arrList,status,success,errorMsg);
            }
        }else{
            if (completion) {
                completion(nil,status,success,errorMsg);
            }
        }
    }];
}

+ (void)deleteDrugCollectById:(NSString *)drugId memberId:(NSString *)memberId token:(NSString *)token completion:(void (^)(BOOL, NSInteger, BOOL, NSString *))completion{
    NSMutableDictionary * dicp = [NSMutableDictionary dictionary];
    
    if (drugId) {
        [dicp setObject:drugId forKey:@"memberCollectionId"];
    }
    if (memberId) {
        [dicp setObject:memberId forKey:@"memberId"];
    }
    
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_DRUGCOLLECT_DELETE) params:dicp token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
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
