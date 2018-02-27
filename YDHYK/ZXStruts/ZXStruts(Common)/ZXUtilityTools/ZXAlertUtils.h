//
//  ZXAlertUtils.h
//  YDHYK
//
//  Created by JuanFelix on 30/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

/**警告框工具类*/
@interface ZXAlertUtils : NSObject

/**无事件处理*/
+ (void)showAAlertMessage:(NSString *)msg
                    title:(NSString *)title;
/**单个按钮+事件处理*/
+ (void)showAAlertMessage:(NSString *)msg
                    title:(NSString *)title
               buttonText:(NSString *)buttonText
             buttonAction:(void (^)())buttonAction;
/**多个按钮+事件处理*/
+ (void)showAAlertMessage:(NSString *)msg
                    title:(NSString *)title
              buttonTexts:(NSArray *)arrTexts
             buttonAction:(void (^)(int buttonIndex))buttonAction;

+ (UIViewController *)keyController;

@end
