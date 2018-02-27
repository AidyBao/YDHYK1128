//
//  ZXCheckTemplateModel.h
//  YDHYK
//
//  Created by screson on 2016/12/20.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    HConstDicTypeAge  = 1,          //年龄段数据
    HConstDicTypeWeek = 8,          //用药提醒周期
    HConstDicTypeUnit = 10,         //用药单位
    HConstDicTypeCheckItem = 14,    //检查项
    HConstDicTypeCheckTemplate = 15 //化验单模板
} HConstDicType;

/** Type
 *1：年龄段数据
 *8：用药提醒周期
 *10：用药单位
 *14：检查项
 *15：化验单模板
 */
/**常量数据字典*/
@interface ZXConstDicModel : NSObject
/**模板ID*/
@property (nonatomic,assign) HConstDicType type;      //常量类型 1 8 10 14 15
@property (nonatomic,copy) NSString * typeLabel; //类型说明
@property (nonatomic,copy) NSString * key;       //常量ID
@property (nonatomic,copy) NSString * value;     //常量值
@property (nonatomic,copy) NSString * remark;    //备注

@end
