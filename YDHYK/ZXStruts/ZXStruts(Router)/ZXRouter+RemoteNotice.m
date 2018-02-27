//
//  ZXRouter+RemoteNotice.m
//  ZXStructure
//
//  Created by JuanFelix on 2016/11/25.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXRouter+RemoteNotice.h"
#import "HDrugNoticeViewController.h"
#import "HOrderDetailViewController.h"
#import "HCashCouponViewController.h"
#import "HMessageDetailViewController.h"
#import "ZXDrugNoticeControlViewModel.h"

static NSDictionary * lastNoticeInfo = nil;

@implementation ApsModel


@end

@implementation ZXRemoteNoticeModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"aps":[ApsModel class]};
}

- (ZXRemoteNoticeType)type{
    if ([_pushType isKindOfClass:[NSString class]] && _pushType.length) {
        if ([_pushType isEqualToString:@"remind"]) {
            return ZXRemoteNoticeTypeTakeMedicine;
        }
        if ([_pushType isEqualToString:@"coupon"]) {
            return ZXRemoteNoticeTypeCouponUpdate;
        }
        if ([_pushType isEqualToString:@"order"]) {
            return ZXRemoteNoticeTypeOrderUpdate;
        }
        if ([_pushType isEqualToString:@"promotion"]) {
            return ZXRemoteNoticeTypePromotionUpdate;
        }
    }
    return ZXRemoteNoticeTypeTakeUnknown;
}

@end

@implementation ZXRouter (RemoteNotice)

+ (void)showNoticeDetail:(NSDictionary *)userInfo{
    if ([userInfo isKindOfClass:[NSDictionary class]] && userInfo.count) {
        ZXRemoteNoticeModel * noticeModel = [ZXRemoteNoticeModel mj_objectWithKeyValues:userInfo];
        //if ([[ZXRootViewControllers zx_tabbarController].view window]) {
        UIViewController * rootVC = [[UIApplication sharedApplication].keyWindow rootViewController];
        if (rootVC == [ZXRootViewControllers zx_tabbarController]) {
            UIViewController * selectedVC = [[ZXRootViewControllers zx_tabbarController] selectedViewController];
            UINavigationController * nav = nil;
            if ([[ZXRootViewControllers zx_tabbarController] presentedViewController]) {//判断时候present了某个vc
                selectedVC = [[ZXRootViewControllers zx_tabbarController] presentedViewController];
            }
            if ([selectedVC isKindOfClass:[UINavigationController class]]) {
                nav = (UINavigationController *)selectedVC;
                selectedVC = [[(UINavigationController *)selectedVC viewControllers] firstObject];
            }else{
                nav = selectedVC.navigationController;
            }
            if ([selectedVC isKindOfClass:NSClassFromString(@"YDLaunchRootViewController")]||
                [selectedVC isKindOfClass:NSClassFromString(@"YDLoginRootViewController")]||
                [selectedVC isKindOfClass:NSClassFromString(@"YDRegistViewController")]||
                [selectedVC isKindOfClass:NSClassFromString(@"YDLaunchRootViewController")]) {
                lastNoticeInfo = userInfo;
                return;
            }
            if (![nav isKindOfClass:[UINavigationController class]]) {
                lastNoticeInfo = userInfo;
                return;
            }
            lastNoticeInfo = nil;
            if (noticeModel.type == ZXRemoteNoticeTypeTakeUnknown) {
                [ZXAudioUtils vibrate];
                [ZXAlertUtils showAAlertMessage:noticeModel.aps.alert title:@"新消息"];
            }else{
                if (noticeModel.type == ZXRemoteNoticeTypeTakeMedicine) {//present 不需要警告框
                    if (!noticeModel.fromUserTap) {
                        id isOn = [[YDAPPManager shareManager] getUserIsVoiceRemind];
                        if ([isOn isKindOfClass:[NSString class]] && [isOn isEqualToString:@"1"]) {
                            [ZXAudioUtils takeMedicineAudio];
                        }else{
                            [ZXAudioUtils vibrate];
                        }
                    }else{
                        [ZXAudioUtils vibrate];
                    }
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:true];
                    [ZXDrugNoticeControlViewModel getMedicineListWithRemindIds:noticeModel.pushId remindDetailTime:noticeModel.remindDetailTime memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken] completion:^(NSArray<ZXTakeMedicineModel *> *list, NSInteger status) {
                        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:false];
                        if (list) {
                            HDrugNoticeViewController * drugNotice = [[HDrugNoticeViewController alloc] init];
//                            drugNotice.remindIds  = noticeModel.pushId;
                            drugNotice.remindTime = noticeModel.remindTime;
                            drugNotice.list = list;
                            [[ZXAlertUtils keyController] presentViewController:drugNotice animated:true completion:nil];
                        }
                    }];
                }else{//push
                    [ZXNotificationCenter postNotificationName:ZXNOTICE_RECEIVE_REMOTE_NOTICE object:nil];
                    [ZXAudioUtils vibrate];
                    [ZXAlertUtils showAAlertMessage:noticeModel.aps.alert title:@"新消息" buttonTexts:@[@"忽略",@"去看看"] buttonAction:^(int buttonIndex) {
                        if (buttonIndex == 1) {
                            switch (noticeModel.type) {
                                case ZXRemoteNoticeTypeCouponUpdate:
                                {
                                    //现金券无详情 跳转到现金券列表界面
                                    HCashCouponViewController * cashCoupon = [[HCashCouponViewController alloc] init];
                                    cashCoupon.isValid = true;
                                    [nav pushViewController:cashCoupon animated:true];
                                }
                                    break;
                                case ZXRemoteNoticeTypePromotionUpdate:
                                {
                                    HMessageDetailViewController * msgDetail = [[HMessageDetailViewController alloc] init];
                                    msgDetail.messageId = noticeModel.pushId;
                                    msgDetail.type = ZXMessageTypePromotion;

                                    [nav pushViewController:msgDetail animated:true];
                                }
                                    break;
                                case ZXRemoteNoticeTypeOrderUpdate:
                                {
                                    HOrderDetailViewController * orderDetailVC = [[HOrderDetailViewController alloc] init];
                                    orderDetailVC.orderId = noticeModel.pushId;
                                    [nav pushViewController:orderDetailVC animated:true];
                                }
                                    break;
                                default:
                                    break;
                            }
                        }
                    }];
                }
            }
        }else{//不在主界面 不跳转
            lastNoticeInfo = userInfo;
        }
    }else{
        lastNoticeInfo = nil;
    }
}

+ (void)checkNoticeCache{
    [self showNoticeDetail:lastNoticeInfo];
}

@end
