//
//  ZXMessageViewModel.h
//  YDHYK
//
//  Created by screson on 2016/12/14.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXMessageSortModel.h"
#import "ZXMessageDetailModel.h"



@interface ZXMessageViewModel : NSObject

/**获取消息列表*/
+ (void)getMessageListWithMemberId:(NSString *)memberId
                           pageNum:(NSInteger)pageNum
                          pageSize:(NSInteger)pageSize
                             token:(NSString *)token
                        completion:(void(^)(NSInteger totalPage,NSArray<ZXMessageSortModel *> * msgList,NSInteger status,BOOL success,NSString * errorMsg))completion;
/**获取消息详细内容*/
+ (void)getMessageDetailById:(NSString *)msgId
                    memerbId:(NSString *)memberId
                        type:(NSString *)type
                       token:(NSString *)token
                  completion:(void(^)(ZXMessageDetailModel * model,NSInteger status,BOOL success,NSString * errorMsg))completion;

@end
