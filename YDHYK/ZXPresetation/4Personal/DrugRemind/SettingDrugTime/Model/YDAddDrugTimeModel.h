//
//  YDAddDrugTimeModel.h
//  YDHYK
//
//  Created by 120v on 2016/12/19.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDAddDrugTimeModel : NSObject
/** 用药时间*/
@property (nonatomic, copy) NSString *drugTime;
/** 添加次数*/
@property (nonatomic, copy) NSString *addTime;

+(instancetype)setAddModelWithDrugTime:(NSString *)drugTime withAddTime:(NSString *)addTime;

@end
