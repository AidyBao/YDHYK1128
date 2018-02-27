//
//  ZXGlobalData.h
//  YDHYK
//
//  Created by JuanFelix on 01/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXGlobalData : NSObject

+ (instancetype)shareInstance;
/**消息推送Token*/
@property (nonatomic,copy) NSString * deviceToken;

@property (nonatomic,copy,readonly) NSString * userToken;
@property (nonatomic,copy,readonly) NSString * memberId;
@property (nonatomic,copy,readonly) NSString * userTelephone;
//@property (nonatomic,copy) NSString * userToken;
//@property (nonatomic,copy) NSString * memberId;

@end
