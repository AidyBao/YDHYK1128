//
//  HDiscoverCollectionViewCell.m
//  ZXStructure
//
//  Created by JuanFelix on 2016/11/28.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HDiscoverCollectionViewCell.h"

@implementation HDiscoverCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setBackgroundColor:ZXCLEAR_COLOR];
    [self.contentView setBackgroundColor:ZXCLEAR_COLOR];
    [self.lbTitle setFont:[UIFont zx_titleFontWithSize:zx_title2FontSize()]];
}

@end
