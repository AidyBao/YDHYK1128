//
//  HMessageSortModel.h
//  YDHYK
//
//  Created by screson on 2016/12/14.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXMessageSortModel : NSObject

//接口返回
@property (nonatomic,copy) NSString * msgId;  //消息Id
@property (nonatomic,copy) NSString * title;  //消息标题
@property (nonatomic,copy) NSNumber * isRead; //1：已读 0：未读  1  2
@property (nonatomic,copy) NSString * sendDateStr;
@property (nonatomic,copy) NSNumber * type;   //1：现金券 2：促销活动

//调整
@property (nonatomic,copy) NSString * msgDesc;   //描述：您有一张新的现金券，有一个新的促销活动
@property (nonatomic,assign) BOOL  readed;//
//@property (nonatomic,copy) NSString * dateString;

@end
