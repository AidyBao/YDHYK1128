//
//  YDAPPManager.m
//  ydhyk
//
//  Created by 120v on 2016/11/18.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDAPPManager.h"
#import <sys/utsname.h>

@interface YDAPPManager()

@property (nonatomic,strong) LoginBaseUser *loginBaseUser;

@end


@implementation YDAPPManager

static id appManagerInstance;
+(id)shareManager{
    static dispatch_once_t oneToken;//只一次的队列
    dispatch_once(&oneToken,^{
        appManagerInstance = [[self alloc]init];
    });
    return appManagerInstance;
}

-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark 获取LoginBaseUser的实例方法
-(LoginBaseUser *)getLoginBaseUser{
    if (!_loginBaseUser) {
        _loginBaseUser = [[LoginBaseUser alloc]init];
    }
    return _loginBaseUser;
}

#pragma mark - 保存登录用户信息
-(void)setLoginDict:(NSDictionary *)loginDict{
    _loginDict = loginDict;
   
    if (loginDict) {
        self.loginBaseUser = [LoginBaseUser mj_objectWithKeyValues:loginDict];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:[NSString stringWithFormat:@"%@",self.loginBaseUser.ageGroups] forKey:@"ageGroups"];
        [userDefaults setObject:self.loginBaseUser.appVersion forKey:@"appVersion"];
        [userDefaults setObject:self.loginBaseUser.birthday forKey:@"birthday"];
        [userDefaults setObject:self.loginBaseUser.birthdayStr forKey:@"birthdayStr"];
        [userDefaults setObject:self.loginBaseUser.channelId forKey:@"channelId"];
        [userDefaults setObject:self.loginBaseUser.currentIntegral forKey:@"currentIntegral"];
        [userDefaults setObject:self.loginBaseUser.headPortraitFiles forKey:@"headPortraitFiles"];
        [userDefaults setObject:self.loginBaseUser.headPortraitFilesStr forKey:@"headPortraitFilesStr"];
        [userDefaults setObject:self.loginBaseUser.uid forKey:@"uid"];
        [userDefaults setObject:self.loginBaseUser.isNew forKey:@"isNew"];
        [userDefaults setObject:self.loginBaseUser.latitude forKey:@"latitude"];
        [userDefaults setObject:self.loginBaseUser.longitude forKey:@"longitude"];
        [userDefaults setObject:self.loginBaseUser.mobileModel forKey:@"mobileModel"];
        [userDefaults setObject:self.loginBaseUser.mobileSystemType forKey:@"mobileSystemType"];
        [userDefaults setObject:self.loginBaseUser.mobileSystemVersion forKey:@"mobileSystemVersion"];
        [userDefaults setObject:self.loginBaseUser.name forKey:@"name"];
        [userDefaults setObject:self.loginBaseUser.pushId forKey:@"pushId"];
        [userDefaults setObject:self.loginBaseUser.qrCode forKey:@"qrCode"];
        [userDefaults setObject:self.loginBaseUser.qrStr forKey:@"qrStr"];
        [userDefaults setObject:self.loginBaseUser.regDate forKey:@"regDate"];
        [userDefaults setObject:self.loginBaseUser.remark forKey:@"remark"];
        [userDefaults setObject:[NSString stringWithFormat:@"%@",self.loginBaseUser.sex] forKey:@"sex"];
        [userDefaults setObject:self.loginBaseUser.sexStr forKey:@"sexStr"];
        [userDefaults setObject:self.loginBaseUser.socialSecurityNumber forKey:@"socialSecurityNumber"];
        [userDefaults setObject:self.loginBaseUser.sourceType forKey:@"sourceType"];
        [userDefaults setObject:self.loginBaseUser.status forKey:@"status"];
        
        [userDefaults setObject:self.loginBaseUser.tel forKey:@"tel"];
        [userDefaults setObject:self.loginBaseUser.token forKey:@"token"];
        [userDefaults setObject:self.loginBaseUser.uuid forKey:@"uuid"];
        
        [userDefaults setObject:self.loginBaseUser.isRepeatedReminders forKey:@"isRepeatedReminders"];
        [userDefaults setObject:self.loginBaseUser.deviceToken forKey:@"deviceToken"];
        [userDefaults setObject:self.loginBaseUser.isVoiceRemind forKey:@"isVoiceRemind"];
        
        [userDefaults synchronize];
    }
}

#pragma mark - Login
#pragma mark 保存登录状态
-(void)saveLoginSataus{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:self.loginBaseUser.isLoginSataus forKey:@"isLoginSataus"];
//    [userDefault setObject:[NSNumber numberWithBool:self.loginBaseUser.isLoginSataus] forKey:@"isLoginSataus"];
    [userDefault synchronize];
}

#pragma mark 保存用户名字
- (void)saveUserName{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.loginBaseUser.name forKey:@"name"];
    [userDefault synchronize];
}

#pragma mark 保存性别(NSInteger)
-(void)saveUserSex{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.loginBaseUser.sex forKey:@"sex"];
    [userDefault synchronize];
}

#pragma mark 保存性别(Char)
-(void)saveUserSexStr{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.loginBaseUser.sexStr forKey:@"sexStr"];
    [userDefault synchronize];
}

#pragma mark 保存用户年龄段(Char)
-(void)saveUserAgeGroup{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.loginBaseUser.ageGroups forKey:@"ageGroups"];
    [userDefault synchronize];
}

#pragma mark - 保存用户头像字符串
-(void)saveUserHeadProtraitStr{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.loginBaseUser.headPortraitFilesStr forKey:@"headPortraitFilesStr"];
    [userDefault synchronize];
}

#pragma mark 保存闪屏广告
-(void)saveFlashImageURL:(NSString *)flashImageURL{
    if ([flashImageURL isKindOfClass:[NSString class]] && flashImageURL.length) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *flashImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:flashImageURL]];
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:flashImageData forKey:@"flashImageData"];
            [userDefault setObject:flashImageURL forKey:@"flashImageURL"];
            [userDefault synchronize];
        });
    }else{
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault removeObjectForKey:@"flashImageData"];
        [userDefault removeObjectForKey:@"flashImageURL"];
        [userDefault synchronize];
    }
}

#pragma mark 保存服务器返回年龄段数组
- (void)saveAgeGroupArray:(NSArray *)ageGroupArray{
    NSString *ageGroupString = [ageGroupArray mj_JSONString];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults] setObject:ageGroupString forKey:@"ageGroupString"];
    [userDefault synchronize];
}

#pragma mark 更新推送铃声
- (void)saveUserIsVoiceRemind{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.loginBaseUser.isVoiceRemind forKey:@"isVoiceRemind"];
    [userDefault synchronize];
}

#pragma mark 更新重复提醒
-(void)saveUserIsRepeatedReminders{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.loginBaseUser.isRepeatedReminders forKey:@"isRepeatedReminders"];
    [userDefault synchronize];
}

#pragma mark - 推送铃声
-(NSString *)getUserIsVoiceRemind{
    NSString *isVoiceRemind = [[NSUserDefaults standardUserDefaults] objectForKey:@"isVoiceRemind"];
    return isVoiceRemind;
}

#pragma mark 获取闪屏图片
-(UIImage *)getFlashImage{
    NSData *flashImageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"flashImageData"];
    UIImage *flashImage = [UIImage imageWithData:flashImageData];
    return flashImage;
}

#pragma mark 获取闪屏图片地址
-(NSString *)getFlashImageURL{
    NSString *flashImageURL = [[NSUserDefaults standardUserDefaults] objectForKey:@"flashImageURL"];
    return flashImageURL;
}

#pragma mark 获取“保存服务器返回的年龄段”数据
- (NSArray *)getAgeGroupArray{
    NSString *ageGroupString =[[NSUserDefaults standardUserDefaults] objectForKey:@"ageGroupString"];
    NSArray *ageGroupArray = [ageGroupString mj_JSONObject];
    return ageGroupArray;
}

#pragma mark 获取登录状态
- (BOOL)getIsLoginSataus{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL loginSataus = [[userDefaults objectForKey:@"isLoginSataus"] boolValue];
    return loginSataus;
}

#pragma mark 获取用户名字
- (NSString *)getUserName{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
}

#pragma mark 获取用户ID
- (NSString *)getMemberId{
    return [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]];
}

#pragma mark 获取电话
- (NSString *)getUserTelephone{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"tel"];
}

#pragma mark 获取token
- (NSString *)getUserToken{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
}

#pragma mark 获取性别
- (NSString *)getUserSexStr{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"sexStr"];
}

#pragma mark 获取性别
- (NSString *)getUserSex{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"sex"];
}

#pragma mark 获取社保号码
- (NSString *)getUserSocialNumber{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"socialSecurityNumber"];
}

#pragma mark 获取是否为新会员
- (NSString *)getUserIfNewMember{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"isNew"];
}

#pragma mark 获取会员头像
- (NSString *)getUserHeadPortraitFilesStr{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"headPortraitFilesStr"];
}

#pragma mark 获取是否重复提醒
-(NSString *)getUserIsRepeatedReminders{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"isRepeatedReminders"];
}

#pragma mark 积分
- (NSString *)getUserCurrentIntegral{
    return[[NSUserDefaults standardUserDefaults]objectForKey:@"currentIntegral"];
}

#pragma mark 年龄段
- (NSString *)getUserAgeGroups{
    NSString *ageGroups = [[NSUserDefaults standardUserDefaults]objectForKey:@"ageGroups"];
    NSString *ageString = nil;
    if (!ageGroups) {
        return ageString;
    }else{
        switch (ageGroups.intValue) {
            case 0:
                ageString = UNDERTWENTY;
                break;
            case 1:
                ageString = TWENTY_THIRTY;
                break;
            case 2:
                ageString = THIRTY_FORTY;
                break;
            case 3:
                ageString = FORTY_FIFTY;
                break;
            case 4:
                ageString = ODERFIFTY;
                break;
                
            default:
                break;
        }
    }
    return ageString;
}

- (NSString *)getUserAgeInteger{
    NSString *intAgeGroup = [[NSUserDefaults standardUserDefaults]objectForKey:@"ageGroups"];
    return intAgeGroup;
}

#pragma mark 手机版本
- (NSString *)getUserAppVersion{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"appVersion"];
}

#pragma mark 生日
- (NSString *)getUserBirthday{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"birthday"];
}

#pragma mark 生日字符串
- (NSString *)getUserBirthdayStr{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"birthdayStr"];
}

#pragma mark channelId
- (NSString *)getUserChannelId{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"channelId"];
}

#pragma mark 头像文件
- (NSString *)getUserHeadPortraitFiles{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"headPortraitFiles"];
}

#pragma mark 精度
- (NSString *)getUserLatitude{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"latitude"];
}

#pragma mark 维度
- (NSString *)getUserLongitude{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"longitude"];
}

#pragma mark 手机型号
- (NSString *)getUserMobileModel{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"mobileModel"];
}

#pragma mark 手机系统
- (NSString *)getUserMobileSystemType{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"mobileSystemType"];
}

#pragma mark 手机系统版本
- (NSString *)getUserMobileSystemVersion{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"mobileSystemVersion"];
}

#pragma mark 推送id
- (NSString *)getUserPushId{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"pushId"];
}

#pragma mark 二维码
- (NSString *)getUserQrCode{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"qrCode"];
}

#pragma mark 二维码字符串
- (NSString *)getUserQrStr{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"qrStr"];
}

#pragma mark 注册时间
- (NSString *)getUserRegDate{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"regDate"];
}

#pragma mark 备注
- (NSString *)getUserRemark{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"remark"];
}

#pragma mark sourceType
- (NSString *)getUserSourceType{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"sourceType"];
}

#pragma mark 用户状态
- (NSString *)getUserStatus{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"status"];
}

#pragma mark UUID
- (NSString *)getUserUUID{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"uuid"];
}

#pragma mark - 获取设备信息
#pragma mark 获取手机UUID
+(NSString *)getTelePhoneUUID{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];;
}

#pragma mark 获取手机系统版本
+(NSString *)getPhoneVersion{
    return [[UIDevice currentDevice] systemVersion];
}

#pragma mark 手机系统
+(NSString *)getPhoneSystem{
    return [[UIDevice currentDevice] systemName];
}

#pragma mark 手机类型
+(NSString *)getTelephoneType{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"]) return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
    return platform;
    
}

#pragma mark - 清空用户信息
-(void)cleanUserAllInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"isLoginSataus"];
    [userDefaults removeObjectForKey:@"flashImageURL"];
    [userDefaults removeObjectForKey:@"flashImageData"];
    [userDefaults removeObjectForKey:@"firstJoinMember"];
    
    [userDefaults removeObjectForKey:@"ageGroupString"];
    [userDefaults removeObjectForKey:@"appVersion"];
    [userDefaults removeObjectForKey:@"birthday"];
    [userDefaults removeObjectForKey:@"birthdayStr"];
    [userDefaults removeObjectForKey:@"channelId"];
    [userDefaults removeObjectForKey:@"currentIntegral"];
    [userDefaults removeObjectForKey:@"headPortraitFiles"];
    [userDefaults removeObjectForKey:@"headPortraitFilesStr"];
    [userDefaults removeObjectForKey:@"uid"];
    [userDefaults removeObjectForKey:@"isNew"];
    [userDefaults removeObjectForKey:@"latitude"];
    [userDefaults removeObjectForKey:@"longitude"];
    [userDefaults removeObjectForKey:@"mobileModel"];
    [userDefaults removeObjectForKey:@"mobileSystemType"];
    [userDefaults removeObjectForKey:@"mobileSystemVersion"];
    [userDefaults removeObjectForKey:@"name"];
    [userDefaults removeObjectForKey:@"pushId"];
    [userDefaults removeObjectForKey:@"qrCode"];
    [userDefaults removeObjectForKey:@"qrStr"];
    [userDefaults removeObjectForKey:@"regDate"];
    [userDefaults removeObjectForKey:@"remark"];
    [userDefaults removeObjectForKey:@"ageGroups"];
    [userDefaults removeObjectForKey:@"sex"];
    [userDefaults removeObjectForKey:@"socialSecurityNumber"];
    [userDefaults removeObjectForKey:@"sourceType"];
    [userDefaults removeObjectForKey:@"status"];
    [userDefaults removeObjectForKey:@"tel"];
    [userDefaults removeObjectForKey:@"token"];
    [userDefaults removeObjectForKey:@"uuid"];
    [userDefaults removeObjectForKey:@"RepeatedReminders"];
    [userDefaults removeObjectForKey:@"deviceToken"];
    
    [userDefaults synchronize];
    
    _loginBaseUser = nil;
    _loginDict = nil;
}

#pragma mark - 单个文件大小的计算
+(long long)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size;
    }
    return 0;
}

#pragma mark - 文件夹大小的计算
+(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    cachePath=[cachePath stringByAppendingPathComponent:path];
    long long folderSize=0;
    if ([fileManager fileExistsAtPath:cachePath]){
        NSArray *childerFiles=[fileManager subpathsAtPath:cachePath];
        for (NSString *fileName in childerFiles){
            NSString *fileAbsolutePath=[cachePath stringByAppendingPathComponent:fileName];
            long long size=[self fileSizeAtPath:fileAbsolutePath];
            folderSize += size;
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize];
        return folderSize/1024.0/1024.0;
    }
    return 0;
}

#pragma mark - 清理缓存
+(void)clearCache:(NSString *)path{
    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    cachePath=[cachePath stringByAppendingPathComponent:path];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:cachePath]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:cachePath];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *fileAbsolutePath=[cachePath stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:fileAbsolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}

@end
