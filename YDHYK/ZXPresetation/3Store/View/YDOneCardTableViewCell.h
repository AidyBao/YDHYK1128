//
//  YDOneCardTableViewCell.h
//  ydhyk
//
//  Created by 120v on 2016/11/1.
//  Copyright © 2016年 120v. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDQueryMemberCardModel.h"
@class YDOneCardTableViewCell;

@protocol YDOneCardTableViewCellDelegate <NSObject>

-(void)didSelectedOneCardViewWithTelphoneButton:(UIButton *)sender;

-(void)didSelectedOneCardViewWithBuyButton:(UIButton *)sender;

-(void)didOneCardViewWithTouchBegin:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

@end

@interface YDOneCardTableViewCell : UITableViewCell

@property (nonatomic,weak) id<YDOneCardTableViewCellDelegate> delegate;

@property (strong, nonatomic) YDQueryMemberCardModel *model;

@end
