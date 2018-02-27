//
//  YDClosesListModel.h
//  YDHYK
//
//  Created by 120v on 2016/12/16.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDClosesListModel : NSObject
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *provinceId;
@property (nonatomic, copy) NSString *provinceName;
@property (nonatomic, copy) NSString *cityId;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *districtId;
@property (nonatomic, copy) NSString *districtName;
@property (nonatomic, copy) NSString *profile;
@property (nonatomic, copy) NSString *headPortrait;
@property (nonatomic, copy) NSString *headPortraitStr;
@property (nonatomic, copy) NSString *qrCode;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *isChineseMedicine;
@property (nonatomic, copy) NSString *isMember;
@end