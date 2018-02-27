//
//  HItemType.h
//  YDHYK
//
//  Created by screson on 2016/12/13.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    HItemTypeChoose,        //选择值 如 阴/阳 +/-
//    HItemTypeInputMax,      //最大值
//    HItemTypeInputMin,      //最小值
    HItemTypeInput       //区间值
} HItemType;

/**选择Model构造*/
@interface HItemTypeModel : NSObject

@property (nonatomic,copy)   NSString * name;     //如：数值、+/- 阴阳
@property (nonatomic,assign) HItemType type;
@property (nonatomic,strong) NSArray * chooseList;//供选择数据 【区间值时为空】

@end
