//
//  HDiscoverCellType2.m
//  YDHYK
//
//  Created by JuanFelix on 29/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "HDiscoverCellType2.h"
#import "ZXDiscoverModel.h"

@interface HDiscoverCellType2 ()
{
    __weak IBOutlet UILabel *lbTitle;    //新闻标题
    __weak IBOutlet UILabel *lbType;     //新闻类型
    __weak IBOutlet UILabel *lbMediaName;//药店、媒体名称
    __weak IBOutlet UIImageView *imgHeader;//标题图片
}
@end

@implementation HDiscoverCellType2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [lbTitle setFont:[UIFont boldSystemFontOfSize:zx_title1FontSize()]];
    [lbTitle setTextColor:[UIColor zx_textColor]];
    [lbType setFont:[UIFont zx_titleFontWithSize:zx_bodyFontSize() - 1]];
    [lbType setTextColor:[UIColor zx_tintColor]];
    [lbMediaName setFont:[UIFont zx_titleFontWithSize:zx_bodyFontSize() - 1]];
    [lbMediaName setTextColor:[UIColor lightGrayColor]];
    [imgHeader setBackgroundColor:[UIColor zx_separatorColor]];
    [self clearText];
}

- (void)clearText{
    
    lbTitle.text = @"";
    lbType.text  = @"";
    lbMediaName.text = @"";
    imgHeader.image  = nil;
}

- (void)reloadData:(ZXDiscoverModel *)model{
    [self clearText];
    if (model) {
        lbTitle.text = model.title;
        lbType.text  = model.promotionTypeStr;
        lbMediaName.text = model.groupName;
        [imgHeader setImageWithURL:[NSURL URLWithString:model.homeIconStr]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
