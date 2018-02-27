//
//  HDrugOrderFooterNoControlTableCell.m
//  YDHYK
//
//  Created by screson on 2016/12/8.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HDrugOrderFooterNoControlTableCell.h"

@implementation HDrugOrderFooterNoControlTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_lbCouponInfo setFont:[UIFont zx_titleFontWithSize:11]];
    [_lbTotalPriceInfo setFont:[UIFont zx_titleFontWithSize:13]];

    [_lbCouponInfo setTextColor:[UIColor zx_textColor]];

    [_lbTotalPriceInfo setTextColor:[UIColor zx_textColor]];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.sepLine setBackgroundColor:[UIColor zx_separatorColor]];
}

- (void)reloadOrderInfo:(ZXOrderListModel *)orderInfo{
    [_lbTotalPriceInfo setText:@""];
    if (orderInfo) {
//        [self setOrderPriceTextWithPrice:orderInfo.payTotal goodsCount:orderInfo.goodsCount freight:orderInfo.freight];
        [_lbCouponInfo setText:[NSString stringWithFormat:@"现金券抵扣:%@元",orderInfo.couponMoney]];
        [self setOrderPriceTextWithPrice:orderInfo.payTotalStr goodsCount:[orderInfo.drugNum integerValue] freight:orderInfo.freight];
    }
}

- (void)setOrderPriceTextWithPrice:(NSString *)price goodsCount:(NSInteger)count freight:(NSString *)freight{
    NSString * strCount = [NSString stringWithFormat:@"%@",@(count)];
    NSString * strTotalPrice = [NSString stringWithFormat:@"%@",price];
    NSString * strText = [NSString stringWithFormat:@"共%@件商品,实付¥%@元(含运费%@元)",strCount,strTotalPrice,freight];
    NSMutableAttributedString * strP = [NSAttributedString zx_addFontToText:strText withFont:[UIFont zx_titleFontWithSize:16] atRange:NSMakeRange(1, strCount.length)];
    [strP zx_appendFont:[UIFont zx_titleFontWithSize:16] atRange:NSMakeRange(8 + strCount.length, strTotalPrice.length)];
    NSRange range1 = [strText rangeOfString:@"("];
    NSRange range2 = [strText rangeOfString:@")"];
    [strP zx_appendFont:[UIFont zx_titleFontWithSize:11] atRange:NSMakeRange(range1.location, range2.location - range1.location + 1)];
    [_lbTotalPriceInfo setAttributedText:strP];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
