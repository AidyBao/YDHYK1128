//
//  ZXCashCouponViewModel.h
//  YDHYK
//
//  Created by screson on 2016/12/16.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXCashCouponModel.h"



@interface ZXCashCouponViewModel : NSObject


/**获取现金券列表
 * isValid 是否有效
 */
+ (void)getCashCouponListWithMemberId:(NSString *)memberId
                              isValid:(BOOL)isValid
                              pageNum:(NSInteger)pageNum
                             pageSize:(NSInteger)pageSize
                                token:(NSString *)token
                           completion:(void(^)(NSArray <ZXCashCouponModel *> * list,NSInteger totalPage,NSInteger status,BOOL success,NSString * errorMsg))completion;

//暂时没有详情页
/**获取现金券详情
 * 【其实在列表已经返回，为了后期接口减少列表项数据】
 */
+ (void)getCashCouponDetailInfoById:(NSString *)couponId
                           memberId:(NSString *)memberId
                              token:(NSString *)token
                         completion:(void(^)(ZXCashCouponModel * coupon,NSInteger status,BOOL success,NSString * errorMsg))completion;

@end
