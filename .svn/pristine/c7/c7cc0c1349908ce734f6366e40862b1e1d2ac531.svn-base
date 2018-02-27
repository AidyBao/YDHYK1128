//
//  HDrugPresetationController.m
//  YDHYK
//
//  Created by screson on 2016/12/26.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HDrugPresetationController.h"


@interface HDrugPresetationController()
@property (nonatomic,strong) UIView * maskView;
@end

@implementation HDrugPresetationController
//
//UIBlurEffectStyleExtraLight,
//UIBlurEffectStyleLight,
//UIBlurEffectStyleDark,
//UIBlurEffectStyleExtraDark __TVOS_AVAILABLE(10_0) __IOS_PROHIBITED __WATCHOS_PROHIBITED,
//UIBlurEffectStyleRegular NS_ENUM_AVAILABLE_IOS(10_0), // Adapts to user interface style
//UIBlurEffectStyleProminent NS_ENUM_AVAILABLE_IOS(10_0), // Adapts to user interface style

- (UIView *)maskView{
    if (_maskView == nil) {
        //处理时间太长，cell 点击显示过慢
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
//            UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//            _maskView = [[UIVisualEffectView alloc] initWithEffect:blur];
//            [_maskView setFrame:CGRectZero];
//        }else{
//            _maskView = [[UIView alloc] initWithFrame:CGRectZero];
//            [_maskView setBackgroundColor:ZXRGBA_COLOR(0, 0, 0, 0.35)];
//        }
        _maskView = [[UIView alloc] initWithFrame:CGRectZero];
        [_maskView setBackgroundColor:ZXRGBA_COLOR(0, 0, 0, 0.5)];
    
    }
    return _maskView;
}

-(void)presentationTransitionWillBegin{
    self.maskView.frame = self.containerView.bounds;
    [self.containerView insertSubview:self.maskView atIndex:0];
    
    self.maskView.alpha = 0;
    if (self.presentedViewController.transitionCoordinator) {
        [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
//                self.maskView.alpha = 0.8;
//            }else{
//                self.maskView.alpha = 1.0;
//            }
            self.maskView.alpha = 1.0;
        } completion:nil];
    }
}

-(void)dismissalTransitionWillBegin{
    if (self.presentedViewController.transitionCoordinator) {
        [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self.maskView.alpha = 0;
            
        } completion:nil];
    }
}

-(BOOL)shouldRemovePresentersView{
    return false;
}


@end
