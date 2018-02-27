//
//  HItemInpuTableViewCell.m
//  YDHYK
//
//  Created by screson on 2016/12/19.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HItemInpuTableViewCell.h"
#import "HCheckItemInputViewController.h"

@interface HItemInpuTableViewCell ()
{
    HItemModel * itemModel;
}

@end

@implementation HItemInpuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_lbRefTitle setFont:[UIFont zx_bodyFontWithSize:15]];
    [_lbRefTitle setTextColor:[UIColor zx_textColor]];
    
    [_lbResultTitle setFont:[UIFont zx_bodyFontWithSize:15]];
    [_lbResultTitle setTextColor:[UIColor zx_textColor]];
    
    [_btnRefrenceValue.titleLabel setFont:[UIFont zx_bodyFontWithSize:15]];
    [_btnRefrenceValue setTitleColor:[UIColor zx_sub2TextColor] forState:UIControlStateNormal];
    [_btnRefrenceValue setTitleColor:[UIColor zx_textColor] forState:UIControlStateHighlighted];
    [_btnRefrenceValue setTitleColor:[UIColor zx_textColor] forState:UIControlStateSelected];
    
    [_bntResultValue.titleLabel setFont:[UIFont zx_bodyFontWithSize:15]];
    [_bntResultValue setTitleColor:[UIColor zx_sub2TextColor] forState:UIControlStateNormal];
    [_bntResultValue setTitleColor:[UIColor zx_textColor] forState:UIControlStateHighlighted];
    [_bntResultValue setTitleColor:[UIColor zx_textColor] forState:UIControlStateSelected];
    
    [_btnRefrenceValue.titleLabel setAdjustsFontSizeToFitWidth:true];
    [_bntResultValue.titleLabel   setAdjustsFontSizeToFitWidth:true];
}

- (void)reloadItemData:(HItemModel *)model{
    itemModel = model;
    [_lbItemName setText:model.itemName];
    //统一改为  请录入
    //同一检查项 在不同化验单上 值类型可能不一样！
    switch (itemModel.referenceValueTypeKey) {
        case HItemResultTypePlusSub:
        {
            if (itemModel.strReferenceAddSub) {//参考值 已填写
                [_btnRefrenceValue setTitle:itemModel.strReferenceAddSub forState:UIControlStateNormal];
                [_btnRefrenceValue setSelected:true];
            }else{
                [_btnRefrenceValue setTitle:@"请录入" forState:UIControlStateNormal];
                [_btnRefrenceValue setSelected:false];
            }
            
            if (itemModel.strResultAddSub) {//结果值 已填写
                [_bntResultValue setTitle:itemModel.strResultAddSub forState:UIControlStateNormal];
                [_bntResultValue setSelected:true];
            }else{
                [_bntResultValue setTitle:@"请录入" forState:UIControlStateNormal];
                [_bntResultValue setSelected:false];
            }
        }
            break;
        case HItemResultTypeYinYang:
        {
            if (itemModel.strReferenceNegativePositive) {//参考值 已填写
                [_btnRefrenceValue setTitle:itemModel.strReferenceNegativePositive forState:UIControlStateNormal];
                [_btnRefrenceValue setSelected:true];
            }else{
                [_btnRefrenceValue setTitle:@"请录入" forState:UIControlStateNormal];
                [_btnRefrenceValue setSelected:false];
            }
            
            if (itemModel.strResultNegativePositive) {//结果值 已填写
                [_bntResultValue setTitle:itemModel.strResultNegativePositive forState:UIControlStateNormal];
                [_bntResultValue setSelected:true];
            }else{
                [_bntResultValue setTitle:@"请录入" forState:UIControlStateNormal];
                [_bntResultValue setSelected:false];
            }
        }
            break;
        case HItemResultTypeValue:
        {
            if (itemModel.referenceMinValue) {//参考值 已填写
                [_btnRefrenceValue setTitle:itemModel.sectionRefrenceValueDesc forState:UIControlStateNormal];
                [_btnRefrenceValue setSelected:true];
            }else{
                [_btnRefrenceValue setTitle:@"请录入" forState:UIControlStateNormal];
                [_btnRefrenceValue setSelected:false];
            }
            if (itemModel.resultValue) {//结果值 已填写
                [_bntResultValue setTitle:itemModel.resultValue forState:UIControlStateNormal];
                [_bntResultValue setSelected:true];
            }else{
                [_bntResultValue setTitle:@"请录入" forState:UIControlStateNormal];
                [_bntResultValue setSelected:false];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)deleteAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(itemInputCellDeleteAction:)]) {
        [_delegate itemInputCellDeleteAction:self];
    }
}

- (IBAction)refrenceValueInput:(id)sender {
    if (_delegate) {
        //不限制类型选择
        [HCheckItemInputViewController showRefrenceDataSelectOnVC:(UIViewController *)_delegate dataOnly:true typeIndex:0 completion:^(HItemResultType type, NSString *minRef, NSString *maxRef, NSString *refValue, NSInteger selIndex) {
            [_btnRefrenceValue setTitle:refValue forState:UIControlStateNormal];
            [_btnRefrenceValue setSelected:true];
            itemModel.referenceValueTypeKey = type;
            
            switch (itemModel.referenceValueTypeKey) {
                case HItemResultTypeValue:
                {
                    itemModel.referenceMinValue = minRef;
                    itemModel.referenceMaxValue = maxRef;
                }
                    break;
                case HItemResultTypePlusSub:
                {
                    itemModel.referenceAddSub = [NSString stringWithFormat:@"%@",@(selIndex)];
                }
                    break;
                case HItemResultTypeYinYang:
                {
                    itemModel.referenceNegativePositive = [NSString stringWithFormat:@"%@",@(selIndex)];
                }
                    break;
                    
                default:
                    break;
            }
            
            if (itemModel.referenceValueTypeKey != itemModel.resultValueTypeKey) {//修改了检查项类型
                [_bntResultValue setTitle:@"请录入" forState:UIControlStateNormal];
                [_bntResultValue setSelected:false];
                switch (itemModel.referenceValueTypeKey) {
                    case HItemResultTypeValue:
                    {
                        itemModel.resultValue = nil;
                    }
                        break;
                    case HItemResultTypePlusSub:
                    {
                        itemModel.resultAddSub = nil;
                    }
                        break;
                    case HItemResultTypeYinYang:
                    {
                        itemModel.resultNegativePositive = nil;
                    }
                        break;

                    default:
                        break;
                }
            }
        }];
        //限制类型
        /*switch (itemModel.referenceValueTypeKey) {
            case HItemResultTypePlusSub:// +1 -0
            {
                [HCheckItemInputViewController showRefrenceDataSelectOnVC:(UIViewController *)_delegate dataOnly:true typeIndex:2 completion:^(HItemResultType type, NSString *minRef, NSString *maxRef, NSString *refValue, NSInteger selIndex) {
                    NSLog(@"type:%d min:%@ max:%@ ref:%@ index:%d",type,minRef,maxRef,refValue,selIndex);
                    [_btnRefrenceValue setTitle:refValue forState:UIControlStateNormal];
                    [_btnRefrenceValue setSelected:true];
                    itemModel.referenceValueTypeKey = type;
                    itemModel.referenceAddSub = [NSString stringWithFormat:@"%d",selIndex];
                }];
            }
                break;
            case HItemResultTypeYinYang://阴0 阳1
            {
                [HCheckItemInputViewController showRefrenceDataSelectOnVC:(UIViewController *)_delegate dataOnly:true typeIndex:2 completion:^(HItemResultType type, NSString *minRef, NSString *maxRef, NSString *refValue, NSInteger selIndex) {
                    NSLog(@"type:%d min:%@ max:%@ ref:%@ index:%d",type,minRef,maxRef,refValue,selIndex);
                    [_btnRefrenceValue setTitle:refValue forState:UIControlStateNormal];
                    [_btnRefrenceValue setSelected:true];
                    itemModel.referenceValueTypeKey = type;
                    itemModel.referenceNegativePositive = [NSString stringWithFormat:@"%d",selIndex];
                }];
            }
                break;
            case HItemResultTypeValue:
            {
                [HCheckItemInputViewController showRefrenceDataSelectOnVC:(UIViewController *)_delegate dataOnly:true typeIndex:2 completion:^(HItemResultType type, NSString *minRef, NSString *maxRef, NSString *refValue, NSInteger selIndex) {
                    NSLog(@"type:%d min:%@ max:%@ ref:%@ index:%d",type,minRef,maxRef,refValue,selIndex);
                    [_btnRefrenceValue setTitle:refValue forState:UIControlStateNormal];
                    [_btnRefrenceValue setSelected:true];
                    itemModel.referenceValueTypeKey = type;
                    itemModel.referenceMinValue = minRef;
                    itemModel.referenceMaxValue = maxRef;
                }];
            }
                break;
                
            default:
                break;
        }*/
    }
}

- (IBAction)resultValueInput:(id)sender {
    
    if (_delegate && [_delegate isKindOfClass:[UIViewController class]]) {
        UIViewController * vc = (UIViewController *)_delegate;
        switch (itemModel.referenceValueTypeKey) {
            case HItemResultTypePlusSub:// +1 -0
            {
                if (itemModel.referenceAddSub) {//确定录入
                    [HCheckItemInputViewController showResultDataSelectOnVC:vc dataOnly:true typeIndex:2 completion:^(HItemResultType type, NSInteger selIndex, NSString *resultValue) {
                        [_bntResultValue setTitle:resultValue forState:UIControlStateNormal];
                        [_bntResultValue setSelected:true];
                        itemModel.resultValueTypeKey = type;
                        itemModel.resultAddSub = [NSString stringWithFormat:@"%@",@(selIndex)];
                    }];
                }else{
                    [ZXHUD MBShowFailureInView:vc.view text:@"请先输入参考值" delay:1.5];
                }
            }
                break;
            case HItemResultTypeYinYang://阴0 阳1
            {
                if (itemModel.referenceNegativePositive) {
                    [HCheckItemInputViewController showResultDataSelectOnVC:vc dataOnly:true typeIndex:1 completion:^(HItemResultType type, NSInteger selIndex, NSString *resultValue) {
                        [_bntResultValue setTitle:resultValue forState:UIControlStateNormal];
                        [_bntResultValue setSelected:true];
                        itemModel.resultValueTypeKey = type;
                        itemModel.resultNegativePositive = [NSString stringWithFormat:@"%@",@(selIndex)];
                        
                    }];
                }else{
                    [ZXHUD MBShowFailureInView:vc.view text:@"请先输入参考值" delay:1.5];
                }
            }
                break;
            case HItemResultTypeValue://值
            {
                if (itemModel.referenceMinValue) {
                    [HCheckItemInputViewController showResultDataSelectOnVC:vc dataOnly:true typeIndex:0 completion:^(HItemResultType type, NSInteger selIndex, NSString *resultValue) {
                        [_bntResultValue setTitle:resultValue forState:UIControlStateNormal];
                        [_bntResultValue setSelected:true];
                        itemModel.resultValueTypeKey = type;
                        itemModel.resultValue = resultValue;
                        
                    }];
                }else{
                    [ZXHUD MBShowFailureInView:vc.view text:@"请先输入参考值" delay:1.5];
                }
            }
                break;
                
            default:
                break;
        }
        
    }
}

//switch (itemModel.referenceValueTypeKey) {
//    case HItemResultTypePlusSub:
//    {
//        if (itemModel.referenceAddSub) {//参考值 已填写
//        }else{
//        }
//        
//        if (itemModel.resultValue) {//结果值 已填写
//        }else{
//        }
//    }
//        break;
//    case HItemResultTypeYinYang:
//    {
//        if (itemModel.referenceNegativePositive) {//参考值 已填写
//        }else{
//        }
//        
//        if (itemModel.resultValue) {//结果值 已填写
//        }else{
//        }
//    }
//        break;
//    case HItemResultTypeValue:
//    {
//        if (itemModel.referenceMinValue) {//参考值 已填写
//        }else{
//        }
//        if (itemModel.resultValue) {//结果值 已填写
//        }else{
//        }
//    }
//        break;
//        
//    default:
//        break;
//}


@end
