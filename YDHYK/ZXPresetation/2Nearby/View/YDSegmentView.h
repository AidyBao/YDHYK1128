//
//  YDSegmentView.h
//  ydhyk
//
//  Created by 120v on 2016/10/27.
//  Copyright © 2016年 120v. All rights reserved.
//

#import <UIKit/UIKit.h>
//类型
#define TOPALL @"topAll"
#define TOPREGION @"topRegion"
#define TOPDISTANCE @"topDistance"

@class YDSegmentView;

@protocol YDSegmentViewDelegate <NSObject>

-(void)didSelectedCellWithDataArray:(NSArray *)array withIndex:(NSInteger)cellIndex withButtonType:(NSString *)buttonType;

-(void)didRemoveSuperView;

@end

@interface YDSegmentView : UIView

-(void)dissmisFromSuperview;

@property (nonatomic,weak) id<YDSegmentViewDelegate> delegate;

@property (nonatomic,copy) NSString *buttonType;

@property (nonatomic,copy) NSString *defaultStr;

@end
