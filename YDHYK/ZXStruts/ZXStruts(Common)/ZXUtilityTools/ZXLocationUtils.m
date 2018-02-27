//
//  ZXLocationUtils.m
//  YDHYK
//
//  Created by screson on 2017/3/24.
//  Copyright © 2017年 screson. All rights reserved.
//

#import "ZXLocationUtils.h"
#import <CoreLocation/CoreLocation.h>
static ZXLocationUtils * zxLocation = nil;

@implementation ZXLocationUtils
{
    CLLocationManager * locationManager;
    BOOL located;
}

+ (instancetype)shareInstance{
    if (!zxLocation) {
        zxLocation = [[ZXLocationUtils alloc] init];
    }
    return zxLocation;
}

- (void)checkCurrentLoaction:(ZXCheckLocation)completion{
    located = false;
    _checkEnd = completion;
    [locationManager startUpdatingLocation];
}

- (instancetype)init{
    if (self = [super init]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        [locationManager requestWhenInUseAuthorization];
        located = false;
    }
    return self;
}

#pragma mark - LocationDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if (_checkEnd) {
        _checkEnd(false,nil);
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if (located) {
        return;
    }
    located = true;
    [manager stopUpdatingLocation];
    if (_checkEnd) {
        _checkEnd(true,[locations lastObject]);
    }
}

@end
