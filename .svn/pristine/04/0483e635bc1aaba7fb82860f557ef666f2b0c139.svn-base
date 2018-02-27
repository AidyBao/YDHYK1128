//
//  BuyRootTableViewCell.h
//  ydhyk
//
//  Created by 120v on 2016/10/24.
//  Copyright © 2016年 120v. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDQueryMemberCardModel.h"

@class BuyRootTableViewCell;

@protocol BuyRootTableViewCellDelegate <NSObject>

-(void)didSelectedBuyRootCellWithBuyButtonClick:(UIButton *)sender withModel:(YDQueryMemberCardModel *)model;
-(void)didSelectedBuyRootCellWithTelButtonClick:(UIButton *)sender withModel:(YDQueryMemberCardModel *)model;

@end

@interface BuyRootTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (assign, nonatomic) NSInteger cellIndex;

@property (weak, nonatomic) id<BuyRootTableViewCellDelegate>delegate;

@property (strong, nonatomic) YDQueryMemberCardModel *model;

@end
