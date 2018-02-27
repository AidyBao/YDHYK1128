//
//  ZXHUD.m
//  ZXStructure
//
//  Created by JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "ZXHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation ZXHUD
//MARK: - MB
+ (void)MBShowSuccessInView:(UIView *)view text:(NSString *)text delay:(NSTimeInterval)delay{
    MBProgressHUD * mbp = [MBProgressHUD showHUDAddedTo:view animated:true];
    mbp.mode = MBProgressHUDModeCustomView;
    mbp.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ltrue"]];
    mbp.label.text = text;
    mbp.label.font = [UIFont zx_titleFontWithSize:15];
    mbp.minSize = CGSizeMake(100, 100);
    mbp.label.textColor = ZXWHITE_COLOR;
    mbp.bezelView.layer.cornerRadius = 10.0;
    mbp.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    mbp.bezelView.color = ZXRGBA_COLOR(0, 0, 0, 0.7);
    if (delay > 0) {
        [mbp hideAnimated:true afterDelay:delay];
    }
    mbp.removeFromSuperViewOnHide = true;
}

+ (void)MBShowFailureInView:(UIView *)view text:(NSString *)text delay:(NSTimeInterval)delay{
    MBProgressHUD * mbp = [MBProgressHUD showHUDAddedTo:view animated:true];
    mbp.mode = MBProgressHUDModeCustomView;
    mbp.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Lmistake"]];
    mbp.label.text = text;
    mbp.label.font = [UIFont zx_titleFontWithSize:15];
    mbp.minSize = CGSizeMake(100, 100);
    mbp.label.textColor = ZXWHITE_COLOR;
    mbp.bezelView.layer.cornerRadius = 10.0;
    mbp.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    mbp.bezelView.color = ZXRGBA_COLOR(0, 0, 0, 0.7);
    if (delay > 0) {
        [mbp hideAnimated:true afterDelay:delay];
    }
    mbp.removeFromSuperViewOnHide = true;
}

+ (void)MBShowLoadingInView:(UIView *)view text:(NSString *)text delay:(NSTimeInterval)delay{
    MBProgressHUD * mbp = [MBProgressHUD showHUDAddedTo:view animated:true];
    mbp.mode = MBProgressHUDModeCustomView;
    UIImageView * customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Loading"]];
    CABasicAnimation * anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima.toValue = @(M_PI*2);
    anima.duration = 1.0f;
    anima.repeatCount = NSUIntegerMax;
    anima.removedOnCompletion = false;
    [customView.layer addAnimation:anima forKey:nil];
    mbp.customView = customView;
    mbp.label.text = text;
    mbp.label.font = [UIFont zx_titleFontWithSize:15];
    mbp.minSize = CGSizeMake(100, 100);
    mbp.label.textColor = ZXWHITE_COLOR;
    mbp.bezelView.layer.cornerRadius = 10.0;
    mbp.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    mbp.bezelView.color = ZXRGBA_COLOR(0, 0, 0, 0.7);
    if (delay > 0) {
        [mbp hideAnimated:true afterDelay:delay];
    }
    mbp.removeFromSuperViewOnHide = true;
}

+ (void)MBHideForView:(UIView *)view animate:(BOOL)animate{
    [MBProgressHUD hideHUDForView:view animated:animate];
}


@end
