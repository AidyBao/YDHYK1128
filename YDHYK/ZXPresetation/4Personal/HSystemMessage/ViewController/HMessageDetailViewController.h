//
//  HMessageDetailViewController.h
//  YDHYK
//
//  Created by screson on 2016/12/9.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZXMessageTypeCoupon    = 1,
    ZXMessageTypePromotion = 2
} ZXMessageType;

/**系统消息详情*/
@interface HMessageDetailViewController : UIViewController

@property (nonatomic,copy)   NSString * messageId;
@property (nonatomic,assign) ZXMessageType type;


@end
