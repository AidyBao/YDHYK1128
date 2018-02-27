//
//  YDListTableViewCell.h
//  ydhyk
//
//  Created by 120v on 2016/10/25.
//  Copyright © 2016年 120v. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 药店数据模型*/
#import "YDSearchModel.h"

@class YDListTableViewCell;

@protocol YDListTableViewCellDelegate <NSObject>

-(void)didListViewJoinMemberButton:(UIButton *)sender withModel:(YDSearchModel *)model;
-(void)didListViewLocationButton:(UIButton *)sender withModel:(YDSearchModel *)model;
-(void)didListViewTelephoneButton:(UIButton *)sender withModel:(YDSearchModel *)model;
-(void)didListViewBuyButton:(UIButton *)sender withModel:(YDSearchModel *)model;

@end

@interface YDListTableViewCell : UITableViewCell

@property (nonatomic,weak) id<YDListTableViewCellDelegate>delegate;
@property (nonatomic,strong) YDSearchModel *dataModel;

@end
