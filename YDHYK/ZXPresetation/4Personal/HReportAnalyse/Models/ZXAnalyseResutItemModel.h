//
//  ZXAyalyseResutItemModel.h
//  YDHYK
//
//  Created by screson on 2016/12/19.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

/**化验分析结果 - 异常检查项*/
@interface ZXAnalyseResutItemModel : NSObject

@property (nonatomic,copy) NSString * itemName;
@property (nonatomic,copy) NSString * resultValue;
/**异常描述*/
@property (nonatomic,copy) NSString * abnormalReason;


@end
