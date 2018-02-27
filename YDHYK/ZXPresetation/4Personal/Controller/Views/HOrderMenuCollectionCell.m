//
//  HOrderMenuCollectionCell.m
//  YDHYK
//
//  Created by JuanFelix on 05/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "HOrderMenuCollectionCell.h"

@interface HOrderMenuCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgOrderType;//图片
@property (weak, nonatomic) IBOutlet UILabel *lbOrderType;//文字
@property (weak, nonatomic) IBOutlet ZXLabel *lbUnReadMsg;//未读消息条数

@end

@implementation HOrderMenuCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_lbOrderType setFont:[UIFont zx_titleFontWithSize:13]];
    [_lbOrderType setTextColor:[UIColor zx_textColor]];
    [_lbUnReadMsg setFont:[UIFont zx_titleFontWithSize:12]];
    [_lbUnReadMsg setBackgroundColor:[UIColor zx_customBColor]];
}

- (void)setTitle:(NSString *)title image:(NSString *)image{
    [_lbOrderType setText:title];
    [_imgOrderType setImage:[UIImage imageNamed:image]];
}

- (void)setUNReadMessageCount:(NSInteger)count{
    if (count <= 0 ) {
        [_lbUnReadMsg setHidden:true];
    }else{
        [_lbUnReadMsg setHidden:false];
        [_lbUnReadMsg setText:[NSString stringWithFormat:@"%@",@(count)]];
    }
}

@end
