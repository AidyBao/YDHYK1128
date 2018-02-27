//
//  LoginBaseUser.h
//  ydhyk
//
//  Created by 120v on 2016/11/18.
//  Copyright © 2016年 120v. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginBaseUser : NSObject

@property (nonatomic, copy) NSString *ageGroups;
@property (nonatomic, copy) NSString *appVersion;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *birthdayStr;
@property (nonatomic, copy) NSString *channelId;
@property (nonatomic, copy) NSString *currentIntegral;
@property (nonatomic, copy) NSString *headPortraitFiles;
@property (nonatomic, copy) NSString *headPortraitFilesStr;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *isNew;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *mobileModel;
@property (nonatomic, copy) NSString *mobileSystemType;
@property (nonatomic, copy) NSString *mobileSystemVersion;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pushId;
@property (nonatomic, copy) NSString *qrCode;
@property (nonatomic, copy) NSString *qrStr;
@property (nonatomic, copy) NSString *regDate;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *sexStr;
@property (nonatomic, copy) NSString *socialSecurityNumber;
@property (nonatomic, copy) NSString *sourceType;

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *uuid;

@property (nonatomic, copy) NSString *isRepeatedReminders;
@property (nonatomic, copy) NSString *deviceToken;
@property (nonatomic, copy) NSString *isVoiceRemind;

@property (nonatomic, assign) BOOL isLoginSataus;//登录状态

@end
