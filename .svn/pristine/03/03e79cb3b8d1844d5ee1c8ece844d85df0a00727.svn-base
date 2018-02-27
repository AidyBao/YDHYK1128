//
//  HCashCouponTableCell.m
//  YDHYK
//
//  Created by screson on 2016/12/9.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HCashCouponTableCell.h"

@implementation HCashCouponTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setBackgroundColor:ZXCLEAR_COLOR];
    [self.contentView setBackgroundColor:ZXCLEAR_COLOR];
    [self.vContentBackView setBackgroundColor:ZXWHITE_COLOR];
    [self.vContentBackView.layer setShadowRadius:1];
    [self.vContentBackView.layer setShadowOffset:CGSizeMake(0, 1)];
    [self.vContentBackView.layer setShadowOpacity:0.25];
    [self.vContentBackView.layer setCornerRadius:5];
    
    [_imgStoreIcon setBackgroundColor:[UIColor zx_separatorColor]];
    [_imgStoreIcon.layer setBorderColor:[UIColor zx_separatorColor].CGColor];
    [_imgStoreIcon.layer setBorderWidth:1.0];
    
    [_lbStoreName setFont:[UIFont zx_titleFontWithSize:13]];
    [_lbStoreName setTextColor:[UIColor zx_sub2TextColor]];//过期  颜色
    [_lbStoreName setHighlightedTextColor:[UIColor zx_textColor]];//未过期 颜色
    
    [_lbCashCouponPrice setFont:[UIFont zx_titleFontWithSize:22]];
    [_lbCashCouponPrice setTextColor:[UIColor zx_sub2TextColor]];//过期  颜色
    [_lbCashCouponPrice setHighlightedTextColor:[UIColor zx_textColor]];//未过期 颜色
    
    [_lbExsprieDate setFont:[UIFont zx_titleFontWithSize:13]];
    [_lbExsprieDate setTextColor:[UIColor zx_sub2TextColor]];
    
    [_sLine setBackgroundColor:[UIColor zx_separatorColor]];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
}

- (void)reloadCashCouponInfo:(ZXCashCouponModel *)coupon expired:(BOOL)expired{
    [_imgStoreIcon setImage:nil];
    [_lbStoreName setText:@""];
    [_lbExsprieDate setText:@""];
    [_lbCashCouponPrice setText:@""];
    if (coupon) {
        [_imgStoreIcon setImageWithURL:[NSURL URLWithString:coupon.headPortraitStr]];
        if (!expired) {//未失效
            [_lbStoreName       setHighlighted:true];
            [_lbCashCouponPrice setHighlighted:true];
            [_lbExsprieDate     setText:coupon.expiredDesc];
            
            [_lbStoreName setText:coupon.couponGroupName];
            [_lbExsprieDate setText:coupon.expiredDesc];
            [_lbCashCouponPrice setText:coupon.couponDescription];
        }else{//已失效
            [_lbStoreName       setHighlighted:false];
            [_lbCashCouponPrice setHighlighted:false];
            if (coupon.isUse) {//已使用
                [_lbExsprieDate     setText:@"已使用"];
                [_lbStoreName setText:coupon.couponGroupName];
                [_lbCashCouponPrice setText:coupon.couponDescription];
            }else{//已过期
                [_lbExsprieDate     setText:@"已过期"];
                [_lbStoreName setText:coupon.couponGroupName];
                [_lbCashCouponPrice setText:coupon.couponDescription];
            }
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
