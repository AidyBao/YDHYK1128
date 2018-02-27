//
//  YDReceiverAddressTableViewCell.m
//  ydhyk
//
//  Created by Aidy Bao on 2016/11/13.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDReceiverAddressTableViewCell.h"

@interface YDReceiverAddressTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *statusButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIView *geliView;

@end

@implementation YDReceiverAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.geliView.backgroundColor = [UIColor zx_assistColor];
    self.nameLabel.textColor = [UIColor zx_textColor];
    self.telLabel.textColor = [UIColor zx_textColor];
    self.addressLabel.textColor = [UIColor zx_textColor];
    [self.editButton setTitleColor:[UIColor zx_sub2TextColor] forState:UIControlStateNormal];
    [self.deleteButton setTitleColor:[UIColor zx_sub2TextColor] forState:UIControlStateNormal];
    [self.statusButton setTitleColor:[UIColor zx_textColor] forState:UIControlStateSelected];
    
}

#pragma mark - setter
-(void)setAddressModel:(YDReceiverAddressModel *)addressModel{
    _addressModel = addressModel;
    self.statusButton.selected = NO;
    if (![addressModel.consignee isKindOfClass:[NSNull class]]) {
        self.nameLabel.text =[NSString stringWithFormat:@"%@",addressModel.consignee];
    }
    if (![addressModel.tel isKindOfClass:[NSNull class]]) {
        self.telLabel.text = [NSString stringWithFormat:@"%@",addressModel.tel];
    }
    if (![addressModel.cityAddress isKindOfClass:[NSNull class]]&&![addressModel.detailAddress isKindOfClass:[NSNull class]]) {
        NSArray *aArray = [addressModel.cityAddress componentsSeparatedByString:@"-"];
        NSString *cityStr = [aArray componentsJoinedByString:@""];
        self.addressLabel.text =[NSString stringWithFormat:@"%@%@",cityStr,addressModel.detailAddress];
    }
    if (![addressModel.isDefault isKindOfClass:[NSNull class]]) {
        if (addressModel.isDefault.integerValue == 1) {
            self.statusButton.selected = YES;
        }
    }
}


#pragma mark - 设为默认
- (IBAction)statusButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectedSetDefaultAddressButtonAction:withModel:)]) {
        [self.delegate didSelectedSetDefaultAddressButtonAction:sender withModel:self.addressModel];
    }
}

#pragma mark - 编辑
- (IBAction)editButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectedEditButtonAction:withModel:)]) {
        [self.delegate didSelectedEditButtonAction:sender withModel:self.addressModel];
    }
}

#pragma mark - 删除
- (IBAction)deleteButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectedDeleteButtonAction:withModel:)]) {
        [self.delegate didSelectedDeleteButtonAction:sender withModel:self.addressModel];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
