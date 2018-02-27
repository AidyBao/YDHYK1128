//
//  ZXCommonViewModel.h
//  YDHYK
//
//  Created by screson on 2016/12/16.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXAllUnReadCountModel.h"
#import "ZXConstDicModel.h"






@interface ZXCommonViewModel : NSObject

/**获取所有角标信息*/
+ (void)getAllUnReadMsgCountWithMemberId:(NSString *)memberId
                                   token:(NSString *)token
                              completion:(void(^)(ZXAllUnReadCountModel * model,NSInteger status,BOOL success,NSString * errorMsg))completon;

/**获取数据字典*/
+ (void)getConstDicListByType:(HConstDicType)type
                   completion:(void(^)(NSArray<ZXConstDicModel *> * list,NSInteger status ,BOOL success,NSString * errorMsg))completion;

/**打开关闭语音提醒*/
+ (void)setVoiceRemindOn:(BOOL)bOn
                memberId:(NSString *)memberId
                   token:(NSString *)token
              completion:(void(^)(BOOL success,NSString *errorMsg))completion;
@end
