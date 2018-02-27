//
//  YDNoMemeberCardView.h
//  YDHYK
//
//  Created by 120v on 2016/12/16.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 附近10家药店*/
#import "YDClosesListModel.h"

@class YDNoMemeberCardView;
@protocol YDNoMemeberCardViewDelegate <NSObject>

-(void)didNoMemeberCardViewMemberButton:(UIButton *)sender withModel:(YDClosesListModel *)model;
-(void)didNoMemeberCardViewLocationButton:(UIButton *)sender withModel:(YDClosesListModel *)model;
-(void)didNoMemeberCardViewTelephoneButton:(UIButton *)sender withModel:(YDClosesListModel *)model;

@end


@interface YDNoMemeberCardView : UIView
@property (nonatomic,weak) id<YDNoMemeberCardViewDelegate>delegate;


@end
