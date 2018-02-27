//
//  ZXCommonUtils.m
//  YDHYK
//
//  Created by screson on 2016/12/17.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXCommonUtils.h"
#import <SAMKeychain/SAMKeychain.h>

@implementation ZXCommonUtils

+ (void)load{
    
    if (![SAMKeychain passwordForService:@"35b21323e4d84be28d4ee387c56f201a" account:@"ZXAccount"]) {
        [SAMKeychain setPassword:@"ZXAccount" forService:@"35b21323e4d84be28d4ee387c56f201a" account:@"ZXAccount"];
        [SAMKeychain setPassword:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forService:@"35b21323e4d84be28d4ee387c56f201a" account:@"874625f3145b4ba7847f4ffca62430cf"];
    }
}


+ (void)openApplicationURL:(NSString *)url{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
#else
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
#endif
}

+ (void)openCallWithTelNum:(NSString *)telNum failBlock:(void(^)())failBlock{
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",telNum]];
    
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    if (!canOpen) {
        if(failBlock!=nil) failBlock(); return;
    }
    
    [self openApplicationURL:[NSString stringWithFormat:@"tel://%@",telNum]];
}

+ (NSString *)getBundleVersion{
    return [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];//
}

+ (NSString *)getBundleBuild{
    return [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];//
}

+ (NSString *)getBundleId{
    return [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]];
}

+ (NSString *)getUUID{
    return [SAMKeychain passwordForService:@"35b21323e4d84be28d4ee387c56f201a" account:@"874625f3145b4ba7847f4ffca62430cf"];
}

+ (void)showNetworkActivity:(BOOL)bShow{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:bShow];
}

@end
