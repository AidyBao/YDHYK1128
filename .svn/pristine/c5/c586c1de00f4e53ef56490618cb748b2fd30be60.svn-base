//
//  YDMedicineDetailView.h
//  ydhyk
//
//  Created by 120v on 2016/10/28.
//  Copyright © 2016年 120v. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDMedicineDetailView;
@protocol YDMedicineDetailViewDelegate <NSObject>

/** 现在服药代理方法*/
-(void)didSelectedTakeMedicineButton:(UIButton*)sender;
/** 稍后提醒代理方法*/
-(void)didSelectedRemindButton:(UIButton*)sender;

@end


@interface YDMedicineDetailView : UIView
/** 数据源方法*/
@property (nonatomic,strong) NSDictionary *dataDict;
/** 
 @isTakeMedicine = YES,显示为“提醒服药弹窗”
 @isTakeMedicine = No,显示为“查看详情弹窗”
 */
@property (nonatomic,assign) BOOL isTakeMedicine;

@property (nonatomic,weak) id<YDMedicineDetailViewDelegate> delegate;

-(void)show;

@end
