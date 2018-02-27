//
//  ZXNoDataView.h
//  YDHYK
//
//  Created by JuanFelix on 2016/12/9.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZXRCallBack)(void);

/**无数据或者无网络界面*/
@interface ZXEmptyView : UIView
/**无数据 [heightFix 用于调整高度 默认给0就行] */
+ (void)showNoDataInView:(UIView *)view
                   text1:(NSString *)text1
                   text2:(NSString *)text2
               heightFix:(CGFloat)heightFix;
/**无网络或接口错误  [用于调整高度 默认给0就行]*/
+ (void)showNetworkErrorInView:(UIView *)view
                     heightFix:(CGFloat)heightFix
                 refreshAction:(ZXRCallBack)refreshAction
                     ;
+ (void)dismissInView:(UIView *)view;
@end
