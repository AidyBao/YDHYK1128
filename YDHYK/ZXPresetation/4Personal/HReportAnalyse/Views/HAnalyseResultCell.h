//
//  HAnalyseResultCell.h
//  ydhyk
//
//  Created by screson on 2016/11/23.
//  Copyright © 2016年 120v. All rights reserved.
//

/*分析结果详情（异常数据） CELL*/
#import <UIKit/UIKit.h>

@interface HAnalyseResultCell : UITableViewCell
/**分析结果-标题*/
@property (weak, nonatomic) IBOutlet UILabel *lbItemName;
/**分析结果-标志*/
@property (weak, nonatomic) IBOutlet UILabel *lbStatus;
/**分析结果-详细内容*/
@property (weak, nonatomic) IBOutlet UILabel *lbResult;

@end
