//
//  HItemSelectTableCell.h
//  YDHYK
//
//  Created by screson on 2016/12/13.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HItemSelectTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbItemName;
@property (weak, nonatomic) IBOutlet UIImageView *imgCheck;

@property (nonatomic,assign) BOOL needHighlight;

@end
