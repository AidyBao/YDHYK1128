//
//  YDSettinDrugTimeCollectionViewCell.m
//  YDHYK
//
//  Created by 120v on 2016/12/16.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "YDSettinDrugTimeCollectionViewCell.h"

@interface YDSettinDrugTimeCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *drugTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addTimeLabel;


@end

@implementation YDSettinDrugTimeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.layer setCornerRadius:14.0];
    [self.layer setMasksToBounds:YES];
}

-(void)setModel:(YDAddDrugTimeModel *)model{
    _model = model;
    if (model.drugTime) {
        NSString *timeStr = [model.drugTime substringWithRange:NSMakeRange(11, 5)];
        self.drugTimeLabel.text = timeStr;
    }
    
    if (model.addTime) {
        self.addTimeLabel.text =[NSString stringWithFormat:@"第%zd次",model.addTime.integerValue];
    }
}

@end
