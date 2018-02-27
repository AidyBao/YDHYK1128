//
//  HPrescriptionTableCell.m
//  YDHYK
//
//  Created by screson on 2016/12/8.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HPrescriptionTableCell.h"

@implementation HPrescriptionTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_imgPrescription setBackgroundColor:[UIColor zx_separatorColor]];
    [_lbTitle setFont:[UIFont zx_titleFontWithSize:zx_title1FontSize()]];
    [_lbTitle setTextColor:[UIColor zx_textColor]];
    [_lbTime  setFont:[UIFont zx_titleFontWithSize:11]];
    [_lbTime  setTextColor:[UIColor zx_sub1TextColor]];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
}

- (void)reloadPrescriptionData:(ZXPrescriptionModel *)model{
    [_lbTime  setText:@""];
    [_lbTitle setText:@""];
    [_imgPrescription setImage:nil];
    if (model) {
        [_lbTime   setText:model.uploadDateStr];
        [_lbTitle  setText:model.title];
        [_imgPrescription setImageWithURL:[NSURL URLWithString:model.attachFilesStr]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
