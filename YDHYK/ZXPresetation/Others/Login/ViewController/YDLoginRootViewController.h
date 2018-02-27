//
//  YDLoginRootViewController.h
//  YDHYK
//
//  Created by 120v on 2016/11/29.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDLoginRootViewController : UIViewController

/** 处理登录失效*/
@property (nonatomic, assign) BOOL logonFailue;

/** 上次登录账号*/
@property (nonatomic, copy) NSString *lastLoginID;

@end
