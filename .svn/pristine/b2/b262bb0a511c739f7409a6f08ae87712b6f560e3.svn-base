//
//  YDSixAgeView.h
//  ydhyk
//
//  Created by Aidy Bao on 2016/11/13.
//  Copyright © 2016年 120v. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YDSixAgeView;

@protocol YDSixAgeViewDelegate <NSObject>

-(void)didSelectedCellIndexPathWithString:(NSString *)string WithTag:(NSInteger)tag;

@end

@interface YDSixAgeView : UIView
-(void)show;
@property (nonatomic,weak)   id<YDSixAgeViewDelegate> delegate;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,copy) NSString *defaultStr;
//@property (nonatomic,copy) NSString *defaultAgeGroup;
@end
