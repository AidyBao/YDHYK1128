//
//  ZXCommonViewModel.m
//  YDHYK
//
//  Created by screson on 2016/12/16.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXCommonViewModel.h"


@implementation ZXCommonViewModel

+ (void)getAllUnReadMsgCountWithMemberId:(NSString *)memberId token:(NSString *)token completion:(void (^)(ZXAllUnReadCountModel *, NSInteger, BOOL, NSString *))completon{
    
    NSMutableDictionary * dicP = [NSMutableDictionary dictionary];
    if (memberId) {
        [dicP setObject:memberId forKey:@"memberId"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_UNREAD_MSGCOUNT) params:dicP token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            id data = content[@"data"];
            if ([data isKindOfClass:[NSDictionary class]]) {
                ZXAllUnReadCountModel * model = [ZXAllUnReadCountModel mj_objectWithKeyValues:data];
                if (completon) {
                    completon(model,status,success,errorMsg);
                }
            }else{
                if (completon) {
                    completon(nil,status,success,errorMsg);
                }
            }
        }else{
            if (completon) {
                completon(nil,status,success,errorMsg);
            }
        }
    }];
}

+ (void)getConstDicListByType:(HConstDicType)type completion:(void (^)(NSArray<ZXConstDicModel *> *, NSInteger, BOOL, NSString *))completion{
    NSMutableDictionary * dicP = [NSMutableDictionary dictionary];
    [dicP setObject:@(type) forKey:@"type"];
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_CONST_DIC_LIST) params:dicP token:nil method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            id list = content[@"data"];
            NSMutableArray<ZXConstDicModel *> * arrList = [NSMutableArray array];
            if ([list isKindOfClass:[NSArray class]] && [list count]) {
                for (NSDictionary * dic in list) {
                    ZXConstDicModel * model = [ZXConstDicModel mj_objectWithKeyValues:dic];
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

+ (void)setVoiceRemindOn:(BOOL)bOn memberId:(NSString *)memberId token:(NSString *)token completion:(void (^)(BOOL, NSString *))completion{
    NSMutableDictionary * dicP = [NSMutableDictionary dictionary];
    if (bOn) {
        [dicP setObject:@(1) forKey:@"isVoiceRemind"];
    }else{
        [dicP setObject:@(0) forKey:@"isVoiceRemind"];
    }
    if (memberId) {
        [dicP setObject:memberId forKey:@"memberId"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_VOICE_REMIND_UPDATE) params:dicP token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            if (completion) {
                completion(true,nil);
            }
        }else{
            completion(false,errorMsg);
        }
    }];
}

@end
