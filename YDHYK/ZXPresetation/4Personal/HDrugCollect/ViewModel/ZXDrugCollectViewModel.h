//
//  ZXDrugCollectViewModel.h
//  YDHYK
//
//  Created by screson on 2016/12/27.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXDrugCollectModel.h"

@interface ZXDrugCollectViewModel : NSObject

//后台表结构不支持分组，不分页了
/**获取收藏药品列表*/
+ (void)getDrugCollectListWithMemberId:(NSString *)memberId
                                 token:(NSString *)token
                            completion:(void(^)(NSArray<ZXDrugCollectModel *> * list,NSInteger status,BOOL success,NSString * errorMsg))completion;

/**删除收藏药品*/
+ (void)deleteDrugCollectById:(NSString *)drugId
                     memberId:(NSString *)memberId
                        token:(NSString *)token
                   completion:(void(^)(BOOL success,NSInteger status,BOOL reqSuccess,NSString * errorMsg))completion;

@end
