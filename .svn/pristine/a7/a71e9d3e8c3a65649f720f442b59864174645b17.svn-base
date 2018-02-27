//
//  HCashCouponTableCell.h
//  YDHYK
//
//  Created by screson on 2016/12/9.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXCashCouponModel.h"

/**现金券*/
@interface HCashCouponTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *vContentBackView;
@property (weak, nonatomic) IBOutlet ZXImageView *imgStoreIcon;//店铺图片
@property (weak, nonatomic) IBOutlet UILabel *lbStoreName;//店铺名称
@property (weak, nonatomic) IBOutlet UILabel *lbCashCouponPrice;//现金券价格
@property (weak, nonatomic) IBOutlet UILabel *lbExsprieDate;//过期时间
@property (weak, nonatomic) IBOutlet UIView *sLine;


- (void)reloadCashCouponInfo:(ZXCashCouponModel *)coupon expired:(BOOL)expired;

@end
