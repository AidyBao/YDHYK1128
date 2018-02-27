//
//  ZXOrderListViewModel.h
//  YDHYK
//
//  Created by screson on 2016/12/15.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXOrderListModel.h"
#import "HDrugOrderType.h"




@interface ZXOrderListViewModel : NSObject

/**获取订单列表
 * 配送方式 自提 送货上门
 * 订单状态 待取货 传 4 内部处理为“4,8” 待收货 传1 内部处理为“1,8”
 */
+ (void)getOrderListWithMemberId:(NSString *)memberId
                     dispatchWay:(HDispatchWay)dispatchWay
                       orderType:(HDrugOrderType)type
                         pageNum:(NSInteger)pageNum
                        pageSize:(NSInteger)pageSize
                           token:(NSString *)token
                      completion:(void(^)(NSArray<ZXOrderListModel *> * orderList,NSInteger totalPage,NSInteger status,BOOL success,NSString * errorMsg))completion;

+ (void)getOrderDetailInfoById:(NSString *)orderId
                      memberId:(NSString *)memberId
                         token:(NSString *)token
                    completion:(void(^)(ZXOrderListModel * orderDetail,NSInteger status,BOOL success,NSString * errorMsg))completion;

/**订单操作
 * status 0HDrugOrderTypeInvalid 6HDrugOrderTypeCancel 7HDrugOrderTypeDone
 *         删除订单 取消订单 确认收货
 */
+ (void)changeOrderStatusByID:(NSString *)orderId
                       status:(HDrugOrderType)status
                     memberId:(NSString *)memberId
                        token:(NSString *)token
                   completion:(void(^)(BOOL success,NSInteger status,BOOL apiSuccess,NSString * errorMsg))completion;

/**查看提货码*/
+ (void)browserOrderTakeCodeById:(NSString *)orderId
                        memberId:(NSString *)memberId
                           token:(NSString *)token
                      completion:(void(^)(NSString * code,UIImage * qrCode,NSInteger status,BOOL apiSuccess,NSString * errorMsg))completion;

@end
