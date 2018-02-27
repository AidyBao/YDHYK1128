//
//  HJoinLeadViewController.h
//  YDHYK
//
//  Created by JuanFelix on 01/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^HJoinLeadBlock)(void);

@interface HJoinLeadViewController : UIViewController

/**显示加入会员引导界面 只显示一次*/
+ (void)checkShowWithCompletion:(HJoinLeadBlock)completion;

@end
