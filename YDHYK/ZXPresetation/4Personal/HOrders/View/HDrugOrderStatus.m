//
//  HDrugOrderStatus.m
//  YDHYK
//
//  Created by screson on 2016/12/8.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HDrugOrderStatus.h"

@interface HDrugOrderStatus ()
{
    HDrugOrderType orderType;
}
@property (strong, nonatomic) CAGradientLayer * statusColorlayer;

@end

@implementation HDrugOrderStatus

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView *containerView = [[[UINib nibWithNibName:@"HDrugOrderStatus" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, ZX_BOUNDS_WIDTH, 144);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        [self setBackgroundColor:ZXCLEAR_COLOR];
        [containerView setBackgroundColor:ZXCLEAR_COLOR];
        
        //订单状态
        [_lbOrderStatus setFont:[UIFont zx_titleFontWithSize:zx_title1FontSize()]];
        [_lbSubInfoText setFont:[UIFont zx_titleFontWithSize:12]];
        //订单进度
        [_orderProgress setTrackTintColor:ZXRGB_COLOR(187, 191, 196)];
        [_orderProgress setProgressTintColor:[UIColor zx_tintColor]];
        
        [_lbStatus1 setFont:[UIFont zx_titleFontWithSize:13]];
        [_lbStatus1 setHighlightedTextColor:[UIColor zx_tintColor]];
        [_lbStatus1 setTextColor:ZXRGB_COLOR(187, 191, 196)];
        [_lbStatus2 setFont:[UIFont zx_titleFontWithSize:13]];
        [_lbStatus2 setHighlightedTextColor:[UIColor zx_tintColor]];
        [_lbStatus2 setTextColor:ZXRGB_COLOR(187, 191, 196)];
        [_lbStatus3 setFont:[UIFont zx_titleFontWithSize:13]];
        [_lbStatus3 setHighlightedTextColor:[UIColor zx_tintColor]];
        [_lbStatus3 setTextColor:ZXRGB_COLOR(187, 191, 196)];

        
    }
    return self;
}

- (void)loadDataByOrderInfo:(ZXOrderListModel *)orderInfo{
    orderType = orderInfo.status;
    [self.vTopStatus.layer insertSublayer:self.statusColorlayer atIndex:0];
    [self loadOrderStatusByType:orderInfo.status];
    [self loadOrderProgressByOrderType:orderInfo];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)loadOrderStatusByType:(HDrugOrderType)type{
    switch (type) {
        case HDrugOrderTypeWaitPay://待付款 Status2 中呈现
        {
        }
            break;
        case HDrugOrderTypePrepare://待备货 （下单完成）
        {
            [_lbOrderStatus setText:@"订单进行中"];
            [_lbSubInfoText setText:@"下单成功,等待店员备货"];
        }
            break;
        case HDrugOrderTypeWaitTake://待提货
        {
            [_lbOrderStatus setText:@"订单进行中"];
            [_lbSubInfoText setText:@"店员已备货,使用提货码取走您的订单药品"];
        }
            break;
        case HDrugOrderTypeWaitDispatch://待发货
        {
            [_lbOrderStatus   setText:@"订单进行中"];
            [_lbSubInfoText setText:@"下单成功,请等待店员发货"];
        }
            break;
        case HDrugOrderTypeDispatched://待收货
        {
            [_lbOrderStatus   setText:@"订单进行中"];
            [_lbSubInfoText setText:@"店员已发货,请等待收货"];
        }
            break;
        case HDrugOrderTypeDone://已完成
        {
            [_lbOrderStatus   setText:@"订单已完成"];
            [_lbSubInfoText setText:@"感谢您的光临"];
        }
            break;
        case HDrugOrderTypeCancel://已取消  Status2 中呈现
        {
        }
            break;
        case HDrugOrderTypeRefund://退款中  Status2 中呈现
        {
        }
            break;
        default:
        {
            [_lbOrderStatus   setText:@""];
            [_lbSubInfoText setText:@""];
        }
            break;
    }
}



- (void)loadOrderProgressByOrderType:(ZXOrderListModel *)model{
    [_lbStatus1  setText:@"下单成功"];
    [_lbStatus2  setText:@"已发货"];
    [_lbStatus3  setText:@"确认收货"];
    switch (model.status) {
        case HDrugOrderTypeWaitPay://待付款 Status2呈现 不会出现在这里
        {
            
        }
            break;
        case HDrugOrderTypePrepare://备货中
        {
            [_imgIcon setImage:[UIImage imageNamed:@"hOrder_waitTake_icon"]];
            [_imgStatus1 setHighlighted:true];
            [_imgStatus2 setHighlighted:false];
            [_imgStatus3 setHighlighted:false];
            
            [_lbStatus1  setHighlighted:true];
            [_lbStatus2  setHighlighted:false];
            [_lbStatus3  setHighlighted:false];
            
            if (model.receiveType == HDispatchWaySelfTake) {
                [_lbStatus2  setText:@"店员备货"];
                [_lbStatus3  setText:@"到店提货"];
            }else{
                [_lbStatus2  setText:@"已发货"];
                [_lbStatus3  setText:@"确认收货"];
            }
            
            [_orderProgress setProgress:0.25];
        }
            break;
        case HDrugOrderTypeWaitTake://待提货
        {
            [_imgIcon setImage:[UIImage imageNamed:@"hOrder_waitTake_icon"]];
            [_imgStatus1 setHighlighted:true];
            [_imgStatus2 setHighlighted:true];
            [_imgStatus3 setHighlighted:false];
            
            [_lbStatus1  setHighlighted:true];
            [_lbStatus2  setHighlighted:true];
            [_lbStatus3  setHighlighted:false];
            
            [_lbStatus2  setText:@"店员备货"];
            [_lbStatus3  setText:@"到店提货"];
            
            [_orderProgress setProgress:0.75];
        }
            break;
        case HDrugOrderTypeRefund://待付款 Status2呈现 不会出现在这里
        {
            
        }
            break;
        case HDrugOrderTypeWaitDispatch://待发货
        {
            [_imgIcon setImage:[UIImage imageNamed:@"hOrder_waitDispatch_icon"]];
            [_imgStatus1 setHighlighted:true];
            [_imgStatus2 setHighlighted:false];
            [_imgStatus3 setHighlighted:false];
            
            [_lbStatus1  setHighlighted:true];
            [_lbStatus2  setHighlighted:false];
            [_lbStatus3  setHighlighted:false];
            [_orderProgress setProgress:0.25];
        }
            break;
        case HDrugOrderTypeDispatched://待收货
        {
            [_imgIcon setImage:[UIImage imageNamed:@"hOrder_waitSign_icon"]];
            [_imgStatus1 setHighlighted:true];
            [_imgStatus2 setHighlighted:true];
            [_imgStatus3 setHighlighted:false];
            
            [_lbStatus1  setHighlighted:true];
            [_lbStatus2  setHighlighted:true];
            [_lbStatus3  setHighlighted:false];
            [_orderProgress setProgress:0.75];
        }
            break;
        case HDrugOrderTypeDone://已完成
        {
            [_imgIcon setImage:[UIImage imageNamed:@"hOrder_done_icon"]];
            [_imgStatus1 setHighlighted:true];
            [_imgStatus2 setHighlighted:true];
            [_imgStatus3 setHighlighted:true];
            
            [_lbStatus1  setHighlighted:true];
            [_lbStatus2  setHighlighted:true];
            [_lbStatus3  setHighlighted:true];
            [_orderProgress setProgress:1.0];
            if (model.receiveType == HDispatchWaySelfTake) {
                [_lbStatus2  setText:@"店员备货"];
                [_lbStatus3  setText:@"到店提货"];
            }else{
                [_lbStatus2  setText:@"已发货"];
                [_lbStatus3  setText:@"确认收货"];
            }
            
        }
            break;
        case HDrugOrderTypeCancel://已取消  Status2呈现
        {
        }
            break;
        default:
        {
            [_imgStatus1 setHighlighted:false];
            [_imgStatus2 setHighlighted:false];
            [_imgStatus3 setHighlighted:false];
            
            [_lbStatus1  setHighlighted:false];
            [_lbStatus2  setHighlighted:false];
            [_lbStatus3  setHighlighted:false];
            [_orderProgress setProgress:0];
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
        _statusColorlayer.colors = @[(__bridge id)ZXRGB_COLOR(60, 168, 240).CGColor, (__bridge id)ZXRGB_COLOR(59, 136, 238).CGColor];
    }
    return _statusColorlayer;
}

@end
