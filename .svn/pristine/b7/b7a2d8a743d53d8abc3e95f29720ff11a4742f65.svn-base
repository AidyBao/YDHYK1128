//
//  YDOneCardTableViewCell.m
//  ydhyk
//
//  Created by 120v on 2016/11/1.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDOneCardTableViewCell.h"

@interface YDOneCardTableViewCell()

@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UIImageView *companyIcon;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponLabel;

@end

@implementation YDOneCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = ZXRGB_COLOR(62, 140, 240);
    
    [self.companyIcon.layer setCornerRadius:self.companyIcon.size.height*0.5];
    [self.companyIcon.layer setMasksToBounds:YES];
    
    [self.buyButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [self.buyButton setImageEdgeInsets:UIEdgeInsetsMake(0, self.buyButton.titleLabel.bounds.size.width + 40, 0, -self.buyButton.titleLabel.bounds.size.width - 40)];
}


-(void)setModel:(YDQueryMemberCardModel *)model{
    _model = model;
    if (model.headPortraitStr) {
        [self.companyIcon setImageWithURL:[NSURL URLWithString:model.headPortraitStr] placeholderImage:nil];
    }
    if (model.drugstoreName) {
        self.companyName.text = [NSString stringWithFormat:@"%@",model.drugstoreName];
    }
    
    if (model.integral) {
        self.integralLabel.text = [NSString stringWithFormat:@"积分：%zd分",model.integral.integerValue];
    }
    
    if (model.couponNum) {
        self.couponLabel.text = [NSString stringWithFormat:@"现金券：%@张",model.couponNum];
    }
}

#pragma mark - 电话
- (IBAction)telButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectedOneCardViewWithTelphoneButton:)]) {
        [self.delegate didSelectedOneCardViewWithTelphoneButton:sender];
    }
}

#pragma mark - 购药
- (IBAction)buyButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectedOneCardViewWithBuyButton:)]) {
        [self.delegate didSelectedOneCardViewWithBuyButton:sender];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(didOneCardViewWithTouchBegin:withEvent:)]) {
        [self.delegate didOneCardViewWithTouchBegin:touches withEvent:event];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
