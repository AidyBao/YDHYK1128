//
//  HItemInpuTableViewCell.h
//  YDHYK
//
//  Created by screson on 2016/12/19.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HItemModel.h"
@class HItemInpuTableViewCell;

/**检查项值录入Cell Delegate*/
@protocol HItemInputTableViewCellDelegate <NSObject>

@optional

- (void)itemInputCellDeleteAction:(HItemInpuTableViewCell *)cell;
- (void)itemInputCellDidEndRefrenceValueInput:(NSString *)refrenceValue cell:(HItemInpuTableViewCell *)cell;
- (void)itemInputCellDidEndResultValueInput:(NSString *)resultValue cell:(HItemInpuTableViewCell *)cell;

@end


/**新建化验单-参考值-结果值输入*/
@interface HItemInpuTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbItemName;
@property (weak, nonatomic) IBOutlet UILabel *lbRefTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbResultTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnRefrenceValue;
@property (weak, nonatomic) IBOutlet UIButton *bntResultValue;

@property (nonatomic,assign) id<HItemInputTableViewCellDelegate> delegate;

- (void)reloadItemData:(HItemModel *)model;

@end
