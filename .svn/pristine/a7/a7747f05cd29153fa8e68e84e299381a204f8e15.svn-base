//
//  HItemModel.h
//  YDHYK
//
//  Created by screson on 2016/12/13.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    HItemResultTypeValue = 1, //值
    HItemResultTypeYinYang,        //阴性 阳性
    HItemResultTypePlusSub         //+/-
} HItemResultType;


/**前端定义的模型*/
/**新增化验单-检查项 详细模型*/
@interface HItemModel : NSObject

@property (nonatomic,assign) HItemResultType referenceValueTypeKey;    //类型 1 2 3
@property (nonatomic,copy) NSString * itemId;                   //id
@property (nonatomic,copy) NSString * itemName;
/**区间值：最小参考值*/
@property (nonatomic,copy) NSString * referenceMinValue;
/**区间值：最大参考值*/
@property (nonatomic,copy) NSString * referenceMaxValue;
/**【数值】结果值*/
@property (nonatomic,copy) NSString * resultValue;
/**参考值阴性/阳性 0阴性 1阳性*/
@property (nonatomic,copy) NSString * referenceNegativePositive;
/** 阴性/阳性结果 0阴性 1阳性*/
@property (nonatomic,copy) NSString * resultNegativePositive;
/**参考值+/-  1+ 0-*/
@property (nonatomic,copy) NSString * referenceAddSub;
/**结果  1+ 0-*/
@property (nonatomic,copy) NSString * resultAddSub;

//调整
@property (nonatomic,assign) HItemResultType resultValueTypeKey;//类型 1 2 3 用于录入时比对
@property (nonatomic,copy) NSString * unusualDescription;       //异常描述 【无：空】
@property (nonatomic,copy) NSString * sectionRefrenceValueDesc; //区间参考值描述
@property (nonatomic,copy) NSString * strReferenceAddSub;
@property (nonatomic,copy) NSString * strResultAddSub;
@property (nonatomic,copy) NSString * strResultNegativePositive;
@property (nonatomic,copy) NSString * strReferenceNegativePositive;

@end
