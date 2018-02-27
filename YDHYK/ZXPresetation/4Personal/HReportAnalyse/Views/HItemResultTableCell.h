//
//  HItemResultTableCell.h
//  YDHYK
//
//  Created by screson on 2016/12/17.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXItemShortModel.h"

/**化验单记录详情-检查项CELL*/
@interface HItemResultTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbItemName;
@property (weak, nonatomic) IBOutlet ZXLabel *lbUnUsualDesc;
@property (weak, nonatomic) IBOutlet UILabel *lbRefrenceValue;
@property (weak, nonatomic) IBOutlet UILabel *lbResultValue;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameOffsetToRefrenceValue;//有异常描述 >= 50 ,无异常描述 >= 6
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *abnormalVWidth;// 44 30

- (void)reloadItemData:(ZXItemShortModel *)model;

@end
