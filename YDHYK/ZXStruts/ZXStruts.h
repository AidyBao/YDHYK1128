//
//  ZXStruts.h
//  ZXStructure
//
//  Created by JuanFelix on 23/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#ifndef ZXStruts_h
#define ZXStruts_h

#import "AppDelegate.h"

#import "ZXDefine.h"        //接口地址及通用常量定义

#import "ZXStrutsEngine.h"
#import "ZXCommonEngine.h"  //基础UI配置
#import "ZXHUD.h"
#import "ZXRouterEngine.h"  //界面跳转控制
#import "ZXNetworkEngine.h" //接口请求相关

#import "ZXWebEngine.h"

#import "ZXNotificationCenter.h"
#import "ZXEmptyView.h"
#import "UIScrollView+ZXPullDownRefresh.h"


#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\n %s:%d   %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

#endif /* ZXStruts_h */
