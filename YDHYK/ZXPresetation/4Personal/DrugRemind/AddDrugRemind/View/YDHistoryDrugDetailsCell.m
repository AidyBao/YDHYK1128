//
//  YDHistoryDrugDetailsCell.m
//  ydhyk
//
//  Created by screson on 2016/10/28.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDHistoryDrugDetailsCell.h"

@implementation YDHistoryDrugDetailsCell
+(NSString *)reuseID{
    return @"YDHistoryDrugDetailsCell";
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.detailLabel.textColor = [UIColor zx_textColor];
}

-(void)setModel:(YDSubHistoryOrderModel *)model{
    _model = model;
    self.detailLabel.text = model.drugName;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
