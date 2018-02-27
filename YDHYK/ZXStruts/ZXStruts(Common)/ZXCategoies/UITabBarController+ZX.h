//
//  UITabBarController+ZX.h
//  ZXStructure
//
//  Created by JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXTabbarItem.h"

@interface ZXModelVCInfo : NSObject

@property (nonatomic,copy)   NSString * className;
@property (nonatomic,strong) ZXTabbarItem * item;

@end

/**TabBar 扩展*/

@interface UITabBarController (ZX)

/**zxtabbaritems 不包括系统的*/
@property (nonatomic,strong,readonly) NSMutableArray<ZXTabbarItem *> * zxtarbarItems;

/**present 的controller 信息*/
//待优化
@property (nonatomic,strong,readonly) NSMutableDictionary * zxModelControllersInfo;

/**添加Controller*/
- (void)zx_addChildViewController:(UIViewController *)vc
                         withItem:(ZXTabbarItem *)item;

/**添加Controller,资源从plist读取*/
- (void)zx_addChildViewController:(UIViewController *)vc
                     atPlistIndex:(NSInteger)index;
/**ShowAsPresent*/
+ (BOOL)zx_tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;

@end
