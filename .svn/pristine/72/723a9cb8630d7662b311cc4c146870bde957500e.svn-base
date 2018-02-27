//
//  ZXReportListModel.m
//  YDHYK
//
//  Created by screson on 2016/12/17.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXReportListModel.h"

@implementation ZXReportListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"reportId":@"id"};
}

- (NSString *)dateStrDescription{
    NSString * currentDate = [NSString stringWithFormat:@"%@ 00:00:00",[ZXDateUtils getCurrentDateisChinese:false]];
    NSString * createDate  = [NSString stringWithFormat:@"%@ 00:00:00",[[_createDateStr componentsSeparatedByString:@" "] firstObject]];
    long long currentMillSeconds = [[ZXDateUtils millSecondFromDate:currentDate hasSecond:true splitChar:@"-"] longLongValue];
    long long createMillSeconds = [[ZXDateUtils millSecondFromDate:createDate hasSecond:true splitChar:@"-"] longLongValue];
    long long dis = currentMillSeconds - createMillSeconds;
    int hour = (int)(dis / (60 * 60 * 1000));
    if (hour < 24) {//今天+Time
        return [NSString stringWithFormat:@"今天 %@",[ZXDateUtils timeFromMillSecond:_createDate needSecond:false]];
    }else if (hour >= 24 && hour < 48){//昨天+Time
        return [NSString stringWithFormat:@"昨天 %@",[ZXDateUtils timeFromMillSecond:_createDate needSecond:false]];
    }else{//
        return [[ZXDateUtils dateFromMilliSecond:_createDate isCHN:false needTime:true splitChar:@"-"] substringFromIndex:5];
    }
    return @"";
}

@end
