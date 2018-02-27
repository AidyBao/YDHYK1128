//
//  HDugCollectTaTableCell.h
//  YDHYK
//
//  Created by screson on 2016/12/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXDrugCollectModel.h"

@interface HDugCollectTaTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgDrugIcon;
@property (weak, nonatomic) IBOutlet UILabel *lbDrugName;
@property (weak, nonatomic) IBOutlet UILabel *lbDrugSpec;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;

- (void)reloadDrugCollectInfo:(ZXDrugCollectModel *)drugModel;

@end
