//
//  HCheckItemTableCell.m
//  YDHYK
//
//  Created by screson on 2016/12/12.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HCheckItemTableCell.h"

@implementation HCheckItemTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_lbItemName setFont:[UIFont zx_titleFontWithSize:zx_title2FontSize()]];
    [_lbItemName setTextColor:[UIColor zx_textColor]];
    [_lbItemName setHighlightedTextColor:[UIColor zx_tintColor]];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    if (selected) {
        [_lbItemName setHighlighted:true];
        [_imgCheck   setHighlighted:true];
    }else{
        [_lbItemName setHighlighted:false];
        [_imgCheck   setHighlighted:false];
    }
}

@end
