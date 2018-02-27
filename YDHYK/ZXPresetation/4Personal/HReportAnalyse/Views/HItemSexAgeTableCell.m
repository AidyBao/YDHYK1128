//
//  HItemSexAgeTableCell.m
//  YDHYK
//
//  Created by screson on 2016/12/17.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HItemSexAgeTableCell.h"

@implementation HItemSexAgeTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_lbSexTitle setTextColor:[UIColor zx_textColor]];
    [_lbSexTitle setFont:[UIFont zx_titleFontWithSize:zx_title2FontSize()]];
    [_lbAgeTitle setTextColor:[UIColor zx_textColor]];
    [_lbAgeTitle setFont:[UIFont zx_titleFontWithSize:zx_title2FontSize()]];
    
    [_lbSex setTextColor:[UIColor zx_textColor]];
    [_lbSex setFont:[UIFont zx_titleFontWithSize:zx_title2FontSize()]];
    [_lbAge setTextColor:[UIColor zx_textColor]];
    [_lbAge setFont:[UIFont zx_titleFontWithSize:zx_title2FontSize()]];
    
    [_lbHLine setBackgroundColor:[UIColor zx_separatorColor]];
}

- (void)loadSexAge:(ZXPatientInfo *)patientInfo{
    [self.lbSex setText:@""];
    [self.lbAge setText:@""];
    if (patientInfo) {
        [self.lbSex setText:patientInfo.sexStr];
        [self.lbAge setText:[NSString stringWithFormat:@"%@",@(patientInfo.age)]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
