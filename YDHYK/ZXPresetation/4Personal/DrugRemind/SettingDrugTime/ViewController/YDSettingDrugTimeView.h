//
//  YDSettingDrugTimeView.h
//  YDHYK
//
//  Created by Aidy Bao on 2016/12/15.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDSettingDrugTimeView : UIView

@property (nonatomic, copy) void(^setDrugTimeBlock)(NSMutableArray *drugTimeArray);

@end
