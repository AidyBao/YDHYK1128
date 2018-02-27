//
//  ZXFullCheckListViewController.h
//  YDHYK
//
//  Created by screson on 2016/12/19.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZXCheckEnd)(NSInteger index,NSString * name);

@interface ZXFullCheckListViewController : UIViewController

@property (nonatomic,strong) NSArray<NSString *> * checkList;
@property (nonatomic,copy) NSString * titleName;
@property (nonatomic,copy) ZXCheckEnd checkEnd;

+ (void)presentOnVC:(UIViewController *)vc
              title:(NSString *)title
            checkList:(NSArray<NSString *> *)checkList
           completion:(ZXCheckEnd)completion;

@end
