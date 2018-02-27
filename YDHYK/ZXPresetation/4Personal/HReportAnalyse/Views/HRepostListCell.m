//
//  HRepostListCell.m
//  ydhyk
//
//  Created by screson on 2016/11/22.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "HRepostListCell.h"

@implementation HRepostListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contentView setBackgroundColor:ZXCLEAR_COLOR];
    [self setBackgroundColor:ZXCLEAR_COLOR];
    
    //
    [self.sContentView.layer setMasksToBounds:true];
    [self.sContentView.layer setCornerRadius:5.0];
    //
    [self.lbTime   setFont:[UIFont zx_titleFontWithSize:14]];
    [self.lbSex    setFont:[UIFont zx_titleFontWithSize:14]];
    [self.lbAge    setFont:[UIFont zx_titleFontWithSize:14]];
    [self.lbIssuse setFont:[UIFont zx_titleFontWithSize:14]];
    
    [self.lbTime   setTextColor:[UIColor zx_textColor]];
    [self.lbSex    setTextColor:[UIColor zx_textColor]];
    [self.lbAge    setTextColor:[UIColor zx_textColor]];
    [self.lbIssuse setTextColor:ZXWHITE_COLOR];
    
    [self.lbIssuse.layer setMasksToBounds:true];
    [self.lbIssuse.layer setCornerRadius:10];
    
    [self.imgSnap setContentMode:UIViewContentModeScaleAspectFill];
    [self.imgSnap setBackgroundColor:[UIColor zx_assistColor]];
    [self.imgSnap setClipsToBounds:true];
    [self.imgSnap.layer setBorderColor:[UIColor zx_assistColor].CGColor];
    [self.imgSnap.layer setBorderWidth:1.0];
    
    [self.imgSnap setBackgroundColor:[UIColor zx_separatorColor]];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)reloadReport:(ZXReportListModel *)model{
    [self.lbTime   setText:@""];
    [self.lbSex    setText:@""];
    [self.lbAge    setText:@""];
    [self.lbIssuse setText:@""];
    [self.imgSnap setImage:nil];
    [self loadIssuseCount:0];
    if (model) {
        [self.lbTime setText:model.dateStrDescription];
        [self.lbSex  setText:model.sexStr];
        [self.lbAge  setText:[NSString stringWithFormat:@"%@",@(model.age)]];
        [self loadIssuseCount:model.abnormalNum];
        [self.imgSnap setImageWithURL:[NSURL URLWithString:model.imgStr]];
    }
}

- (void)loadIssuseCount:(NSInteger)count{
    if (count > 0) {
        [self.lbIssuse setBackgroundColor:ZXRGBA_COLOR(255, 66, 0, 1)];
        [self.lbIssuse setText:[NSString stringWithFormat:@"%@个异常点",@(count)]];
    }else{
        [self.lbIssuse setBackgroundColor:[UIColor zx_tintColor]];
        [self.lbIssuse setText:@"无异常点"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
