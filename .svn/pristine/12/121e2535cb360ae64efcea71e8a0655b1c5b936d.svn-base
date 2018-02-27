//
//  BuyRootTableViewCell.m
//  ydhyk
//
//  Created by 120v on 2016/10/24.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "BuyRootTableViewCell.h"

@interface BuyRootTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UIImageView *companyIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UILabel *integralsLable;
@property (weak, nonatomic) IBOutlet UILabel *ticketLable;
@property (weak, nonatomic) IBOutlet UIButton *telephoneButton;
@property (weak, nonatomic) IBOutlet UIView *separateLine;


@end

@implementation BuyRootTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.backView.layer.cornerRadius = 10.0;
    self.backView.layer.masksToBounds = YES;
    
    [self.companyIcon.layer setCornerRadius:self.companyIcon.size.height*0.5];
    [self.companyIcon.layer setMasksToBounds:YES];
    
    self.contentView.backgroundColor = [UIColor zx_assistColor];
    
    [self.buyButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [self.buyButton setImageEdgeInsets:UIEdgeInsetsMake(0, self.buyButton.titleLabel.bounds.size.width + 40, 0, -self.buyButton.titleLabel.bounds.size.width - 40)];
   
    
}

-(void)setCellIndex:(NSInteger)cellIndex{
    _cellIndex = cellIndex;
        if (cellIndex % 2) {
            self.backImageView.image = [UIImage imageNamed:@"Backboard-blue"];
        }else if (cellIndex %3) {
            self.backImageView.image = [UIImage imageNamed:@"Backboard-green"];
        }else{
            self.backImageView.image = [UIImage imageNamed:@"Backboard-deep-blue"];
        }
}


-(void)setModel:(YDQueryMemberCardModel *)model{
    _model = model;
    if (model.headPortraitStr) {
        [self.companyIcon setImageWithURL:[NSURL URLWithString:model.headPortraitStr] placeholderImage:nil];
    }
    if (model.drugstoreName) {
        self.nameLable.text = [NSString stringWithFormat:@"%@",model.drugstoreName];
    }
    
    if (model.integral) {
        self.integralsLable.text = [NSString stringWithFormat:@"积分：%zd 分",model.integral.integerValue];
    }
    
    if (model.couponNum) {
        self.ticketLable.text = [NSString stringWithFormat:@"现金券：%@ 张",model.couponNum];
    }
    
    
}

- (IBAction)buyButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectedBuyRootCellWithBuyButtonClick:withModel:)]) {
        [self.delegate didSelectedBuyRootCellWithBuyButtonClick:sender withModel:self.model];
    }
}

- (IBAction)telephoneButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectedBuyRootCellWithTelButtonClick:withModel:)]) {
        [self.delegate didSelectedBuyRootCellWithTelButtonClick:sender withModel:self.model];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



@end
