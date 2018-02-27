//
//  YDDetailCollectionViewCell.m
//  ydhyk
//
//  Created by 120v on 2016/10/26.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDDetailCollectionViewCell.h"

@interface YDDetailCollectionViewCell()
/** 加入会员*/
@property (weak, nonatomic) IBOutlet UIButton *joinMemberButton;
/** 垂直分割线*/
@property (weak, nonatomic) IBOutlet UIView *verticalSeparateLine;
/** 水平分割线*/
@property (weak, nonatomic) IBOutlet UIView *horizontalSeparateLine;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *navButton;
@property (weak, nonatomic) IBOutlet UIButton *telButton;

@property (weak, nonatomic) IBOutlet UIView *buyBackView;
@property (weak, nonatomic) IBOutlet UILabel *buyLabel;


@end

@implementation YDDetailCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    self.titleLabel.textColor = [UIColor zx_textColor];
    
    [self.iconImageView.layer setCornerRadius:self.iconImageView.size.height*0.5];
    [self.iconImageView.layer setMasksToBounds:YES];
    
    [self.buyBackView setHidden:TRUE];
    [self.buyLabel setFont:[UIFont zx_titleFontWithSize:14.0]];
    
    self.joinMemberButton.backgroundColor = [UIColor zx_buttonBGNormalColor];
    self.joinMemberButton.layer.cornerRadius = 5.0;
    self.joinMemberButton.layer.masksToBounds = YES;
    [self.joinMemberButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.joinMemberButton.titleLabel setFont:[UIFont zx_titleFontWithSize:14.0]];
    
    self.verticalSeparateLine.backgroundColor = ZXRGB_COLOR(234, 238, 244);
    self.horizontalSeparateLine.backgroundColor = ZXRGB_COLOR(234, 238, 244);
    self.verticalSeparateLine.alpha = 0.6;
    self.horizontalSeparateLine.alpha = 0.6;
    
    [self.navButton setTitleColor:[UIColor zx_sub1TextColor] forState:UIControlStateNormal];
    [self.telButton setTitleColor:[UIColor zx_sub1TextColor] forState:UIControlStateNormal];
    
}


-(void)setModel:(YDSearchModel *)model{
    _model = model;
    
    if (model.headPortraitStr) {
        NSURL *iconUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.headPortraitStr]];
        [self.iconImageView setImageWithURL:iconUrl placeholderImage:nil];
    }
    
    if (model.name) {
        self.titleLabel.text = model.name;
    }
    
    if (model.distance == nil && model.address == nil) {
        self.addressLabel.text =[NSString stringWithFormat:@"%@ %@",@"",@""];
    }else if (model.distance == nil) {
        self.addressLabel.text =[NSString stringWithFormat:@"%@ %@",@"",model.address];
    }else if(model.address == nil){
        self.addressLabel.text =[NSString stringWithFormat:@"%@ %@",model.distance,@""];
    }else{
        self.addressLabel.text =[NSString stringWithFormat:@"%@ %@",model.distance,model.address];
    }
    
    if (model.isMember.integerValue == 1){//会员
        [self.joinMemberButton setHidden:TRUE];
        [self.buyBackView setHidden:FALSE];
        [self.buyLabel setTextColor:[UIColor zx_tintColor]];
        self.joinMemberButton.backgroundColor = [UIColor whiteColor];
    }else{//非会员
        [self.buyBackView setHidden:TRUE];
        [self.joinMemberButton setHidden:FALSE];
        [self.joinMemberButton setTitle:@"加入会员" forState:UIControlStateNormal];
        [self.joinMemberButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.joinMemberButton.backgroundColor = [UIColor whiteColor];
        self.joinMemberButton.backgroundColor = [UIColor zx_buttonBGNormalColor];
    }
}

- (IBAction)buyBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectedJoinMemberButton:withDataModel:)]) {
        [self.delegate didSelectedJoinMemberButton:sender withDataModel:self.model];
    }
}


/** 加入会员按钮*/
- (IBAction)joinMemberClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(didSelectedJoinMemberButton:withDataModel:)]) {
        [self.delegate didSelectedJoinMemberButton:sender withDataModel:self.model];
    }
}
/** 导航按钮*/
- (IBAction)navigationClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectedNavigationButton:withDataModel:)]) {
        [self.delegate didSelectedNavigationButton:sender withDataModel:self.model];
    }
}
/** 电话按钮*/
- (IBAction)callTelephoneClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectedTelephoneButton:withDataModel:)]) {
        [self.delegate didSelectedTelephoneButton:sender withDataModel:self.model];
    }
}


@end
