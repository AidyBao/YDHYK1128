//
//  UIScrollView+ZXPullDownRefresh.h
//  YDHYK
//
//  Created by JuanFelix on 30/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

@interface UIScrollView (ZXPullDownRefresh)

/**添加下拉刷新
 * bzxImage True: 使用图片 False:使用文字
 */
-(void)zx_addHeaderRefreshActionUseZXImage:(BOOL)bzxImage
                                    target:(id)target
                                    action:(SEL)action;
/**添加上拉加载更多
 * autoRefresh True: 自动加载
 */
-(void)zx_addFooterRefreshActionAutoRefresh:(BOOL)autoRefresh
                                     target:(id)target
                                     action:(SEL)action;

@end
