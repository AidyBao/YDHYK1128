//
//  ZXOrderListModel.h
//  YDHYK
//
//  Created by screson on 2016/12/15.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXGoodsModel.h"
#import "HDrugOrderType.h"

@interface ZXOrderListModel : NSObject

@property (nonatomic,copy) NSString * orderId;
@property (nonatomic,copy) NSString * drugstoreName;   //药店名称
@property (nonatomic,copy) NSString * drugstoreId;     //店铺wed id
@property (nonatomic,copy) NSString * drugstoreTel;    //店铺电话
@property (nonatomic,copy) NSString * headPortraitStr; //药店Logo
@property (nonatomic,copy) NSString * statusStr;       //订单状态
@property (nonatomic,assign) HDrugOrderType status;        //0作废 1待发货 2待支付 3已发货 4待取货 5退款中 6已关闭 7已完成 8备货中
//@property (nonatomic,copy) NSString * payTotal;
@property (nonatomic,copy) NSString * payTotalStr;//实付金额
@property (nonatomic,copy) NSString * originalPriceStr;//总金额
@property (nonatomic,copy) NSString * freight;
@property (nonatomic,copy) NSString * couponMoney;
@property (nonatomic,strong) NSArray<ZXGoodsModel *> * orderDetailList;

//MARK:支付-提货 信息
@property (nonatomic,assign) HDispatchWay receiveType;//送货方式 
@property (nonatomic,copy) NSString * consignee;//收货人
@property (nonatomic,copy) NSString * tel;      //联系电话
@property (nonatomic,copy) NSString * address;  //地址
@property (nonatomic,copy) NSString * drugstoreAddress;//店铺地址  自提订单显示
@property (nonatomic,copy) NSString * orderNo;  //订单编号
@property (nonatomic,copy) NSString * paymentMethodStr;//支付方式
@property (nonatomic,copy) NSString * receiveTypeStr;  //配送方式
@property (nonatomic,copy) NSString * orderDateStr;    //下单时间 字符串
@property (nonatomic,strong) NSNumber * orderDate;       //下单时间

@property (nonatomic,strong) NSNumber * drugNum; //订单总数

//MAKR:调整
//@property (nonatomic,assign) NSInteger goodsCount;
@property (nonatomic,copy)   NSString * webStoreURL;
@property (nonatomic,copy)   NSString * expiredDateStr;//未支付订单过期描述 【默认24小时有效期】

@end
