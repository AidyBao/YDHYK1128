//
//  YDMedicineDetailTableViewCell.m
//  ydhyk
//
//  Created by 120v on 2016/10/28.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDMedicineDetailTableViewCell.h"

@interface YDMedicineDetailTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *noteLabel;

@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopConstraint;

@end

@implementation YDMedicineDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if (self.noteLabel.text.length == 0) {
        self.titleTopConstraint.constant = 20;
    }
}

-(void)setModel:(YDRemindTimeModel *)model{
    _model = model;
    if (model.drugName) {
        self.titleLabel.text = model.drugName;
    }
    if (model.notes) {
        self.noteLabel.text = model.notes;
    }

    if (model.dosage && model.unit) {
        self.quantityLabel.text = [NSString stringWithFormat:@"%@ %@",model.dosage,model.unit];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
