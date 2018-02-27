//
//  YDRemindInfoCell.h
//  ydhyk
//
//  Created by screson on 2016/10/31.
//  Copyright © 2016年 120v. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDDrugRemindModel.h"

@class YDRemindInfoCell;


@protocol YDRemindInfoCellDelegate <NSObject>

-(void)didYDRemindInfoCell:(UISwitch *)sender withModel:(YDDrugRemindModel *)model;

@end


@interface YDRemindInfoCell : UITableViewCell
//{
//    __weak IBOutlet UILabel *titleLabel;
//    __weak IBOutlet UILabel *descLabel;
//    __weak IBOutlet UISwitch *remindSwitch;
//}

@property (nonatomic,weak) IBOutlet UILabel *titleLabel;
@property (nonatomic,weak) IBOutlet UILabel *descLabel;
@property (nonatomic,weak) IBOutlet UISwitch *remindSwitch;

+(NSString *)reuseID;
@property (nonatomic,strong) YDDrugRemindModel *model;
@property (nonatomic, weak) id<YDRemindInfoCellDelegate> delegate;
@end
