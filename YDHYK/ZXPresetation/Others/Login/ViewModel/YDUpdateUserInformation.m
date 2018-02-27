//
//  YDUpdateUserInformation.m
//  YDHYK
//
//  Created by 120v on 2017/1/13.
//  Copyright © 2017年 screson. All rights reserved.
//

#import "YDUpdateUserInformation.h"
#import "YDFlashScreenModel.h"

@implementation YDUpdateUserInformation

#pragma mark 获取设备信息
+(void)httpRequestForUpdateEquipmentInfoWithDeviceToken:(NSString *)deviceToken{
    //会员ID
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    //token
    NSString *token = [[YDAPPManager shareManager]getUserToken];
    //手机UUID
    NSString *telePhoneUUID = [YDAPPManager getTelePhoneUUID];
    //手机系统版本
    NSString *phoneVersion = [YDAPPManager getPhoneVersion];
    //手机系统类型
    NSString *mobileSystemType = [YDAPPManager getPhoneSystem];
    //手机型号
    NSString *mobileModel = [YDAPPManager getTelephoneType];
    //BundleID
    NSString *packageName = [ZXCommonUtils getBundleId];
    
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }
    if (telePhoneUUID) {
        [dicParams setObject:telePhoneUUID forKey:@"uuid"];
    }
    if (mobileSystemType) {
        [dicParams setObject:mobileSystemType forKey:@"mobileSystemType"];
    }
    if (phoneVersion) {
        [dicParams setObject:phoneVersion forKey:@"mobileSystemVersion"];
    }
    if (mobileModel) {
        [dicParams setObject:mobileModel forKey:@"mobileModel"];
    }
    if(deviceToken){
        [dicParams setObject:deviceToken forKey:@"deviceToken"];
    }
    
    if(packageName){
        [dicParams setObject:packageName forKey:@"packageName"];
    }
    
    [dicParams setObject:[ZXCommonUtils getBundleVersion] forKey:@"appVersion"];
    
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Update_Equipment) params:dicParams token:token method:POST zxCompletion:nil];
}

#pragma mark 更新会员位置
+(void)httpUpdateMemberPostionWithLocation:(CLLocation *)location{
    
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *latitude =[NSString stringWithFormat:@"%f",location.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];;
    
    NSString *token = [[YDAPPManager shareManager]getUserToken];
    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }
    if (latitude) {
        [dicParams setObject:latitude forKey:@"latitude"];
    }
    if (longitude) {
        [dicParams setObject:longitude forKey:@"longitude"];
    }
    
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Update_Position) params:dicParams token:token method:POST zxCompletion:nil];
}

#pragma mark 网络请求闪屏信息并保存
+(void)httpRequestForFlashScreenWithSexString:(NSString *)sex AgeGroup:(NSString *)ageGroup{
    
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager]getUserToken];
    
    if (sex) {
        [dicParams setObject:sex forKey:@"sex"];
    }
    if (ageGroup) {
        [dicParams setObject:ageGroup forKey:@"ageGroups"];
    }
    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_FlashScreen) params:dicParams token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (success) {
            if (status == ZXAPI_SUCCESS) {//
                id obj = content[@"data"];
                if([obj isKindOfClass:[NSDictionary class]]){
                    NSDictionary *dict = obj;
                    YDFlashScreenModel *model = [YDFlashScreenModel mj_objectWithKeyValues:dict];
                    if (model.attachFileStr) {
                        [[YDAPPManager shareManager]saveFlashImageURL:model.attachFileStr];
                    }
                }else{
                    [[YDAPPManager shareManager]saveFlashImageURL:nil];
                }
            }
        }else{
        }
    }];
}

@end
