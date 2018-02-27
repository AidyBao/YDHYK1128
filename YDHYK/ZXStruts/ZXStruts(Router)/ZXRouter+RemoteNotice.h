//
//  ZXRouter+RemoteNotice.h
//  ZXStructure
//
//  Created by JuanFelix on 2016/11/25.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXRouter.h"

typedef enum : NSUInteger {
    ZXRemoteNoticeTypeCouponUpdate,
    ZXRemoteNoticeTypePromotionUpdate,
    ZXRemoteNoticeTypeOrderUpdate,
    ZXRemoteNoticeTypeTakeMedicine,
    ZXRemoteNoticeTypeTakeUnknown
} ZXRemoteNoticeType;

@interface ApsModel : NSObject

@property (nonatomic,strong) NSString * alert;
@property (nonatomic,strong) NSNumber * badge;

@end

@interface ZXRemoteNoticeModel : NSObject

@property (nonatomic,strong) ApsModel * aps;
@property (nonatomic,strong) NSString * pushId;
@property (nonatomic,strong) NSString * pushType;  //文本
@property (nonatomic,strong) NSString * remindTime;//提醒时间
@property (nonatomic,strong) NSString * remindDetailTime;//提醒详细日期时间

//调整
@property (nonatomic,assign) ZXRemoteNoticeType type;
@property (nonatomic,assign) BOOL fromUserTap;


@end

/** 远程通知 界面跳转控制 */
@interface ZXRouter (RemoteNotice)

//+ (void)cacheLatestNotice:(NSDictionary *)noticeInfo;

+ (void)showNoticeDetail:(NSDictionary *)userInfo;

+ (void)checkNoticeCache;

@end
