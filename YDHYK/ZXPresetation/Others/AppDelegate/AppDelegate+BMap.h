//
//  AppDelegate+BMap.h
//  ydhyk
//
//  Created by screson on 2016/10/21.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "AppDelegate.h"
//地图
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface AppDelegate (BMap)<BMKGeneralDelegate,CLLocationManagerDelegate>

-(void)launchBaiDuMap;
// 获取经纬度
-(void)getLocation;

@end
