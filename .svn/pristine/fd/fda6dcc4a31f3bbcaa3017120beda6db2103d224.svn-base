//
//  ZXDrugNoticeControlViewModel.m
//  YDHYK
//
//  Created by screson on 2017/1/4.
//  Copyright © 2017年 screson. All rights reserved.
//

#import "ZXDrugNoticeControlViewModel.h"

@implementation ZXTakeMedicineModel

- (NSString *)dosageDesc{
    return [NSString stringWithFormat:@"%@%@",_dosage,_unit];
}

@end

@implementation ZXDrugNoticeControlViewModel

+ (void)remindLaterWithIds:(NSString *)ids memberId:(NSString *)memberId token:(NSString *)token{
    NSMutableDictionary * dicp = [NSMutableDictionary   dictionary];
    if (ids) {
        [dicp setObject:ids forKey:@"detailIds"];
    }
    if (memberId) {
        [dicp setObject:memberId forKey:@"memberId"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_REMIND_LATER) params:dicp token:token method:POST zxCompletion:nil];
}

+ (void)getMedicineListWithRemindIds:(NSString *)remindIds
                    remindDetailTime:(NSString *)remindDetailTime
                            memberId:(NSString *)memberId
                               token:(NSString *)token
                          completion:(void (^)(NSArray<ZXTakeMedicineModel *> *, NSInteger))completion{
    NSMutableDictionary * dicp = [NSMutableDictionary   dictionary];
    if (remindIds) {
        [dicp setObject:remindIds forKey:@"remindIds"];
    }
    
    if (memberId) {
        [dicp setObject:memberId forKey:@"memberId"];
    }
    if (remindDetailTime) {
        [dicp setObject:remindDetailTime forKey:@"remindDetailTime"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_TAKE_MEDICINE_LIST) params:dicp token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (success) {
            id obj = content[@"data"];
            if ([obj isKindOfClass:[NSArray class]] && [obj count]) {
                NSMutableArray<ZXTakeMedicineModel *> * mList = [NSMutableArray array];
                for (NSDictionary * drug in obj) {
                    ZXTakeMedicineModel * model = [ZXTakeMedicineModel mj_objectWithKeyValues:drug];
                    [mList addObject:model];
                }
                if (completion) {
                    completion(mList,status);
                }
            }else{
                if (completion) {
                    completion(nil,status);
                }
            }
        }else{
            if (completion) {
                completion(nil,status);
            }
        }
    }];
}

@end
