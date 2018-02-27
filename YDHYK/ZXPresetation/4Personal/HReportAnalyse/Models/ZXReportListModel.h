//
//  ZXReportListModel.h
//  YDHYK
//
//  Created by screson on 2016/12/17.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

/**化验单列表*/
@interface ZXReportListModel : NSObject

@property (nonatomic,copy)   NSString * reportId;
@property (nonatomic,assign) NSInteger  age;
@property (nonatomic,assign) NSInteger  sex;
@property (nonatomic,copy)   NSString * sexStr;
/**isAbnormal 0否   1是*/
@property (nonatomic,assign) NSInteger  isAbnormal;
/**异常数目*/
@property (nonatomic,assign) NSInteger  abnormalNum;
@property (nonatomic,strong) NSNumber * createDate;    //毫秒数
@property (nonatomic,copy)   NSString * createDateStr; //字符串
/**相对路径*/
//@property (nonatomic,copy)   NSString * img;
/**绝对路径*/
@property (nonatomic,copy)   NSString * imgStr;

//@property (nonatomic,assign) NSInteger  status;//所有接口 0 作废 1 有效

/**日期描述 今天+Time  昨天+Time 日期*/
@property (nonatomic,copy) NSString * dateStrDescription;

@end
