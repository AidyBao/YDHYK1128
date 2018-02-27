//
//  YDAPPManager.h
//  ydhyk
//
//  Created by 120v on 2016/11/18.
//  Copyright © 2016年 120v. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginBaseUser.h"

@interface YDAPPManager : NSObject

@property (nonatomic,strong) NSDictionary *loginDict;

#pragma mark - 单列
/**获取单例**/
+(id)shareManager;

#pragma mark - 保存登录状态
/**保存登录状态**/
-(void)saveLoginSataus;

/**保存用户名字**/
-(void)saveUserName;

/**(首次更新个人资料)保存用户性别(NSInteger)**/
-(void)saveUserSex;

/** 保存用户性别（char)*/
-(void)saveUserSexStr;

/** 保存用户头像（char)*/
-(void)saveUserHeadProtraitStr;

/**(首次更新个人资料)保存用户年龄段（Chart）**/
- (void)saveUserAgeGroup;

/**保存闪屏广告**/
- (void)saveFlashImageURL:(NSString *)flashImageURL;

/**保存年龄段(NSArray)**/
- (void)saveAgeGroupArray:(NSArray *)ageGroupArray;

/** 更新推送铃声*/
- (void)saveUserIsVoiceRemind;

/** 更新重复提醒*/
-(void)saveUserIsRepeatedReminders;

#pragma mark - 设备信息
/**获取手机UUID**/
+(NSString *)getTelePhoneUUID;
/**获取手机系统版本**/
+(NSString *)getPhoneVersion;
/** 手机系统 */
+(NSString *)getPhoneSystem;
/** 手机类型 */
+(NSString *)getTelephoneType;

#pragma mark - 获取用户登录信息
/** 推送铃声*/
-(NSString *)getUserIsVoiceRemind;
/** 获取闪屏图片*/
-(UIImage *)getFlashImage;
/** 获取闪屏图片地址*/
-(NSString *)getFlashImageURL;
/** 获取LoginBaseUser实例方法*/
-(LoginBaseUser *)getLoginBaseUser;
/** 获取登录状态 **/
- (BOOL)getIsLoginSataus;
/** 获取“保存服务器返回的年龄段”数据**/
- (NSArray *)getAgeGroupArray;
/** 获取用户名字**/
- (NSString *)getUserName;
/** 获取用户ID**/
- (NSString *)getMemberId;
/** 获取电话**/
- (NSString *)getUserTelephone;
/** 获取token**/
- (NSString *)getUserToken;
/** 获取性别**/
- (NSString *)getUserSexStr;
/** 获取性别**/
- (NSString *)getUserSex;
/** 获取社保号码**/
- (NSString *)getUserSocialNumber;
/** 获取是否为新会员**/
- (NSString *)getUserIfNewMember;
/** 获取会员头像**/
- (NSString *)getUserHeadPortraitFilesStr;
/** 获取会员编号**/
- (NSString *)getUserCurrentIntegral;
/** 获取是否重复提醒**/
- (NSString *)getUserIsRepeatedReminders;
/** 年龄段*/
- (NSString *)getUserAgeGroups;
/** 年龄段整形*/
- (NSString *)getUserAgeInteger;
/** 手机版本*/
- (NSString *)getUserAppVersion;
/** 生日*/
- (NSString *)getUserBirthday;
/** 生日字符串*/
- (NSString *)getUserBirthdayStr;
/** channelId*/
- (NSString *)getUserChannelId;
/** 头像文件*/
- (NSString *)getUserHeadPortraitFiles;
/** 精度*/
- (NSString *)getUserLatitude;
/** 维度*/
- (NSString *)getUserLongitude;
/** 手机型号*/
- (NSString *)getUserMobileModel;
/** 手机系统*/
- (NSString *)getUserMobileSystemType;
/** 手机系统版本*/
- (NSString *)getUserMobileSystemVersion;
/** 推送id*/
- (NSString *)getUserPushId;
/** 二维码*/
- (NSString *)getUserQrCode;
/** 二维码字符串*/
- (NSString *)getUserQrStr;
/** 注册时间*/
- (NSString *)getUserRegDate;
/** 备注*/
- (NSString *)getUserRemark;
/** sourceType*/
- (NSString *)getUserSourceType;
/** 用户状态*/
- (NSString *)getUserStatus;
/** UUID*/
- (NSString *)getUserUUID;

#pragma mark - 清空用户信息
-(void)cleanUserAllInfo;

#pragma mark - 文件夹大小的计算
+(float)folderSizeAtPath:(NSString *)path;

#pragma mark - 单个文件大小的计算
+(long long)fileSizeAtPath:(NSString *)path;

#pragma mark - 清空缓存
+(void)clearCache:(NSString *)path;

@end
