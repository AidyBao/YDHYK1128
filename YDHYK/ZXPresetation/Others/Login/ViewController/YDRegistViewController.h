//
//  YDRegistViewController.h
//  ydhyk
//
//  Created by 120v on 2016/10/24.
//  Copyright © 2016年 120v. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDRegistViewController;

@protocol YDRegistViewControllerDelegate <NSObject>

-(void)didSelectedRegistWithSex:(NSString *)sex withAgeGroup:(NSString *)ageGroup;

@end

@interface YDRegistViewController : UIViewController

@property (nonatomic,weak) id<YDRegistViewControllerDelegate> delegate;

@end
