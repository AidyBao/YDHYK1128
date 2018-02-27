//
//  HDrugRemidTableViewCell.m
//  YDHYK
//
//  Created by screson on 2016/12/26.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HDrugRemidTableViewCell.h"

@implementation HDrugRemidTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.contentView setBackgroundColor:ZXCLEAR_COLOR];
    [self setBackgroundColor:ZXCLEAR_COLOR];
    
    [_lbDrugName setFont:[UIFont zx_titleFontWithSize:15]];
    [_lbDrugName setTextColor:[UIColor zx_textColor]];
    
    [_lbQuantity setFont:[UIFont zx_titleFontWithSize:15]];
    [_lbQuantity setTextColor:[UIColor zx_textColor]];
    
    [_lbRemark   setFont:[UIFont zx_titleFontWithSize:12]];
    [_lbRemark   setTextColor:[UIColor zx_sub2TextColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)reloadViewDrugModel:(ZXTakeMedicineModel *)model{
    [_lbDrugName setText:@""];
    [_lbQuantity setText:@""];
    [_lbRemark   setText:@""];
    if (model) {
        if ([model.notes isKindOfClass:[NSString class]] && model.notes.length) {
            [self sethasRemark:true];
            [_lbRemark setText:model.notes];
        }else{
            [self sethasRemark:false];
        }
        [_lbDrugName setText:model.drugName];
        [_lbQuantity setText:model.dosageDesc];
    }
}

- (void)sethasRemark:(BOOL)bRemark{
    if (!bRemark) {
        [self.lbRemark setHidden:true];
        self.topOffset.constant = 12;
    }else{
        [self.lbRemark setHidden:false];
        self.topOffset.constant = 5;
    }
}

@end
