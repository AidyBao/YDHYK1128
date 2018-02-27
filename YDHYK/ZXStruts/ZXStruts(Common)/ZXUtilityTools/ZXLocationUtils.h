//
//  ZXLocationUtils.h
//  YDHYK
//
//  Created by screson on 2017/3/24.
//  Copyright © 2017年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ZXCheckLocation)(BOOL success,CLLocation * location);

@interface ZXLocationUtils : NSObject<CLLocationManagerDelegate>

@property (nonatomic,copy) ZXCheckLocation checkEnd;

+ (instancetype)shareInstance;
- (void)checkCurrentLoaction:(ZXCheckLocation)completion;

@end
