//
//  ZXJoinMemberViewModel.m
//  YDHYK
//
//  Created by screson on 2016/12/12.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXJoinMemberViewModel.h"

@implementation ZXJoinMemberViewModel

+ (void)joinMemberToStore:(NSString *)storeId
                 location:(CLLocation *)location
                 memberId:(NSString *)memberId
                   userId:(NSString *)userId
                    token:(NSString *)token
               completion:(void (^)(BOOL, NSInteger, BOOL, NSString *))completion{
    
    NSMutableDictionary * dicP = [NSMutableDictionary dictionary];
    if (memberId) {
        [dicP setObject:memberId forKey:@"memberId"];
    }
    if (storeId) {
        [dicP setObject:storeId forKey:@"drugstoreId"];
    }
    if (userId && userId.length > 0) {
        [dicP setObject:userId forKey:@"userId"];
    }
    if (location) {
        if (location.coordinate.latitude <= 0 && location.coordinate.longitude <= 0) {
            [dicP setObject:@(ZX_LATITUDE)  forKey:@"joinLatitude"];
            [dicP setObject:@(ZX_LONGITUDE) forKey:@"joinLongitude"];
        }else{
            [dicP setObject:@(location.coordinate.latitude)  forKey:@"joinLatitude"];
            [dicP setObject:@(location.coordinate.longitude) forKey:@"joinLongitude"];
        }
    }else{
        [dicP setObject:@(ZX_LATITUDE)  forKey:@"joinLatitude"];
        [dicP setObject:@(ZX_LONGITUDE) forKey:@"joinLongitude"];
    }
    
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_JOINMEMBER) params:dicP token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            if (completion) {
                completion([content[@"data"][@"isNew"] boolValue],status,success,errorMsg);
            }
        }else{
            if (completion) {
                completion(false,status,success,errorMsg);
            }
        }
    }];
}

+ (void)isStoreMember:(NSString *)storeId
             memberId:(NSString *)memberId
                token:(NSString *)token
           completion:(void (^)(BOOL, NSString *, BOOL))completion{
    NSMutableDictionary * dicP = [NSMutableDictionary dictionary];
    if (memberId) {
        [dicP setObject:memberId forKey:@"memberId"];
    }
    if (storeId) {
        [dicP setObject:storeId forKey:@"drugstoreId"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_ISSTOREMEMBER) params:dicP token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            if (completion) {
                NSDictionary * dicPStore = content[@"data"];
                if ([dicPStore isKindOfClass:[NSDictionary class]]) {
                    if (completion) {
                        completion([dicPStore[@"isDrugstoreMember"] boolValue],dicPStore[@"drugstore"][@"name"],true);
                    }
                }else{
                    if (completion) {
                        completion(false,@"",false);
                    }
                }
            }
        }else{
            if (completion) {
                completion(false,@"",false);
            }
        }
    }];
}

+ (void)getDrugStoreDetailsByID:(NSString *)storeId
                       memberId:(NSString *)memberId
                          token:(NSString *)token
                     completion:(void (^)(ZXDrugStoreModel *, NSInteger, BOOL, NSString *))completion{
    NSMutableDictionary * dicP = [NSMutableDictionary dictionary];
    if (memberId) {
        [dicP setObject:memberId forKey:@"memberId"];
    }
    if (storeId) {
        [dicP setObject:storeId forKey:@"drugstoreId"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_DRUGSTORE_DETAIL) params:dicP token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            if (completion) {
                NSDictionary * dicPStore = content[@"data"];
                if ([dicPStore isKindOfClass:[NSDictionary class]]) {
                    ZXDrugStoreModel * store = [ZXDrugStoreModel mj_objectWithKeyValues:dicPStore];
                    if (completion) {
                        completion(store,status,success,errorMsg);
                    }
                }else{
                    if (completion) {
                        completion(nil,status,success,errorMsg);
                    }
                }
            }
        }else{
            if (completion) {
                completion(nil,status,success,errorMsg);
            }
        }
    }];
}

+ (void)getStoreHistoryCashCouponById:(NSString *)storeId memberId:(NSString *)memberId token:(NSString *)token{
    NSMutableDictionary * dicP = [NSMutableDictionary dictionary];
    if (memberId) {
        [dicP setObject:memberId forKey:@"memberId"];
    }
    if (storeId) {
        [dicP setObject:storeId forKey:@"drugstoreId"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_FETCH_CASHCOUNPON) params:dicP token:token method:POST zxCompletion:nil];
}

+ (void)getStoreHistoryPromotionById:(NSString *)storeId memberId:(NSString *)memberId token:(NSString *)token{
    NSMutableDictionary * dicP = [NSMutableDictionary dictionary];
    if (memberId) {
        [dicP setObject:memberId forKey:@"memberId"];
    }
    if (storeId) {
        [dicP setObject:storeId forKey:@"drugstoreId"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_FETCH_PROMOTION) params:dicP token:token method:POST zxCompletion:nil];
}

@end
