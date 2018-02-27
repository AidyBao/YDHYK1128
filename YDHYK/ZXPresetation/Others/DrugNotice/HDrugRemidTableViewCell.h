//
//  HDrugRemidTableViewCell.h
//  YDHYK
//
//  Created by screson on 2016/12/26.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXDrugNoticeControlViewModel.h"

@interface HDrugRemidTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbDrugName;
@property (weak, nonatomic) IBOutlet UILabel *lbQuantity;
@property (weak, nonatomic) IBOutlet UILabel *lbRemark;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topOffset;


- (void)reloadViewDrugModel:(ZXTakeMedicineModel *)model;

@end
