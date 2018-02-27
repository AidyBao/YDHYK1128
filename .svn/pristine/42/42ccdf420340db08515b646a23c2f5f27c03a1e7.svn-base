//
//  ZXJoinMemberViewModel.h
//  YDHYK
//
//  Created by screson on 2016/12/12.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXDrugStoreModel.h"



@interface ZXJoinMemberViewModel : NSObject


/**
 加入会员

 @param storeId         店铺Id
 @param memberId        会员Id
 @param userId          推荐人Id
 @param token           token description
 @param completion      completion description
 */
+ (void)joinMemberToStore:(NSString *)storeId
                 location:(CLLocation *)location
                 memberId:(NSString *)memberId
                   userId:(NSString *)userId
                    token:(NSString *)token
               completion:(void(^)(BOOL isNew,NSInteger status, BOOL success, NSString *errorMsg))completion;


/**
 是否门店会员

 @param storeId storeId description
 @param memberId memberId description
 @param token token description
 @param completion completion description
 */
+ (void)isStoreMember:(NSString *)storeId
             memberId:(NSString *)memberId
                token:(NSString *)token
           completion:(void (^)(BOOL isMember, NSString * storeName, BOOL success))completion;

/**获取药店详情*/
+ (void)getDrugStoreDetailsByID:(NSString *)storeId
                       memberId:(NSString *)memberId
                          token:(NSString *)token
                     completion:(void(^)(ZXDrugStoreModel * drugStore,NSInteger status, BOOL success, NSString *errorMsg))completion;

/**新加入的会员 关联该店铺历史现金券 接口失败不做二次处理*/
+ (void)getStoreHistoryCashCouponById:(NSString *)storeId
                             memberId:(NSString *)memberId
                                token:(NSString *)token;

/**新加入的会员 关联该店铺历史促销信息 接口失败不做二次处理*/
+ (void)getStoreHistoryPromotionById:(NSString *)storeId
                            memberId:(NSString *)memberId
                               token:(NSString *)token;
@end
