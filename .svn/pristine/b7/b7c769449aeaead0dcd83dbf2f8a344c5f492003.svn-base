//
//  HSmartToolsCell.m
//  YDHYK
//
//  Created by JuanFelix on 02/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "HSmartToolsCell.h"

@interface HSmartToolsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgLeftIcon;
@property (weak, nonatomic) IBOutlet UIImageView *imgRightIcon;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbSubTitleInfo;
@property (weak, nonatomic) IBOutlet UIView *zxContentView;

@end

@implementation HSmartToolsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setBackgroundColor:ZXCLEAR_COLOR];
    [self.contentView setBackgroundColor:ZXCLEAR_COLOR];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self.zxContentView.layer setShadowRadius:10];
    [self.zxContentView.layer setShadowOffset:CGSizeMake(0, 5)];
    [self.zxContentView.layer setShadowOpacity:0.25];
    [self.zxContentView.layer setCornerRadius:5.0];
    
    
    [self.lbTitle setFont:[UIFont zx_titleFontWithSize:20]];
    [self.lbTitle setTextColor:[UIColor zx_textColor]];
    

    [_imgLeftIcon setImage:[UIImage imageNamed:@"h_icon-clock"]];
    [_imgRightIcon setImage:[UIImage imageNamed:@"h_smartTool1"]];
    [self.lbSubTitleInfo setFont:[UIFont zx_bodyFontWithSize:13]];
    [self.lbSubTitleInfo setTextColor:[UIColor zx_sub1TextColor]];
}

- (void)loadDataByIndex:(NSInteger)index{
    if (index == 0) {
        [_lbTitle setText:@"用药提醒"];
        [_lbSubTitleInfo setText:@"定个时间，我们会提醒您按时服药"];
        [_imgLeftIcon setImage:[UIImage imageNamed:@"h_icon-clock"]];
        [_imgRightIcon setImage:[UIImage imageNamed:@"h_smartTool1"]];
    }else{
        [_lbTitle setText:@"化验单分析"];
        [_lbSubTitleInfo setText:@"扫描化验单，分析项目的异常情况"];
        [_imgLeftIcon setImage:[UIImage imageNamed:@"h_icon-list"]];
        [_imgRightIcon setImage:[UIImage imageNamed:@"h_smartTool2"]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
