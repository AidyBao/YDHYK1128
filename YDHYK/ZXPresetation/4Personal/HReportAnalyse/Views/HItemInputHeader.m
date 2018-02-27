//
//  HItemInputHeader.m
//  YDHYK
//
//  Created by screson on 2016/12/19.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HItemInputHeader.h"
#import "HAddCheckItemViewController.h"
#import "ZXReportAnalyseViewModel.h"

@implementation HItemInputHeader


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIView *containerView = [[[UINib nibWithNibName:@"HItemInputHeader" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, ZX_BOUNDS_WIDTH, 50);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        [self.contentView setBackgroundColor:ZXWHITE_COLOR];
        
        [_txtfItemSearch setReturnKeyType:UIReturnKeyDone];
        [_txtfItemSearch.layer setCornerRadius:5];
        [_txtfItemSearch setBackgroundColor:[UIColor zx_separatorColor]];
        [_txtfItemSearch setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_txtfItemSearch setFont:[UIFont zx_titleFontWithSize:15.0]];
        [_txtfItemSearch setTextColor:[UIColor zx_textColor]];
        [_txtfItemSearch setTag:ZX_ITEMSEARCH_TXT_TAG];
        
        UIImageView * imgSearch = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [imgSearch setContentMode:UIViewContentModeScaleAspectFit];
        [imgSearch setImage:[UIImage imageNamed:@"h_CheckItem_seach"]];
        [_txtfItemSearch setLeftView:imgSearch];
        [_txtfItemSearch setLeftViewMode:UITextFieldViewModeAlways];
        
        
        UIButton * btnSelect = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnSelect setFrame:CGRectMake(0, 0, 30, 30)];
        [btnSelect setContentMode:UIViewContentModeScaleAspectFit];
        [btnSelect setImage:[UIImage imageNamed:@"h_CheckItem_Select"] forState:UIControlStateNormal];
        [btnSelect addTarget:self action:@selector(selectItemAction) forControlEvents:UIControlEventTouchUpInside];
        [_txtfItemSearch setRightView:btnSelect];
        [_txtfItemSearch setRightViewMode:UITextFieldViewModeUnlessEditing];
        
        [_btnAdd setEnabled:false];
        [_btnAdd setTag:ZX_ITEMSEARCH_ADDBUTTON_TAG];
        
    }
    return self;
}

- (void)selectItemAction{
    if (_delegate && [_delegate respondsToSelector:@selector(inputHeaderSelectItemAction:)]) {
        [_delegate inputHeaderSelectItemAction:self];
    }
}


- (IBAction)addItemAction:(id)sender {
    [_txtfItemSearch setText:@""];
    [_btnAdd setEnabled:false];
    if (_delegate && [_delegate respondsToSelector:@selector(inputHeaderDidAddedItem:)]) {
        [_delegate inputHeaderDidAddedItem:self];
    }
    
}

#pragma mark - TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.txtfItemSearch resignFirstResponder];
    return true;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [_btnAdd setEnabled:false];
    NSString * text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self searchItemListWithKey:text];
    return true;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    [_btnAdd setEnabled:false];
    [self searchItemListWithKey:nil];
    return true;
}

- (void)searchItemListWithKey:(NSString *)key{
    if (_delegate && [_delegate respondsToSelector:@selector(inputHeaderSearchResultChangeWithItemList:)]) {
        if ([ZXStringUtils isTextEmpty:key]) {
            [_delegate inputHeaderSearchResultChangeWithItemList:nil];
        }else{
            NSArray<ZXCheckItemListModel *> * modelList = [ZXReportAnalyseViewModel checkItemList];
            if (modelList && modelList.count) {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"itemName CONTAINS %@ OR pinyin BEGINSWITH %@ OR itemName CONTAINS %@ OR pinyin BEGINSWITH %@ OR firstLetters CONTAINS %@ OR firstLetters CONTAINS %@",[key lowercaseString],[key lowercaseString],[key uppercaseString],[key uppercaseString],[key lowercaseString],[key uppercaseString]];
                NSArray<ZXCheckItemListModel *> * list = [modelList filteredArrayUsingPredicate:predicate];
                [_delegate inputHeaderSearchResultChangeWithItemList:list];
            }else{
                [_delegate inputHeaderSearchResultChangeWithItemList:nil];
            }
        }
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
