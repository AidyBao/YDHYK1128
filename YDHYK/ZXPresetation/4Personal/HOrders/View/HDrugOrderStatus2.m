//
//  HDrugOrderStatus2.m
//  YDHYK
//
//  Created by screson on 2016/12/8.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HDrugOrderStatus2.h"


@interface HDrugOrderStatus2 ()
{
    HDrugOrderType orderType;
}
@property (strong, nonatomic) CAGradientLayer * statusColorlayer;

@end

@implementation HDrugOrderStatus2


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView *containerView = [[[UINib nibWithNibName:@"HDrugOrderStatus2" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, ZX_BOUNDS_WIDTH, 72);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        [self setBackgroundColor:ZXCLEAR_COLOR];
        [containerView setBackgroundColor:ZXCLEAR_COLOR];
        
        //订单状态
        [_lbCancelText  setFont:[UIFont zx_titleFontWithSize:zx_title1FontSize()]];
        [_lbOtherText   setFont:[UIFont zx_titleFontWithSize:zx_title1FontSize()]];
        [_lbSubInfoText setFont:[UIFont zx_titleFontWithSize:12]];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)loadOrderStatusByOrderInfo:(ZXOrderListModel *)model{
    orderType = model.status;
    [self.vTopStatus.layer insertSublayer:self.statusColorlayer atIndex:0];

    switch (model.status) {
        case HDrugOrderTypeWaitPay://待付款
        {
            [_lbCancelText  setHidden:true];
            [_lbOtherText   setHidden:false];
            [_lbSubInfoText setHidden:false];
            [_imgIcon       setImage:[UIImage imageNamed:@"hOrder_waitPay_icon"]];
            [_lbOtherText   setText:@"订单未付款"];
            [_lbSubInfoText setText:@""];
        }
            break;
        case HDrugOrderTypeWaitTake:    //待提货 Statu1 中呈现
        case HDrugOrderTypeWaitDispatch://待发货 Statu1 中呈现
        case HDrugOrderTypeDispatched:  //待收货 Statu1 中呈现
        case HDrugOrderTypePrepare:     //待备货 Statu1 中呈现
        case HDrugOrderTypeDone:        //已完成 Statu1 中呈现
        {
            [_lbOtherText   setText:@""];
            [_lbSubInfoText setText:@""];
        }
             break;
        case HDrugOrderTypeCancel://已取消
        {
            [_imgIcon       setImage:[UIImage imageNamed:@"hOrder_done_icon"]];
            [_lbCancelText  setHidden:false];
            [_lbOtherText   setHidden:true];
            [_lbSubInfoText setHidden:true];
            [_lbCancelText  setText:@"订单已取消"];
        }
            break;
        case HDrugOrderTypeRefund://退款中
        {
            [_imgIcon       setImage:[UIImage imageNamed:@"hOrder_done_icon"]];
            [_lbCancelText  setHidden:false];
            [_lbOtherText   setHidden:true];
            [_lbSubInfoText setHidden:true];
            [_lbCancelText  setText:@"订单退款中"];
        }
            break;
        default:
        {
            [_lbOtherText   setText:@""];
            [_lbSubInfoText setText:@""];
        }
            break;
    }
}


//订单状态背景色
- (CAGradientLayer *)statusColorlayer{
    if (!_statusColorlayer) {
        _statusColorlayer = [CAGradientLayer new];
        _statusColorlayer.startPoint = CGPointMake(0, 0.5);
        _statusColorlayer.endPoint = CGPointMake(1, 0.5);
        _statusColorlayer.contentsScale = [[UIScreen mainScreen] scale];
        _statusColorlayer.frame = CGRectMake(0, 0, ZX_BOUNDS_WIDTH, 72);
    }
    if (orderType == HDrugOrderTypeWaitPay) {
        _statusColorlayer.colors = @[(__bridge id)ZXRGB_COLOR(248, 160, 118).CGColor, (__bridge id)ZXRGB_COLOR(247, 140, 118).CGColor];
        
    }else{
        _statusColorlayer.colors = @[(__bridge id)ZXRGB_COLOR(60, 168, 240).CGColor, (__bridge id)ZXRGB_COLOR(59, 136, 238).CGColor];
    }
    return _statusColorlayer;
}


@end
