//
//  HDrugTableCell.m
//  YDHYK
//
//  Created by screson on 2016/12/7.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HDrugTableCell.h"

@implementation HDrugTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contentView setBackgroundColor:ZXWHITE_COLOR];
    
    [_imgDrugIcon setBackgroundColor:[UIColor zx_separatorColor]];
    [_imgDrugIcon.layer setBorderWidth:1.0];
    [_imgDrugIcon.layer setBorderColor:[UIColor zx_separatorColor].CGColor];
    
    [_lbDrugName setFont:[UIFont zx_titleFontWithSize:zx_title2FontSize()]];
    [_lbDrugName setTextColor:[UIColor zx_textColor]];
    
    [_lbBuyCount setFont:[UIFont zx_bodyFontWithSize:zx_title2FontSize()]];
    [_lbBuyCount setTextColor:[UIColor zx_textColor]];
    
    [_lbPrice    setFont:[UIFont zx_bodyFontWithSize:zx_title2FontSize()]];
    [_lbPrice    setTextColor:[UIColor zx_textColor]];
    
    [_lbDrugSpec setFont:[UIFont zx_titleFontWithSize:13]];
    [_lbDrugSpec setTextColor:[UIColor zx_sub2TextColor]];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)reloadGoodsInfo:(ZXGoodsModel *)goodsInfo{
    [_imgDrugIcon setImage:nil];
    [_lbDrugName setText:@""];
    [_lbDrugSpec setText:@""];
    [_lbBuyCount setText:@""];
    [_lbPrice setText:@""];
    if (goodsInfo) {
        [_imgDrugIcon setImageWithURL:[NSURL URLWithString:goodsInfo.attachFilesStr] placeholderImage:nil];
        [_lbDrugName setText:goodsInfo.drugName];
        [_lbDrugSpec setText:goodsInfo.packingSpec];
        [_lbPrice    setText:[NSString stringWithFormat:@"¥%@",goodsInfo.priceStr]];
        [_lbBuyCount setText:[NSString stringWithFormat:@"x%@",goodsInfo.num]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
