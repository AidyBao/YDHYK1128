//
//  HToolsMenuCollectionCell.m
//  YDHYK
//
//  Created by JuanFelix on 05/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "HToolsMenuCollectionCell.h"

@interface HToolsMenuCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgType;
@property (weak, nonatomic) IBOutlet UILabel *lbToolName;
@property (weak, nonatomic) IBOutlet ZXLabel *lbUnReadMsg;


@end

@implementation HToolsMenuCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setBackgroundColor:ZXWHITE_COLOR];
    [_lbToolName setFont:[UIFont zx_titleFontWithSize:14]];
    [_lbToolName setTextColor:[UIColor zx_textColor]];
    [_lbUnReadMsg setFont:[UIFont zx_titleFontWithSize:12]];
    [_lbUnReadMsg setBackgroundColor:[UIColor zx_customBColor]];
}

- (void)setTitle:(NSString *)title image:(NSString *)image{
    [_lbToolName setText:title];
    [_imgType setImage:[UIImage imageNamed:image]];
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
