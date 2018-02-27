//
//  HMessageDetailModel.h
//  YDHYK
//
//  Created by screson on 2016/12/14.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXMessageDetailModel : NSObject

@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * content;  //type=1时无该字段
@property (nonatomic,copy) NSString * useRule;  //type=2时无该字段
@property (nonatomic,copy) NSString * sendDateStr;

@end
