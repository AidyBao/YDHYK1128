//
//  HItemResultTableCell.m
//  YDHYK
//
//  Created by screson on 2016/12/17.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HItemResultTableCell.h"

@implementation HItemResultTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_lbItemName setTextColor:[UIColor zx_textColor]];
    [_lbItemName setFont:[UIFont zx_titleFontWithSize:zx_title1FontSize()]];
    
    [_lbRefrenceValue setTextColor:[UIColor zx_textColor]];
    [_lbRefrenceValue setFont:[UIFont zx_titleFontWithSize:zx_title2FontSize()]];

    [_lbResultValue setTextColor:[UIColor zx_textColor]];
    [_lbResultValue setHighlightedTextColor:[UIColor zx_customBColor]];
    [_lbResultValue setFont:[UIFont zx_titleFontWithSize:zx_title2FontSize()]];
    
    [_lbUnUsualDesc setTextColor:ZXWHITE_COLOR];
    [_lbUnUsualDesc setBackgroundColor:[UIColor zx_customBColor]];
    [_lbUnUsualDesc setFont:[UIFont zx_titleFontWithSize:11]];
    [_lbUnUsualDesc setHidden:true];
}

- (void)reloadItemData:(ZXItemShortModel *)model{
    if (model) {
        [_lbItemName      setText:model.itemName];
        [_lbRefrenceValue setText:model.referenceValue];
        [_lbResultValue   setText:model.checkValue];
        if (model.isAbnormal) {
            [_lbUnUsualDesc setHidden:false];
            if (model.abnormalStatus.length <= 1) {
                _abnormalVWidth.constant = 30;
            }else{
                _abnormalVWidth.constant = 44;
            }
            [_lbUnUsualDesc setText:model.abnormalStatus];
            [_lbResultValue setHighlighted:true];
            _nameOffsetToRefrenceValue.constant = 50;
        }else{
            [_lbUnUsualDesc setHidden:true];
            [_lbUnUsualDesc setText:@""];
            [_lbResultValue setHighlighted:false];
            _nameOffsetToRefrenceValue.constant = 6;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
