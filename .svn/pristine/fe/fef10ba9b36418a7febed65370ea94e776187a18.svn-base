//
//  ZXGlobalData.m
//  YDHYK
//
//  Created by JuanFelix on 01/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "ZXGlobalData.h"

static ZXGlobalData *  zxGlobalData = nil;

@implementation ZXGlobalData

+ (instancetype)shareInstance{
    if (!zxGlobalData) {
        zxGlobalData = [[ZXGlobalData alloc] init];
    }
    return zxGlobalData;
}

- (NSString *)userToken{
    return [[YDAPPManager shareManager] getUserToken];
}

- (NSString *)userTelephone{
    return [[YDAPPManager shareManager] getUserTelephone];
}

- (NSString *)memberId{
    return [[YDAPPManager shareManager] getMemberId];
}

@end
