//
//  YDReceiverAddressTableViewCell.h
//  ydhyk
//
//  Created by Aidy Bao on 2016/11/13.
//  Copyright © 2016年 120v. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDReceiverAddressModel.h"

@class YDReceiverAddressTableViewCell;

@protocol YDReceiverAddressTableViewCellDelegate <NSObject>
/** 设置默认*/
-(void)didSelectedSetDefaultAddressButtonAction:(UIButton *)sender withModel:(YDReceiverAddressModel *)addressModel;
/** 编辑*/
-(void)didSelectedEditButtonAction:(UIButton *)sender withModel:(YDReceiverAddressModel *)addressModel;
/** 删除*/
-(void)didSelectedDeleteButtonAction:(UIButton *)sender withModel:(YDReceiverAddressModel *)addressModel;

@end

@interface YDReceiverAddressTableViewCell : UITableViewCell
@property (nonatomic,weak) id<YDReceiverAddressTableViewCellDelegate> delegate;
@property (nonatomic,strong) YDReceiverAddressModel *addressModel;

@end
