//
//  HDugCollectTaTableCell.m
//  YDHYK
//
//  Created by screson on 2016/12/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HDugCollectTaTableCell.h"


@implementation HDugCollectTaTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_imgDrugIcon setBackgroundColor:[UIColor zx_separatorColor]];
    [_imgDrugIcon.layer setBorderColor:[UIColor zx_separatorColor].CGColor];
    [_imgDrugIcon.layer setBorderWidth:1.0];
    
    [_lbDrugName setFont:[UIFont zx_titleFontWithSize:zx_title2FontSize()]];
    [_lbDrugName setTextColor:[UIColor zx_textColor]];
    
    [_lbDrugSpec setFont:[UIFont zx_titleFontWithSize:13]];
    [_lbDrugSpec setTextColor:[UIColor zx_sub2TextColor]];
    
    [_lbPrice setFont:[UIFont zx_titleFontWithSize:zx_title2FontSize() + 1]];
    [_lbPrice setTextColor:ZXRGB_COLOR(245, 92, 30)];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)reloadDrugCollectInfo:(ZXDrugCollectModel *)drugModel{
    [_imgDrugIcon setImage:nil];
    [_lbDrugName setText:@""];
    [_lbDrugSpec setText:@""];
    [_lbPrice    setText:@""];
    if (drugModel) {
        [_imgDrugIcon setImageWithURL:[NSURL URLWithString:drugModel.attachFilesStr]];
        NSMutableString * name = [NSMutableString stringWithFormat:@" %@",drugModel.drugName];
//        if ([drugModel.manufacturer isKindOfClass:[NSString class]] && drugModel.manufacturer.length) {
//            [name insertString:[NSString stringWithFormat:@" %@",drugModel.manufacturer] atIndex:0];
//        }
        [self setDrugName:name type:drugModel.drugType];
        
        [_lbDrugSpec setText:drugModel.packingSpec];
        [_lbPrice    setText:[NSString stringWithFormat:@"¥%0.2f",[drugModel.price floatValue]]];
    }
}

- (void)setDrugName:(NSString *)name type:(ZXDrugType)type{
    [_lbDrugSpec setText:@""];
    if (name) {
        NSTextAttachment *attachment = [[NSTextAttachment alloc]initWithData:nil ofType:nil];
        
        UIImage * image = [UIImage imageNamed:@"otc"];
        if (type == ZXDrugTypeRX) {
            image = [UIImage imageNamed:@"rx"];
        }
        attachment.image = image;
        attachment.bounds = CGRectMake(0, -3, 31, 15);
        NSAttributedString * textImg = [NSAttributedString attributedStringWithAttachment:attachment];
        NSMutableAttributedString *rep = [NSAttributedString zx_addFontToText:[NSString stringWithFormat:@" %@",name] withFont:[UIFont zx_titleFontWithSize:zx_title2FontSize()] atRange:NSMakeRange(0, name.length)];
        [rep insertAttributedString:textImg atIndex:0];
        [_lbDrugName setAttributedText:rep];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
