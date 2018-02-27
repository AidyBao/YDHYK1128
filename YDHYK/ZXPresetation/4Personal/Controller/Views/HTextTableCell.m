//
//  HTextTableCell.m
//  YDHYK
//
//  Created by JuanFelix on 05/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "HTextTableCell.h"

@interface HTextTableCell ()

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbExtralInfo;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrow;

@end

@implementation HTextTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [_lbTitle setFont:[UIFont zx_titleFontWithSize:zx_title1FontSize()]];
    [_lbTitle setTextColor:[UIColor zx_textColor]];
    [_lbExtralInfo setFont:[UIFont zx_titleFontWithSize:13]];
    [_lbExtralInfo setTextColor:ZXRGB_COLOR(153, 153, 153)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitle:(NSString *)title extralInfo:(NSString *)extralInfo showArrow:(BOOL)showArrow{
    [_lbTitle setText:title];
    [_lbExtralInfo setText:extralInfo];
    [_imgArrow setHidden:!showArrow];
}

@end
