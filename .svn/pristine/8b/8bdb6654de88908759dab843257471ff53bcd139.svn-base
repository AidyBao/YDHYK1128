//
//  YDDetailCollectionViewCell.h
//  ydhyk
//
//  Created by 120v on 2016/10/26.
//  Copyright © 2016年 120v. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDSearchModel.h"


@class YDDetailCollectionViewCell;

@protocol YDDetailCollectionViewCellDelegate <NSObject>

-(void)didSelectedJoinMemberButton:(UIButton*)sender withDataModel:(YDSearchModel *)model;
-(void)didSelectedNavigationButton:(UIButton*)sender withDataModel:(YDSearchModel *)model;
-(void)didSelectedTelephoneButton:(UIButton*)sender withDataModel:(YDSearchModel *)model;

@end

@interface YDDetailCollectionViewCell : UICollectionViewCell

@property (nonatomic,weak) id<YDDetailCollectionViewCellDelegate> delegate;
@property (nonatomic,strong) YDSearchModel *model;

@end
