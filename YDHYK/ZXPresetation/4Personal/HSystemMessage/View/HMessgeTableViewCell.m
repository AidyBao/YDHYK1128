//
//  HMessgeTableViewCell.m
//  YDHYK
//
//  Created by screson on 2016/12/9.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HMessgeTableViewCell.h"

@implementation HMessgeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_lbTitle setFont:[UIFont zx_titleFontWithSize:zx_title1FontSize()]];
    [_lbTitle setTextColor:[UIColor zx_sub1TextColor]];
    [_lbTitle setHighlightedTextColor:[UIColor zx_textColor]];
    
    [_lbMessageContent setFont:[UIFont zx_titleFontWithSize:13]];
    [_lbMessageContent setTextColor:[UIColor zx_sub1TextColor]];
    
    
    [_lbTime setFont:[UIFont zx_titleFontWithSize:13]];
    [_lbTime setTextColor:[UIColor zx_sub2TextColor]];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)isNewMessage:(BOOL)iNew{
    if (iNew) {
        [_vUnReadDot  setHidden:false];
        [_lbTitle     setHighlighted:true];
        [_titleOffset setConstant:40];
    }else{
        [_vUnReadDot  setHidden:true];
        [_lbTitle     setHighlighted:false];
        [_titleOffset setConstant:20];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
