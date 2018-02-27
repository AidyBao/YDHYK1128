//
//  ZXDrugNoticeControlViewModel.h
//  YDHYK
//
//  Created by screson on 2017/1/4.
//  Copyright © 2017年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXTakeMedicineModel : NSObject

@property (nonatomic,copy)   NSString * drugName;//药品名称
@property (nonatomic,strong) NSNumber * dosage;//用量
@property (nonatomic,copy)   NSString * unit;//单位
@property (nonatomic,copy)   NSString * notes;//备注
@property (nonatomic,copy)   NSString * detailId;

/**用量*/
- (NSString *)dosageDesc;

@end

@interface ZXDrugNoticeControlViewModel : NSObject


/**
 * 稍后提醒
 * ids 多个id逗号分隔
 * 不处理异常情况
 */
+ (void)remindLaterWithIds:(NSString *)ids
                  memberId:(NSString *)memberId
                     token:(NSString *)token;

/*
 *通过用药提醒获取用药列表
 */
+ (void)getMedicineListWithRemindIds:(NSString *)remindIds
                    remindDetailTime:(NSString *)remindDetailTime
                            memberId:(NSString *)memberId
                               token:(NSString *)token
                          completion:(void(^)(NSArray<ZXTakeMedicineModel *> * list,NSInteger status))completion;

@end
