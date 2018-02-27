//
//  YDListTableViewCell.m
//  ydhyk
//
//  Created by 120v on 2016/10/25.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDListTableViewCell.h"

@interface YDListTableViewCell()
/** 购药*/
@property (weak, nonatomic) IBOutlet UIButton *drugPurchaseButton;
/** 加入会员*/
@property (weak, nonatomic) IBOutlet UIButton *joinButton;
@property (weak, nonatomic) IBOutlet UIView *separateLine;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLable;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UIButton *telphoneButton;
@property (weak, nonatomic) IBOutlet UIView *VSeparationLine;
@property (weak, nonatomic) IBOutlet UIView *HSeparationLine;


@end

@implementation YDListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor zx_assistColor];
    
    [self.iconImageView.layer setCornerRadius:self.iconImageView.size.height*0.5];
    [self.iconImageView.layer setMasksToBounds:YES];
    
    self.joinButton.backgroundColor = [UIColor zx_buttonBGNormalColor];
    self.joinButton.layer.cornerRadius = 5.0;
    self.joinButton.layer.masksToBounds = YES;
    [self.joinButton.titleLabel setFont:[UIFont zx_titleFontWithSize:14.0]];
    [self.drugPurchaseButton.titleLabel setFont:[UIFont zx_titleFontWithSize:14.0]];
    [self.drugPurchaseButton.titleLabel setTextAlignment:NSTextAlignmentRight];
    
    self.separateLine.backgroundColor = [UIColor zx_assistColor];
    
    self.VSeparationLine.backgroundColor = [UIColor zx_separatorColor];
    self.HSeparationLine.backgroundColor = [UIColor zx_separatorColor];
    
    self.titleLabel.textColor = [UIColor zx_textColor];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
    
    self.detailLable.textColor = [UIColor zx_sub1TextColor];
    
    [self.locationButton setTitleColor:[UIColor zx_sub1TextColor] forState:UIControlStateNormal];
    
    [self.telphoneButton setTitleColor:[UIColor zx_sub1TextColor] forState:UIControlStateNormal];
    //购药
    [self.drugPurchaseButton setTitleColor:[UIColor zx_buttonBGNormalColor] forState:UIControlStateNormal];
    [self.drugPurchaseButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.drugPurchaseButton setImageEdgeInsets:UIEdgeInsetsMake(0, self.drugPurchaseButton.titleLabel.bounds.size.width + 45, 0, -self.drugPurchaseButton.titleLabel.bounds.size.width - 45)];
    
}

-(void)setDataModel:(YDSearchModel *)dataModel{
    _dataModel = dataModel;
    
    if (dataModel.headPortraitStr) {
        NSURL *iconUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",dataModel.headPortraitStr]];
        [self.iconImageView setImageWithURL:iconUrl placeholderImage:nil];

    }
    
    if (dataModel.name) {
        self.titleLabel.text = dataModel.name;
    }
    
    if (dataModel.distance == nil && dataModel.address == nil) {
        self.detailLable.text =[NSString stringWithFormat:@"%@ %@",@"",@""];
    }else if (dataModel.distance == nil) {
        self.detailLable.text =[NSString stringWithFormat:@"%@ %@",@"",dataModel.address];
    }else if(dataModel.address == nil){
        self.detailLable.text =[NSString stringWithFormat:@"%@ %@",dataModel.distance,@""];
    }else{
        self.detailLable.text =[NSString stringWithFormat:@"%@ %@",dataModel.distance,dataModel.address];
    }
    
    if (dataModel.isMember.integerValue == 1) {//会员
        [self.joinButton setHidden:YES];
        [self.drugPurchaseButton setHidden:NO];
    }else{//非会员
        [self.joinButton setHidden:NO];
        [self.drugPurchaseButton setHidden:YES];
    }
}

#pragma mark - 定位
- (IBAction)locationButtonClick:(UIButton *)sender withModel:(YDSearchModel *)model {
    if ([self.delegate respondsToSelector:@selector(didListViewLocationButton:withModel:)]) {
        [self.delegate didListViewLocationButton:sender withModel:self.dataModel];
    }
}

#pragma mark - 打电话
- (IBAction)telephoneClick:(UIButton *)sender withModel:(YDSearchModel *)model {
    if ([self.delegate respondsToSelector:@selector(didListViewTelephoneButton:withModel:)]) {
        [self.delegate didListViewTelephoneButton:sender withModel:self.dataModel];
    }
}

#pragma mark - 加入会员
- (IBAction)joinMemberClick:(UIButton *)sender withModel:(YDSearchModel *)model{
    if ([self.delegate respondsToSelector:@selector(didListViewJoinMemberButton:withModel:)]) {
        [self.delegate didListViewJoinMemberButton:sender withModel:self.dataModel];
    }
}

#pragma mark - 购药
- (IBAction)drugPurchaseAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didListViewBuyButton:withModel:)]) {
        [self.delegate didListViewBuyButton:sender withModel:self.dataModel];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
