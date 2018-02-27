//
//  YDReceiverAddressTableViewController.h
//  ydhyk
//
//  Created by Aidy Bao on 2016/11/13.
//  Copyright © 2016年 120v. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDReceiverAddressModel;
@protocol ZXAddressListSelectedDelegate <NSObject>

@optional
- (void)zxAddressListSelected:(YDReceiverAddressModel * _Nullable )address;

@end

@interface YDReceiverAddressTableViewController : UITableViewController

@property (nonatomic ,weak) id<ZXAddressListSelectedDelegate> delegagte;

@end
