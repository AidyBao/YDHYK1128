//
//  YDRemindInfoHeaderViewCell.h
//  ydhyk
//
//  Created by screson on 2016/10/31.
//  Copyright © 2016年 120v. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDRemindTimeModel.h"

@interface YDRemindInfoHeaderViewCell : UITableViewCell

+(NSString *)reuseID;

@property (nonatomic,strong) YDRemindTimeModel *model;

@property (weak, nonatomic) IBOutlet UILabel *medicinesName;

@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;

@end
