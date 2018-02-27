//
//  HItemSexAgeTableCell.h
//  YDHYK
//
//  Created by screson on 2016/12/17.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXItemShortModel.h"

/**化验单详情 - 性别、年龄*/
@interface HItemSexAgeTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbSexTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbSex;
@property (weak, nonatomic) IBOutlet UILabel *lbAgeTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbAge;
@property (weak, nonatomic) IBOutlet UIView *lbHLine;

- (void)loadSexAge:(ZXPatientInfo *)patientInfo;

@end
