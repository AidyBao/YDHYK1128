//
//  YDRemindInfoHeaderViewCell.m
//  ydhyk
//
//  Created by screson on 2016/10/31.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDRemindInfoHeaderViewCell.h"

@interface YDRemindInfoHeaderViewCell()

@end

@implementation YDRemindInfoHeaderViewCell

+(NSString *)reuseID{
    return @"YDRemindInfoHeaderViewCell";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.medicinesName.textColor = [UIColor zx_textColor];
    [self.medicinesName setFont:[UIFont boldSystemFontOfSize:15.0]];
    self.quantityLabel.textColor = [UIColor zx_textColor];
    [self.quantityLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
}

-(void)setModel:(YDRemindTimeModel *)model{
    if (![model.drugName isKindOfClass:[NSNull class]]) {
        self.medicinesName.text = model.drugName;
    }
    
    if (![model.dosage isKindOfClass:[NSNull class]] && ![model.unit isKindOfClass:[NSNull class]]) {
        self.quantityLabel.text = [NSString stringWithFormat:@"%@ %@",model.dosage,model.unit] ;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
