//
//  HItemSelectTableCell.m
//  YDHYK
//
//  Created by screson on 2016/12/13.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HItemSelectTableCell.h"

@implementation HItemSelectTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_lbItemName setFont:[UIFont zx_titleFontWithSize:zx_title2FontSize()]];
    [_lbItemName setTextColor:[UIColor zx_textColor]];
    [_lbItemName setHighlightedTextColor:[UIColor zx_tintColor]];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [_imgCheck   setHidden:true];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (_needHighlight) {
        if (selected) {
            [_lbItemName setHighlighted:true];
            [_imgCheck   setHidden:false];
        }else{
            [_lbItemName setHighlighted:false];
            [_imgCheck   setHidden:true];
        }
    }else{
        [_lbItemName setHighlighted:false];
        [_imgCheck   setHidden:true];
    }
}

@end
