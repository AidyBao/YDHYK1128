//
//  YDHistoryDrugController.h
//  ydhyk
//
//  Created by screson on 2016/10/28.
//  Copyright © 2016年 120v. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDSubHistoryOrderModel.h"

@class YDHistoryDrugController;

@protocol YDHistoryDrugControllerDelegate <NSObject>

-(void)didHistoryDrugDetailsCellWithModel:(YDSubHistoryOrderModel *)model;

@end

@interface YDHistoryDrugController : UITableViewController

@property (nonatomic,weak)   id<YDHistoryDrugControllerDelegate> delegate;

+(instancetype)instantiateFromStoryboard;

@property (nonatomic, strong) NSMutableArray *histOrderArray;

@end
