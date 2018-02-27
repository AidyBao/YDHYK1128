//
//  HDrugOrderType.h
//  YDHYK
//
//  Created by screson on 2016/12/7.
//  Copyright © 2016年 screson. All rights reserved.
//

#ifndef HDrugOrderType_h
#define HDrugOrderType_h


//0作废 1待发货 2待支付 3已发货 4待取货 5退款中 6已关闭 7已完成'
typedef enum : NSUInteger {
    HDrugOrderTypeInvalid      = 0, /*已作废*/
    HDrugOrderTypeWaitDispatch = 1, /*待发货*/
    HDrugOrderTypeWaitPay      = 2, /*待支付*/
    HDrugOrderTypeDispatched   = 3, /*已发货-UI待收货*/
    HDrugOrderTypeWaitTake     = 4, /*待取货-自提*/
    HDrugOrderTypeRefund       = 5, /*退款中 暂无*/
    HDrugOrderTypeCancel       = 6, /*已关闭 - UI已取消*/
    HDrugOrderTypeDone         = 7, /*已完成*/
    HDrugOrderTypePrepare      = 8, /*备货中*/
    HDrugOrderTypeAll               /*全部订单*/
} HDrugOrderType;

typedef enum : NSUInteger {
    HDispatchWayExpress  = 1,      /*送货上门*/
    HDispatchWaySelfTake = 2,      /*自提*/
    HDispatchWayAll                /*All*/
} HDispatchWay;

#endif /* HDrugOrderType_h */
