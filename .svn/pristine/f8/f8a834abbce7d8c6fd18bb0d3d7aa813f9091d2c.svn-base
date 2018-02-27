//
//  UITabBarController+ZX.m
//  ZXStructure
//
//  Created by JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "UITabBarController+ZX.h"
#import "ZXTabBarConfig.h"
#import <objc/runtime.h>


@interface ZXUINavigationController: UINavigationController
@end

@implementation ZXUINavigationController

- (BOOL)prefersStatusBarHidden { return false; }

- (UIViewController *)childViewControllerForStatusBarStyle {
    //return self.topViewController;
    return self.visibleViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.visibleViewController;
}

@end


@implementation ZXModelVCInfo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end


@implementation UITabBarController (ZX)

- (void)zx_addChildViewController:(UIViewController *)vc
                         withItem:(ZXTabbarItem *)item{
    if (vc) {
        UIImage * normalImage = [UIImage imageNamed:item.normalImage];
        normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.image = normalImage;
        
        UIImage * selectedImage = [UIImage imageNamed:item.selectedImage];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = selectedImage;
        vc.tabBarItem.title = item.name;
        if (!self.zxModelControllersInfo) {
            self.zxModelControllersInfo = [NSMutableDictionary dictionary];
        }
        
        if (item.embedInNavigation) {
            if (item.showAsPresent) {
                //待优化                
                ZXModelVCInfo * mInfo = [[ZXModelVCInfo alloc] init];
                [mInfo setValuesForKeysWithDictionary:@{@"className":NSStringFromClass([vc class]),@"item":item}];
                [self.zxModelControllersInfo setObject:mInfo forKey:[NSNumber numberWithInteger:self.viewControllers.count]];
                
                [self xxx_addChildViewContoller:[[UIViewController alloc] init] withItem:item];
                
            }else{
                [self addChildViewController:[[ZXUINavigationController alloc] initWithRootViewController:vc]];
            }
        }else{
            if (item.showAsPresent) {
                //待优化
                
                //
                ZXModelVCInfo * mInfo = [[ZXModelVCInfo alloc] init];
                [mInfo setValuesForKeysWithDictionary:@{@"className":NSStringFromClass([vc class]),@"item":item}];
                [self.zxModelControllersInfo setObject:mInfo forKey:[NSNumber numberWithInteger:self.viewControllers.count]];
                [self xxx_addChildViewContoller:[[UIViewController alloc] init] withItem:item];
            }else{
                [self addChildViewController:vc];
            }
        }
        
        if (!self.zxtarbarItems) {
            self.zxtarbarItems = [NSMutableArray array];
        }
        [self.zxtarbarItems addObject:item];
    }
}

- (void)xxx_addChildViewContoller:(UIViewController *)vc withItem:(ZXTabbarItem *)item{
    UIImage * normalImage = [UIImage imageNamed:item.normalImage];
    normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = normalImage;
    
    UIImage * selectedImage = [UIImage imageNamed:item.selectedImage];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = selectedImage;
    vc.tabBarItem.title = item.name;
    [self addChildViewController:vc];
}

- (void)zx_addChildViewController:(UIViewController *)vc atPlistIndex:(NSInteger)index{
    NSArray * items = [ZXTabBarConfig tabbarItems];
    if (items && index < items.count) {
        ZXTabbarItem * item = [items objectAtIndex:index];
        [self zx_addChildViewController:vc withItem:item];
    }
}

+ (BOOL)zx_tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    __block NSInteger index = -1;
    [tabBarController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == viewController) {
            index = idx;
            *stop = true;
        }
    }];
    if (index != -1) {
        ZXModelVCInfo * info = [tabBarController.zxModelControllersInfo objectForKey:[NSNumber numberWithInteger:index]];
        ZXTabbarItem * item = info.item;
        if (item.showAsPresent) {
            if (item.embedInNavigation) {
                Class cls = NSClassFromString(info.className);
                [tabBarController presentViewController:[[ZXUINavigationController alloc] initWithRootViewController:[cls new]] animated:true completion:nil];
            }else{
                Class cls = NSClassFromString(info.className);
                [tabBarController presentViewController:[cls new] animated:true completion:nil];
            }
            return false;
        }
    }
    return true;
}

#pragma mark ---

static const char * ZXTarbarItems = "ZXTarbarItems";

- (NSMutableArray<ZXTabbarItem *> *)zxtarbarItems{
    return  objc_getAssociatedObject(self, ZXTarbarItems);
}

- (void)setZxtarbarItems:(NSMutableArray<ZXTabbarItem *> *)zxtarbarItems{
    objc_setAssociatedObject(self, ZXTarbarItems, zxtarbarItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const char * ZXModelControllersInfo = "ZXModelControllersInfo";

- (NSMutableDictionary *)zxModelControllersInfo{
    return  objc_getAssociatedObject(self, ZXModelControllersInfo);
}

- (void)setZxModelControllersInfo:(NSMutableDictionary *)zxModelControllersInfo{
    objc_setAssociatedObject(self, ZXModelControllersInfo, zxModelControllersInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
