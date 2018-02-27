//
//  ZXAlertUtils.m
//  YDHYK
//
//  Created by JuanFelix on 30/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "ZXAlertUtils.h"

@implementation ZXAlertUtils

+ (void)showAAlertMessage:(NSString *)msg title:(NSString *)title{
    NSString * strT = title;
    if (!title) {
        strT = @"提示";
    }
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:strT message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [[self keyController] presentViewController:alert animated:true completion:nil];
}

+ (UIViewController *)keyController{
    UIViewController * keyController = [[ZXRootViewControllers window] rootViewController];
    do{
        if (keyController.presentedViewController) {
            keyController = keyController.presentedViewController;
        }else{
            break;
        }
    }while(keyController.presentedViewController);
    return keyController;
}

+ (void)showAAlertMessage:(NSString *)msg title:(NSString *)title buttonText:(NSString *)buttonText buttonAction:(void (^)())buttonAction{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title ? title : @"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:buttonText ? buttonText :@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (buttonAction) {
            buttonAction();
        }
    }]];
    [[self keyController] presentViewController:alert animated:true completion:nil];
}

+ (void)showAAlertMessage:(NSString *)msg title:(NSString *)title buttonTexts:(NSArray *)arrTexts buttonAction:(void (^)(int buttonIndex))buttonAction{
    
    if (arrTexts && arrTexts.count) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:title ? title : @"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        int index = 0;
        for (NSString * strText in arrTexts) {
            [alert addAction:[UIAlertAction actionWithTitle:strText ? strText :@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (buttonAction) {
                    buttonAction(index);
                }
            }]];
            index++;
        }
        [[self keyController] presentViewController:alert animated:true completion:nil];
    }
}

@end
