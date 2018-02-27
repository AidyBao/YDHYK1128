//
//  HDrugTableCell.h
//  YDHYK
//
//  Created by screson on 2016/12/7.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDrugOrderType.h"
#import "ZXGoodsModel.h"

/**订单 某一项药品信息*/
@interface HDrugTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgDrugIcon;//图片
@property (weak, nonatomic) IBOutlet UILabel *lbDrugName;//名称
@property (weak, nonatomic) IBOutlet UILabel *lbDrugSpec;//规格
@property (weak, nonatomic) IBOutlet UILabel *lbBuyCount;//数量
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;   //单价


- (void)reloadGoodsInfo:(ZXGoodsModel *)goodsInfo;

@end
