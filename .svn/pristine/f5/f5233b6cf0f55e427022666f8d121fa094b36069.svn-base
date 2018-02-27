//
//  HDrugFooterTableCell.m
//  YDHYK
//
//  Created by screson on 2016/12/7.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HDrugFooterTableCell.h"

@implementation HDrugFooterTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_lbTotalPriceInfo setFont:[UIFont zx_titleFontWithSize:13]];
    [_lbTotalPriceInfo setTextColor:[UIColor zx_textColor]];
    
    [_btnControl1.layer setCornerRadius:5];
    [_btnControl1.layer setMasksToBounds:true];
    [_btnControl1.titleLabel setFont:[UIFont zx_titleFontWithSize:14]];
    [_btnControl1.layer setBorderWidth:1.0];
    [_btnControl1 addTarget:self action:@selector(controlButton1Action) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnControl2.layer setCornerRadius:5];
    [_btnControl2.layer setMasksToBounds:true];
    [_btnControl2.titleLabel setFont:[UIFont zx_titleFontWithSize:14]];
    [_btnControl2.layer setBorderWidth:1.0];
    [_btnControl2 addTarget:self action:@selector(controlButton2Action) forControlEvents:UIControlEventTouchUpInside];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.sepLine setBackgroundColor:[UIColor zx_separatorColor]];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)reloadOrderInfo:(ZXOrderListModel *)orderInfo{
    [_lbTotalPriceInfo setText:@""];
    [_btnControl1 setHidden:true];
    [_btnControl2 setHidden:true];
    if (orderInfo) {
        [self loadOrderControlType:orderInfo.status];
        [self setOrderPriceTextWithPrice:orderInfo.originalPriceStr goodsCount:[orderInfo.drugNum integerValue] freight:orderInfo.freight];
    }
}

- (void)setOrderPriceTextWithPrice:(NSString *)price goodsCount:(NSInteger)count freight:(NSString *)freight{
    NSString * strCount = [NSString stringWithFormat:@"%@",@(count)];
    NSString * strTotalPrice = [NSString stringWithFormat:@"%@",price];
    NSString * strText = [NSString stringWithFormat:@"共%@件商品,合计¥%@元(含运费%@元)",strCount,strTotalPrice,freight];
    NSMutableAttributedString * strP = [NSAttributedString zx_addFontToText:strText withFont:[UIFont zx_titleFontWithSize:16] atRange:NSMakeRange(1, strCount.length)];
    [strP zx_appendFont:[UIFont zx_titleFontWithSize:16] atRange:NSMakeRange(8 + strCount.length, strTotalPrice.length)];
    NSRange range1 = [strText rangeOfString:@"("];
    NSRange range2 = [strText rangeOfString:@")"];
    [strP zx_appendFont:[UIFont zx_titleFontWithSize:11] atRange:NSMakeRange(range1.location, range2.location - range1.location + 1)];
    [_lbTotalPriceInfo setAttributedText:strP];
}


- (void)loadOrderControlType:(HDrugOrderType)type{
    orderType = type;
    [_btnControl1 setHidden:false];
    [_btnControl2 setHidden:false];
    _btnWidth.constant = 80;
    
    [_btnControl1 setBackgroundColor:[UIColor zx_tintColor]];
    [_btnControl1.layer setBorderColor:[UIColor zx_tintColor].CGColor];
    [_btnControl1 setTitleColor:ZXWHITE_COLOR forState:UIControlStateNormal];
    
    [_btnControl2 setBackgroundColor:ZXWHITE_COLOR];
    [_btnControl2.layer setBorderColor:[UIColor zx_tintColor].CGColor];
    [_btnControl2 setTitleColor:[UIColor zx_tintColor] forState:UIControlStateNormal];
    
    switch (orderType) {
        case HDrugOrderTypeWaitPay://待付款 (Control: 取消订单、立即付款)
        {
            [_btnControl1 setTitle:@"立即付款" forState:UIControlStateNormal];
            [_btnControl2 setTitle:@"取消订单" forState:UIControlStateNormal];
            
        }
            break;
        case HDrugOrderTypeWaitTake://待提货 (Control: 取消订单、查看提货码)
        case HDrugOrderTypeWaitDispatch://待发货 (Control: 取消订单、查看提货码)
        {
            _btnWidth.constant = 94;
            [_btnControl1 setTitle:@"查看提货码" forState:UIControlStateNormal];
            [_btnControl1 setBackgroundColor:ZXRGB_COLOR(53, 167, 144)];
            [_btnControl1.layer setBorderColor:ZXRGB_COLOR(53, 167, 144).CGColor];
            [_btnControl1 setTitleColor:ZXWHITE_COLOR forState:UIControlStateNormal];
            
            [_btnControl2 setTitle:@"取消订单" forState:UIControlStateNormal];
        }
            break;
//        case HDrugOrderTypeWaitDispatch://待发货 (Control: 取消订单、确认收货)
//        {
//            [_btnControl1 setTitle:@"取消订单" forState:UIControlStateNormal];
//            [_btnControl1 setBackgroundColor:ZXWHITE_COLOR];
//            [_btnControl1.layer setBorderColor:[UIColor zx_tintColor].CGColor];
//            [_btnControl1 setTitleColor:[UIColor zx_tintColor] forState:UIControlStateNormal];
//            [_btnControl2 setHidden:true];
//        }
//            break;
        case HDrugOrderTypeDispatched://待收货 (Control: 确认收货、查看提货码)
        {
            _btnWidth.constant = 94;
            [_btnControl1 setTitle:@"查看提货码" forState:UIControlStateNormal];
            [_btnControl1 setBackgroundColor:ZXRGB_COLOR(53, 167, 144)];
            [_btnControl1.layer setBorderColor:ZXRGB_COLOR(53, 167, 144).CGColor];
            [_btnControl1 setTitleColor:ZXWHITE_COLOR forState:UIControlStateNormal];
            
            [_btnControl2 setTitle:@"确认收货" forState:UIControlStateNormal];
        }
            break;
//        case HDrugOrderTypeDispatched://待收货 (Control: 确认收货)
//        {
//            [_btnControl1 setTitle:@"确认收货" forState:UIControlStateNormal];
//            [_btnControl2 setHidden:true];
//        }
//            break;
        case HDrugOrderTypeRefund://退款中 (Control: 无操作)
        {
            [_btnControl1 setHidden:true];
            [_btnControl2 setHidden:true];
        }
            break;
        case HDrugOrderTypePrepare://待备货 (Control: 取消订单)
        {
            [_btnControl1 setTitle:@"取消订单" forState:UIControlStateNormal];
            [_btnControl1 setBackgroundColor:ZXWHITE_COLOR];
            [_btnControl1.layer setBorderColor:[UIColor zx_tintColor].CGColor];
            [_btnControl1 setTitleColor:[UIColor zx_tintColor] forState:UIControlStateNormal];
            
            [_btnControl2 setHidden:true];

        }
            break;
        case HDrugOrderTypeDone://已完成 (Control: 删除订单)
        case HDrugOrderTypeCancel://已取消 (Control: 删除订单)
        {
            [_btnControl1 setTitle:@"删除订单" forState:UIControlStateNormal];
            [_btnControl1 setBackgroundColor:ZXWHITE_COLOR];
            [_btnControl1.layer setBorderColor:[UIColor zx_tintColor].CGColor];
            [_btnControl1 setTitleColor:[UIColor zx_tintColor] forState:UIControlStateNormal];
            
            [_btnControl2 setHidden:true];
        }
            break;
        default:
        {
            [_btnControl1 setHidden:true];
            [_btnControl2 setHidden:true];
        }
            break;
    }
}


- (void)controlButton1Action{
    HOrderControlActionType controlType = HOrderControlActionTypeNone;
    switch (orderType) {
        case HDrugOrderTypeWaitPay://待付款 (Control1:立即付款)
        {
            controlType = HOrderControlActionTypeToPay;
        }
            break;
        case HDrugOrderTypeWaitTake://待提货 (Control1:查看提货码)
        {
            controlType = HOrderControlActionTypeCheckCode;
        }
            break;
        case HDrugOrderTypeWaitDispatch://待发货 (Control1:查看提货码)
        {
            controlType = HOrderControlActionTypeCheckCode;
        }
            break;
//        case HDrugOrderTypeWaitDispatch://待发货 (Control1:删除订单)
//        {
//            controlType = HOrderControlActionTypeCancelOrder;
//        }
//            break;
        case HDrugOrderTypeDispatched://待收货 (Control1: 查看提货码)
        {
            controlType = HOrderControlActionTypeCheckCode;
        }
            break;
        case HDrugOrderTypeDone://已完成 (Control1: 删除订单)
        {
            controlType = HOrderControlActionTypeDeleteOrder;
        }
            break;
        case HDrugOrderTypeCancel://已取消 (Control1: 删除订单)
        {
            controlType = HOrderControlActionTypeDeleteOrder;
        }
            break;
        case HDrugOrderTypeRefund://退款中 (Control1: 无操作)
        {
            controlType = HOrderControlActionTypeNone;
        }
            break;
        case HDrugOrderTypePrepare://待备货 (Control1: 取消订单)
        {
            controlType = HOrderControlActionTypeCancelOrder;
        }
            break;
        default:
            break;
    }
    if (controlType != HOrderControlActionTypeNone &&
        _delegate &&
        [_delegate respondsToSelector:@selector(orderControlButtonActionType:controlCell:)]) {
        [_delegate orderControlButtonActionType:controlType controlCell:self];
    }
}

- (void)controlButton2Action{
    HOrderControlActionType controlType = HOrderControlActionTypeNone;
    switch (orderType) {
        case HDrugOrderTypeWaitPay:     //待付款 (Control2:取消订单)
        case HDrugOrderTypeWaitTake:    //待提货 (Control2:取消订单)
        case HDrugOrderTypeWaitDispatch://待发货 (Control2:取消订单)
        {
            controlType = HOrderControlActionTypeCancelOrder;
        }
            break;
//        case HDrugOrderTypeWaitDispatch://待发货 (Control2:无操作)
            
//        case HDrugOrderTypeDispatched://待收货 (Control2: 无操作)
        case HDrugOrderTypeDone:      //已完成 (Control2: 无操作)
        case HDrugOrderTypeCancel:    //已取消 (Control2: 无操作)
        case HDrugOrderTypeRefund:    //退款中 (Control2: 无操作)
        case HDrugOrderTypePrepare:   //待备货 (Control2: 无操作)
        {
            controlType = HOrderControlActionTypeNone;
        }
            break;
        case HDrugOrderTypeDispatched://待收货 (Control2: 确认收货)
        {
            controlType = HOrderControlActionTypeConfirmSign;
        }
            break;
        default:
            break;
    }
    if (controlType != HOrderControlActionTypeNone &&
        _delegate &&
        [_delegate respondsToSelector:@selector(orderControlButtonActionType:controlCell:)]) {
        [_delegate orderControlButtonActionType:controlType controlCell:self];
    }
}

@end
