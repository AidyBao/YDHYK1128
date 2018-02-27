//
//  HDrugHeaderTableCell.m
//  YDHYK
//
//  Created by screson on 2016/12/7.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HDrugHeaderTableCell.h"

@implementation HDrugHeaderTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_imgStoreIcon setBorderColor:[UIColor zx_separatorColor]];
    [_imgStoreIcon setBackgroundColor:[UIColor zx_separatorColor]];
    [_lbStoreName  setFont:[UIFont zx_titleFontWithSize:zx_title2FontSize()]];
    [_lbStoreName  setTextColor:[UIColor zx_textColor]];
    [_lbOrderStatus  setFont:[UIFont zx_titleFontWithSize:zx_title1FontSize()]];
    [_lbOrderStatus  setTextColor:[UIColor zx_tintColor]];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self.sepLine setBackgroundColor:[UIColor zx_separatorColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)reloadStoreInfo:(ZXOrderListModel *)orderInfo{
    [_imgStoreIcon setImage:nil];
    [_lbStoreName  setText:@""];
    [_lbOrderStatus  setText:@""];
    if (orderInfo) {
        [self reloadTitleWithOrderType:orderInfo.status];
        [_imgStoreIcon setImageWithURL:[NSURL URLWithString:orderInfo.headPortraitStr] placeholderImage:nil];
        [_lbStoreName  setText:orderInfo.drugstoreName];
    }
}

- (void)reloadTitleWithOrderType:(HDrugOrderType)type{
    switch (type) {
        case HDrugOrderTypeWaitPay://待付款
        {
            [_lbOrderStatus setText:@"待付款"];
        }
            break;
        case HDrugOrderTypeWaitTake://待提货
        {
            [_lbOrderStatus setText:@"待提货"];
        }
            break;
        case HDrugOrderTypeWaitDispatch://待发货
        {
            [_lbOrderStatus setText:@"待发货"];
        }
            break;
        case HDrugOrderTypeDispatched://待收货
        {
            [_lbOrderStatus setText:@"待收货"];
        }
            break;
        case HDrugOrderTypeRefund://退款中
        {
            [_lbOrderStatus setText:@"退款中"];
        }
            break;
        case HDrugOrderTypeDone://已完成
        {
            [_lbOrderStatus setText:@"已完成"];
        }
            break;
        case HDrugOrderTypeCancel://已取消
        {
            [_lbOrderStatus setText:@"已取消"];
        }
            break;
        case HDrugOrderTypePrepare://备货中
        {
            [_lbOrderStatus setText:@"待备货"];
        }
            break;
        default:
        {
            [_lbOrderStatus setText:@""];
        }
            break;
    }

}

@end
