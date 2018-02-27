//
//  YDDrugUnitsView.h
//  YDHYK
//
//  Created by 120v on 2016/12/15.
//  Copyright © 2016年 screson. All rights reserved.
//  药品单位

#import <UIKit/UIKit.h>

@class YDPopoverView;
/** 用药单位*/
#define DrugUnitsType 10
#define DrugUnitsTag 3111
/** 用药提醒周期*/
#define DrugTimeType 8
#define DrugTimeTag 3112


@protocol YDPopoverViewDelegate <NSObject>

-(void)didPopoverViewWithKey:(NSString *)key andWithValue:(NSString *)value
     WithTag:(NSInteger)tag;

@end
@interface YDPopoverView : UIView
-(void)show;
@property (nonatomic,weak)   id<YDPopoverViewDelegate> delegate;
@property (nonatomic,strong) NSString *type;
@end
