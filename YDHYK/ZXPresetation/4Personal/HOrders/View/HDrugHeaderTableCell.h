//
//  HDrugHeaderTableCell.h
//  YDHYK
//
//  Created by screson on 2016/12/7.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDrugOrderType.h"
#import "ZXOrderListModel.h"

/**订单 店铺信息*/
@interface HDrugHeaderTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet ZXImageView *imgStoreIcon;//店铺图标
@property (weak, nonatomic) IBOutlet UILabel *lbStoreName;//店铺名称
@property (weak, nonatomic) IBOutlet UILabel *lbOrderStatus;//订单状态
@property (weak, nonatomic) IBOutlet UIView *sepLine;

- (void)reloadStoreInfo:(ZXOrderListModel *)orderInfo;

@end
