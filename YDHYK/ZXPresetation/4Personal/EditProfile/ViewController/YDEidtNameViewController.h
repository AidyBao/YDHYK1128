//
//  YDEidtNameViewController.h
//  ydhyk
//
//  Created by Aidy Bao on 2016/11/13.
//  Copyright © 2016年 120v. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDEidtNameViewController;

@protocol YDEidtNameViewControllerDelegate <NSObject>

-(void)FeedbackString:(NSString *)string;

@end

@interface YDEidtNameViewController : UIViewController

@property (nonatomic, weak) id<YDEidtNameViewControllerDelegate> delegate;

@property (nonatomic, copy) NSString *name;

@end
