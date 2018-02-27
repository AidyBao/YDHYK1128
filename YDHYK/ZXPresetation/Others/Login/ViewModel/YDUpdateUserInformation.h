//
//  YDUpdateUserInformation.h
//  YDHYK
//
//  Created by 120v on 2017/1/13.
//  Copyright © 2017年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDUpdateUserInformation : NSObject
#pragma mark 获取设备信息
+(void)httpRequestForUpdateEquipmentInfoWithDeviceToken:(NSString *)deviceToken;

#pragma mark 更新会员位置
+(void)httpUpdateMemberPostionWithLocation:(CLLocation *)location;

#pragma mark 网络请求闪屏信息并保存
+(void)httpRequestForFlashScreenWithSexString:(NSString *)sex AgeGroup:(NSString *)ageGroup;

@end
