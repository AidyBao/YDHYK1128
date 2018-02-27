//
//  ZXCashCouponViewModel.m
//  YDHYK
//
//  Created by screson on 2016/12/16.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXCashCouponViewModel.h"

@implementation ZXCashCouponViewModel

+ (void)getCashCouponListWithMemberId:(NSString *)memberId isValid:(BOOL)isValid pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize token:(NSString *)token completion:(void (^)(NSArray<ZXCashCouponModel *> *, NSInteger, NSInteger, BOOL, NSString *))completion{
    NSMutableDictionary * dicp = [NSMutableDictionary dictionary];
    if (memberId) {
        [dicp setObject:memberId forKey:@"memberId"];
    }
    pageNum  = pageNum  <= 0 ? 1 : pageNum;
    pageSize = pageSize <= 0 ? 1 : pageSize;
    [dicp setObject:@(pageNum) forKey:@"pageNum"];
    [dicp setObject:@(pageSize) forKey:@"pageSize"];
    if (isValid) {
        [dicp setObject:@"0" forKey:@"isValid"];
    }else{
        [dicp setObject:@"1" forKey:@"isValid"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_CASHCOUPON_LIST) params:dicp token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            NSInteger totalPage = [content[@"data"][@"pageTotal"]  integerValue];
            id list = content[@"data"][@"listData"];
            NSMutableArray<ZXCashCouponModel *> * arrList = [NSMutableArray array];
            if ([list isKindOfClass:[NSArray class]] && [list count]) {
                for (NSDictionary * dicP in list) {
                    ZXCashCouponModel * model = [ZXCashCouponModel mj_objectWithKeyValues:dicP];
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

+ (void)getCashCouponDetailInfoById:(NSString *)couponId memberId:(NSString *)memberId token:(NSString *)token completion:(void (^)(ZXCashCouponModel *, NSInteger, BOOL, NSString *))completion{
    
    
    NSMutableDictionary * dicp = [NSMutableDictionary dictionary];
    if (memberId) {
        [dicp setObject:memberId forKey:@"memberId"];
    }
    if (couponId) {
        [dicp setObject:couponId forKey:@"couponId"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_CASHCOUPON_DETAIL) params:dicp token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            id coupon = content[@"data"];
            if ([coupon isKindOfClass:[NSDictionary class]] && [coupon count]) {
                ZXCashCouponModel * model = [ZXCashCouponModel mj_objectWithKeyValues:coupon];
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
