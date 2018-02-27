//
//  AppDelegate+BMap.m
//  ydhyk
//
//  Created by screson on 2016/10/21.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "AppDelegate+BMap.h"
#import <CoreLocation/CoreLocation.h>

BMKMapManager* _mapManager;
CLLocationManager *_manger;

@implementation AppDelegate (BMap)

#pragma mark - 要使用百度地图，请先启动BaiduMapManager
-(void)launchBaiDuMap{
    NSString *BaiDu_Key = ZX_BaiDuMap_AppStore_Key;//AppStore
    if ([[ZXCommonUtils getBundleId] isEqualToString:ENTERPRISE_BUNDLE_ID]) {
        BaiDu_Key = ZX_BaiDuMap_Enterprise_Key;//Enterprise
    }
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:BaiDu_Key generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}

- (void)onGetNetworkState:(int)iError{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
}

- (void)onGetPermissionState:(int)iError{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

#pragma mark -获取经纬度
-(void)getLocation{
    _manger=[[CLLocationManager alloc]init];
    _manger.desiredAccuracy =kCLLocationAccuracyBest;
    _manger.delegate=self;
    _manger.distanceFilter =10;
    [_manger requestAlwaysAuthorization];
    [_manger startUpdatingLocation];
}

#pragma collcationManager的代理方法:获取经纬度
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if (self.userlocation.coordinate.longitude && self.userlocation.coordinate.latitude) {
        [_manger stopUpdatingLocation];
        [[NSNotificationCenter defaultCenter] postNotificationName:ZXNOTICE_NOTIFICATION_ISFIRSTLOCATION object:[locations objectAtIndex:0]];
        
        return;
    }
    self.userlocation=[locations objectAtIndex:0];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([error code] == kCLErrorDenied)    {
        //访问被拒绝
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
    }
    
    //设置默认位置为公司地址
    CLLocation *userLo = [[CLLocation alloc]initWithLatitude:[ZX_Detail_Latitude doubleValue] longitude:[ZX_Detail_Longitude doubleValue]];
    self.userlocation = userLo;
}



@end
