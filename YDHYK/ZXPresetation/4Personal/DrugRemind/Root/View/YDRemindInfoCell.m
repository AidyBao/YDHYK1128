//
//  YDRemindInfoCell.m
//  ydhyk
//
//  Created by screson on 2016/10/31.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDRemindInfoCell.h"
@interface YDRemindInfoCell()

@end
@implementation YDRemindInfoCell
+(NSString *)reuseID{
    return @"YDRemindInfoCell";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
    self.titleLabel.textColor = [UIColor zx_textColor];
    self.descLabel.textColor = [UIColor zx_sub2TextColor];
}

-(void)setModel:(YDDrugRemindModel *)model{
    _model = model;
    self.titleLabel.text = model.drugName;
    self.descLabel.text = model.remindContent;
    if (model.isPush.integerValue == 1) {
        [self.remindSwitch setOn:YES];
    }else if (model.isPush.integerValue == 0){
        [self.remindSwitch setOn:NO];;
    }
}

#pragma mark - 通知开关
- (IBAction)turnOn:(UISwitch *)sender {
    if ([self.delegate respondsToSelector:@selector(didYDRemindInfoCell:withModel:)]) {
        [self.delegate didYDRemindInfoCell:sender withModel:self.model];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
