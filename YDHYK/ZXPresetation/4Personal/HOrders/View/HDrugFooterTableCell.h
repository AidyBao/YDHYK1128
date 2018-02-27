//
//  HDrugFooterTableCell.h
//  YDHYK
//
//  Created by screson on 2016/12/7.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDrugOrderType.h"
#import "ZXOrderListModel.h"

@class HDrugFooterTableCell;

typedef enum : NSUInteger {
    HOrderControlActionTypeToPay,        //立即付款
    HOrderControlActionTypeCheckCode,    //查看提货码
    HOrderControlActionTypeConfirmSign,  //确认收货
    HOrderControlActionTypeCancelOrder,  //取消订单
    HOrderControlActionTypeDeleteOrder,  //删除订单
    HOrderControlActionTypeNone
} HOrderControlActionType;

@protocol HDrugFooterTableCellDelegate <NSObject>

@optional

- (void)orderControlButtonActionType:(HOrderControlActionType)type controlCell:(HDrugFooterTableCell *)cell;

@end

/**订单 总价格  订单操作*/
@interface HDrugFooterTableCell : UITableViewCell
{
    HDrugOrderType orderType;
}
@property (weak, nonatomic) IBOutlet UILabel *lbTotalPriceInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnControl1;
@property (weak, nonatomic) IBOutlet UIButton *btnControl2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidth;
@property (weak, nonatomic) IBOutlet UIView *sepLine;

@property (weak, nonatomic) id<HDrugFooterTableCellDelegate> delegate;

- (void)reloadOrderInfo:(ZXOrderListModel *)orderInfo;

@end
