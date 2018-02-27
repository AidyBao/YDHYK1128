//
//  YDNearbyRootViewController.h
//  ydhyk
//
//  Created by 120v on 2016/10/21.
//  Copyright © 2016年 120v. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 引入地图功能所有的头文件(百度地图)*/
#import <BaiduMapAPI_Map/BMKMapComponent.h>
/** 引入定位功能所有的头文件(百度地图)*/
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
/** 引入计算工具所有的头文件(百度地图)*/
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
/** 底部药店详情View*/
#import "YDDetailView.h"
#import <MapKit/MapKit.h>

@interface YDNearbyRootViewController : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,YDDetailViewDelegate>

@property (nonatomic, strong) NSArray *modelArray;

@property (nonatomic, strong) NSArray *modelArray_store;

/** isLocationButtonClick：判断是否为列表页面“定位”按钮点击事件*/
@property (nonatomic,assign) BOOL isLocationButtonClick;

@end
