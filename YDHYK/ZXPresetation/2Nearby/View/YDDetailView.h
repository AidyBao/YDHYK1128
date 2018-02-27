//
//  YDDetailView.h
//  ydhyk
//
//  Created by 120v on 2016/10/26.
//  Copyright © 2016年 120v. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDSearchModel.h"

@class YDDetailView;

@protocol YDDetailViewDelegate <NSObject>

-(void)didDetailViewJoinMemberButton:(UIButton *)sender withDataModel:(YDSearchModel *)model;
-(void)didDetailViewNavigationButton:(UIButton *)sender withDataModel:(YDSearchModel *)model;
-(void)didDetailViewTelephoneButton:(UIButton *)sender withDataModel:(YDSearchModel *)model;

@end

@interface YDDetailView : UIView

@property (nonatomic,weak) id<YDDetailViewDelegate> delegate;

@property (nonatomic,strong) NSArray *dataArray;

@end
