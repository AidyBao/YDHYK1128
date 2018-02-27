//
//  YDRemindInfoViewCell.h
//  ydhyk
//
//  Created by screson on 2016/10/31.
//  Copyright © 2016年 120v. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDRemindTimeModel.h"

@interface YDRemindInfoViewCell : UICollectionViewCell
/** ID*/
+(NSString *)reuseID;
/** 查看详情*/
@property (strong, nonatomic) void (^handleDidCheckInfoBtn)(NSDictionary *dataDict);
/** 修改时间*/
@property (strong, nonatomic) void (^modifyRemindTime)(NSDictionary *dataDict);

@property (nonatomic,strong) NSDictionary *dataDict;

@property (nonatomic,copy) NSString *drugTime;

@end
