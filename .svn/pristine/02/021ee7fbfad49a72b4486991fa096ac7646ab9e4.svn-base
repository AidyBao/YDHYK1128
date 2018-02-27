//
//  ZXSexAgeInputTableCell.m
//  YDHYK
//
//  Created by screson on 2016/12/19.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXSexAgeInputTableCell.h"
#import "ZXFullCheckListViewController.h"

@implementation ZXSexAgeInputTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_lbSexTitle setFont:[UIFont zx_bodyFontWithSize:15]];
    [_lbSexTitle setTextColor:[UIColor zx_textColor]];
    
    [_lbAgeTitle setFont:[UIFont zx_bodyFontWithSize:15]];
    [_lbAgeTitle setTextColor:[UIColor zx_textColor]];
    
    [_btnSex.titleLabel setFont:[UIFont zx_bodyFontWithSize:15]];
    [_btnSex setTitleColor:[UIColor zx_sub2TextColor] forState:UIControlStateNormal];
    [_btnSex setTitleColor:[UIColor zx_textColor] forState:UIControlStateHighlighted];
    [_btnSex setTitleColor:[UIColor zx_textColor] forState:UIControlStateSelected];
    
    [_txtAgeInput setFont:[UIFont zx_bodyFontWithSize:15]];
    [_txtAgeInput setTextColor:[UIColor zx_textColor]];
    [_txtAgeInput setReturnKeyType:UIReturnKeyDone];
    [_txtAgeInput setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_txtAgeInput setDelegate:self];
    [_txtAgeInput setTag:ZX_ITEMAGE_TXT_TAG];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)sexAgeSelectAction:(id)sender {
    if (_delegate) {
        if ([_delegate isKindOfClass:[UIViewController class]]) {
            UIViewController * vc = (UIViewController *)_delegate;
            [ZXFullCheckListViewController presentOnVC:vc title:@"请选择性别" checkList:@[@"女",@"男"] completion:^(NSInteger index, NSString *name) {
                [_btnSex setSelected:true];
                [_btnSex setTitle:name forState:UIControlStateNormal];
                if ([_delegate respondsToSelector:@selector(sexAgeInputTableCellDidSexSelected:sexTitle:cell:)]) {
                    [_delegate sexAgeInputTableCellDidSexSelected:index sexTitle:name cell:self];
                }
            }];
        }
    }
}

- (void)reloadSex:(NSString *)sex age:(NSString *)age{
    if ([ZXStringUtils isTextEmpty:sex]) {
        [_btnSex setSelected:false];
        [_btnSex setTitle:@"请选择" forState:UIControlStateNormal];
    }else{
        if ([sex isEqualToString:@"男"] ||
            [sex isEqualToString:@"1"]) {
            [_btnSex setTitle:@"男" forState:UIControlStateNormal];
        }else{
            [_btnSex setTitle:@"女" forState:UIControlStateNormal];
        }
        [_btnSex setSelected:true];
    }
    [_txtAgeInput setText:age];
}

#pragma mark - TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (_delegate && [_delegate respondsToSelector:@selector(sexAgeInputTableCellDidAgeInputed:textField:cell:)]) {
        [_delegate sexAgeInputTableCellDidAgeInputed:textField.text textField:textField cell:self];
    }
}

#define NUMBERS @"0123456789"
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location == 0 && string.length && [[string substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"]) {
        return false;
    }
    if (range.location > 2) {
        return false;
    }
    NSCharacterSet * cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString * filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest) {
        return false;
    }
    return YES;
}

@end
