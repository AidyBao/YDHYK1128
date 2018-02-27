//
//  HDrugOrderStatus.h
//  YDHYK
//
//  Created by screson on 2016/12/8.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDrugOrderType.h"
#import "ZXOrderListModel.h"

/**订单顶部状态 有进度*/
@interface HDrugOrderStatus : UIView
//订单状态
@property (weak, nonatomic) IBOutlet UIView *vTopStatus;
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *lbOrderStatus;//订单状态
@property (weak, nonatomic) IBOutlet UILabel *lbSubInfoText;//订单状态 详细描述

//提货、发货进度
//订单进行状态
@property (weak, nonatomic) IBOutlet UIProgressView *orderProgress;
@property (weak, nonatomic) IBOutlet ZXImageView *imgStatus1;
@property (weak, nonatomic) IBOutlet ZXImageView *imgStatus2;
@property (weak, nonatomic) IBOutlet ZXImageView *imgStatus3;

@property (weak, nonatomic) IBOutlet UILabel *lbStatus1;
@property (weak, nonatomic) IBOutlet UILabel *lbStatus2;
@property (weak, nonatomic) IBOutlet UILabel *lbStatus3;


- (void)loadDataByOrderInfo:(ZXOrderListModel *)orderInfo;

@end
