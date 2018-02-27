//
//  ZXDateView.h
//  YDHYK
//
//  Created by 120v on 2016/12/14.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDAddDrugTimeModel.h"

typedef enum : NSUInteger {
    Cancel,
    Delete,
} CanCelType;

@interface ZXDateView : UIView

-(void)show;

@property (nonatomic, assign) CanCelType canCelType;

@property (nonatomic, strong) YDAddDrugTimeModel *model;

@property (nonatomic, copy) void(^ZXDateViewBlock)(NSString * dateStr);

@property (nonatomic, copy) void(^ZXDeleteDateBlock)(YDAddDrugTimeModel * model);

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *cancelStr;

@property (nonatomic, copy) NSString *defaultDate;


@end
