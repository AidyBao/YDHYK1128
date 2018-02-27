//
//  HDrugOrderStatus2.h
//  YDHYK
//
//  Created by screson on 2016/12/8.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDrugOrderType.h"
#import "ZXOrderListModel.h"
/**订单顶部状态 无进度（待付款、已取消、退款中）*/
@interface HDrugOrderStatus2 : UIView

@property (weak, nonatomic) IBOutlet UIView *vTopStatus;
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *lbCancelText; //订单已取消
@property (weak, nonatomic) IBOutlet UILabel *lbOtherText;  //其他状态
@property (weak, nonatomic) IBOutlet UILabel *lbSubInfoText;//其他状态 详细描述


- (void)loadOrderStatusByOrderInfo:(ZXOrderListModel *)model;

@end
