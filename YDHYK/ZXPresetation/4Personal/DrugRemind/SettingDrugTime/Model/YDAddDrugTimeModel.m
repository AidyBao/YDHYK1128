//
//  YDAddDrugTimeModel.m
//  YDHYK
//
//  Created by 120v on 2016/12/19.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "YDAddDrugTimeModel.h"

@interface YDAddDrugTimeModel()


@end

@implementation YDAddDrugTimeModel



+(instancetype)setAddModelWithDrugTime:(NSString *)drugTime withAddTime:(NSString *)addTime{
    
    YDAddDrugTimeModel *model = [[self alloc]init];
    model.drugTime = drugTime;
    model.addTime = addTime;
    
    return model;
}

@end
