//
//  ZXDiscoverViewModel.m
//  YDHYK
//
//  Created by JuanFelix on 01/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "ZXDiscoverViewModel.h"
#import "ZXDiscoverModel.h"

@implementation ZXDiscoverViewModel

+ (void)testLogin:(ZXRequestCompletion)completion{
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(@"member/login") params:@{@"tel":@"13856895689"} token:nil method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (completion) {
            completion(content,status,success,errorMsg);
        }
    }];
}

+ (void)loadDiscoverListByMemberId:(NSString *)memberId
                           pageNum:(NSInteger)pageNum
                          pageSize:(NSInteger)pageSize
                             token:(NSString *)token
                      zxCompletion:(ZXDiscoverCompletion)zxCompletion{
    NSMutableDictionary * dicP = [NSMutableDictionary dictionary];
    if (memberId) {
        [dicP setObject:memberId forKey:@"memberId"];
    }
    pageNum  = pageNum  <= 0 ? 1 : pageNum;
    pageSize = pageSize <= 0 ? ZXPAGE_SIZE : pageSize;
    [dicP setObject:@(pageNum) forKey:@"pageNum"];
    [dicP setObject:@(pageSize) forKey:@"pageSize"];
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_DISCOVER_LIST) params:dicP token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            id obj = content[@"data"][@"listData"];
            if ([obj isKindOfClass:[NSArray class]]) {
                NSMutableArray<ZXDiscoverModel *> * arrLists = [NSMutableArray array];
                for (NSDictionary * dicP in obj) {
                    ZXDiscoverModel * model = [ZXDiscoverModel mj_objectWithKeyValues:dicP];
                    [arrLists addObject:model];
                }
                if (zxCompletion) {
                    zxCompletion(arrLists,[content[@"data"][@"pageTotal"] integerValue],status,success,errorMsg);
                }
            }else{
                if (zxCompletion) {
                    zxCompletion(nil,0,status,success,errorMsg);
                }
            }
        }else{
            if (zxCompletion) {
                zxCompletion(nil,0,status,success,errorMsg);
            }
        }
    }];
}

+ (void)loadDiscoverDetailByPromotionId:(NSString *)pID
                               memberId:(NSString *)memberId
                                  token:(NSString *)token
                           zxCompletion:(void (^)(ZXDiscoverModel *, NSInteger, BOOL, NSString *))zxCompletion{
    NSMutableDictionary * dicP = [NSMutableDictionary dictionary];
    if (pID) {
        [dicP setObject:pID forKey:@"promotionId"];
    }
    if (memberId) {
        [dicP setObject:memberId forKey:@"memberId"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_DISCOVER_DETAIL) params:dicP token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            id obj = content[@"data"];
            if ([obj isKindOfClass:[NSDictionary class]]) {
                    ZXDiscoverModel * model = [ZXDiscoverModel mj_objectWithKeyValues:obj];
                if (zxCompletion) {
                    zxCompletion(model,status,success,errorMsg);
                }
            }else{
                if (zxCompletion) {
                    zxCompletion(nil,status,success,errorMsg);
                }
            }
        }else{
            if (zxCompletion) {
                zxCompletion(nil,status,success,errorMsg);
            }
        }
    }];
}

@end
