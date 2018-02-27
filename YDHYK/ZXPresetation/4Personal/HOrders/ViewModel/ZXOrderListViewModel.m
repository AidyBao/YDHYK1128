//
//  ZXOrderListViewModel.m
//  YDHYK
//
//  Created by screson on 2016/12/15.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXOrderListViewModel.h"
#import "Base64.h"

@implementation ZXOrderListViewModel

+(void)getOrderListWithMemberId:(NSString *)memberId dispatchWay:(HDispatchWay)dispatchWay orderType:(HDrugOrderType)type pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize token:(NSString *)token completion:(void (^)(NSArray<ZXOrderListModel *> *, NSInteger, NSInteger, BOOL, NSString *))completion{
    
    NSMutableDictionary * dicP = [NSMutableDictionary dictionary];
    if (memberId) {
        [dicP setObject:memberId forKey:@"memberId"];
    }
    //提货方式
    if (dispatchWay != HDispatchWayAll) {
        [dicP setObject:@(dispatchWay) forKey:@"receiveType"];
    }
    //全部订单 提货方式 或不传
//    else{
//        [dicP setObject:@"1,2" forKey:@"receiveType"];
//    }
    //订单状态
    if (type != HDrugOrderTypeAll) {
        if (type == HDrugOrderTypeWaitTake) {
            [dicP setObject:@"4,8" forKey:@"status"];
        }else if (type == HDrugOrderTypeWaitDispatch){
            [dicP setObject:@"1,8" forKey:@"status"];
        }else{
            [dicP setObject:@(type) forKey:@"status"];
        }
    }
    pageNum  = pageNum <= 0 ? 1 : pageNum;
    pageSize = pageSize <= 0 ? 1 : pageSize;
    [dicP setObject:@(pageNum) forKey:@"pageNum"];
    [dicP setObject:@(pageSize) forKey:@"pageSize"];
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_ORDER_LIST) params:dicP token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            NSInteger totalPage = [content[@"data"][@"pageTotal"]  integerValue];
            id list = content[@"data"][@"listData"];
            NSMutableArray<ZXOrderListModel *> * arrList = [NSMutableArray array];
            if ([list isKindOfClass:[NSArray class]] && [list count]) {
                for (NSDictionary * dicP in list) {
                    ZXOrderListModel * model = [ZXOrderListModel mj_objectWithKeyValues:dicP];
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

+ (void)getOrderDetailInfoById:(NSString *)orderId memberId:(NSString *)memberId token:(NSString *)token completion:(void (^)(ZXOrderListModel *, NSInteger, BOOL, NSString *))completion{

    NSMutableDictionary * dicP = [NSMutableDictionary dictionary];
    if (orderId) {
        [dicP setObject:orderId forKey:@"orderId"];
    }
    if (memberId) {
        [dicP setObject:memberId forKey:@"memberId"];
    }
    
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_ORDER_DETAIL) params:dicP token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            id order = content[@"data"];
            if ([order isKindOfClass:[NSDictionary class]] && [order count]) {
                ZXOrderListModel * model = [ZXOrderListModel mj_objectWithKeyValues:order];
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

+ (void)changeOrderStatusByID:(NSString *)orderId status:(HDrugOrderType)status memberId:(NSString *)memberId token:(NSString *)token completion:(void (^)(BOOL, NSInteger, BOOL, NSString *))completion{
    
    NSMutableDictionary * dicP = [NSMutableDictionary dictionary];
    if (orderId) {
        [dicP setObject:orderId forKey:@"orderId"];
    }
    if (memberId) {
        [dicP setObject:memberId forKey:@"memberId"];
    }
    [dicP setObject:@(status) forKey:@"status"];
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_ORDER_UPDATE) params:dicP token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            if (completion) {
                completion(true,status,success,errorMsg);
            }
        }else{
            if (completion) {
                completion(false,status,success,errorMsg);
            }
        }
    }];
}

+ (void)browserOrderTakeCodeById:(NSString *)orderId memberId:(NSString *)memberId token:(NSString *)token completion:(void (^)(NSString *, UIImage *, NSInteger, BOOL, NSString *))completion{
    NSMutableDictionary * dicP = [NSMutableDictionary dictionary];
    if (orderId) {
        [dicP setObject:orderId forKey:@"orderId"];
    }
    if (memberId) {
        [dicP setObject:memberId forKey:@"memberId"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_ORDER_VIEWCODE) params:dicP token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            id code = content[@"code"];//二维码code verificateCode不需要
            if ([code isKindOfClass:[NSNumber class]]) {
                code = [code stringValue];
            }
            if ([code isKindOfClass:[NSString class]] &&
                [code length]) {
                NSString * str = content[@"qrCode"];
                NSData   * data = [str base64DecodedData];
                UIImage  * image = [[UIImage alloc] initWithData:data];
                if (completion) {
                    completion(code,image,status,success,errorMsg);
                }
            }else{
                if (completion) {
                    completion(nil,nil,status,success,errorMsg);
                }
            }
        }else{
            if (completion) {
                completion(nil,nil,status,success,errorMsg);
            }
        }
    }];
}

@end
