//
//  AppDelegate.h
//  YDHYK
//
//  Created by screson on 2016/11/28.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BOOL isProcessed;
}

@property (strong, nonatomic) UIWindow *window;
/** 判断是否已经连接 */
@property (nonatomic,assign) BOOL isConnected;
/** 经纬度 */
@property (nonatomic, strong) CLLocation *userlocation;
/** 判断定位是否开启 */
@property (nonatomic, copy) NSString *isOpenLoction;
/** 判断通知是否开启 */
@property (nonatomic, copy) NSString *isOpenNotice;

@end

