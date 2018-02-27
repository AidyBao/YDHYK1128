//
//  ZXNotificationNames.h
//  YDHYK
//
//  Created by screson on 2016/11/28.
//  Copyright © 2016年 screson. All rights reserved.
//

#ifndef ZXNotificationNames_h
#define ZXNotificationNames_h

#define ZXNOTICE_JOINMEMBER_SUCCESS             @"ZXNOTICE_JOINMEMBER_SUCCESS"      //加入会员成功
#define ZXNOTICE_LOGIN_OFFLINE                  @"ZXNOTICE_LOGIN_OFFLINE"           //登录失效通知
#define ZXNOTICE_RECEIVE_REMOTE_NOTICE          @"ZXNOTICE_RECEIVE_REMOTE_NOTICE"   //个人中心角标更新

#pragma mark - 附近模块
#define ZXNOTICE_LOCATION_ISOPEN                @"observerLocationStatus"//监听定位是否开启

#pragma mark - 用药提醒模块
#define ZXNOTICE_NEW_ADD_DRUGREMIND             @"addDrugRemindTime"//新增用药提醒通知

#pragma mark - 用药提醒
#define ZXNOTICE_NOTIFICATION_ISOPEN            @"ZXNOTICE_NOTIFICATION_ISOPEN"//监听通知是否开启

#pragma mark - 修改需要服用的药品时间通知
#define ZXNOTICE_NOTIFICATION_ModifyTime        @"ZXNOTICE_NOTIFICATION_ModifyTime"//修改需要服用的药品时间通知

#pragma mark - 启动
#define ZXNOTICE_NOTIFICATION_ISFIRSTLOCATION   @"ZXNOTICE_NOTIFICATION_ISFIRSTLOCATION"//是否获取到经纬度

#pragma mark - 启动
#define ZXNOTICE_NOTIFICATION_GETDEVICETOKEN    @"ZXNOTICE_NOTIFICATION_GETDEVICETOKEN"//是否获取到DeviceTolen

#define ZXNOTICE_LOGIN_SUCCESS                  @"ZXNOTICE_LOGIN_SUCCESS"//登录成功

#endif /* ZXNotificationNames_h */
