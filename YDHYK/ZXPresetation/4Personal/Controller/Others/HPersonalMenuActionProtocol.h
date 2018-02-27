//
//  HPersonalMenuActionProtocol.h
//  YDHYK
//
//  Created by screson on 2016/12/5.
//  Copyright © 2016年 screson. All rights reserved.
//

#ifndef HPersonalMenuActionProtocol_h
#define HPersonalMenuActionProtocol_h

typedef enum : NSUInteger {
    HPMessageActionType,
    HPSettingActionType,
    HPEditInfoActionType,
    HPNoneActionType
} HPMenuActionType;

#import <UIKit/UIKit.h>

@protocol HPersonalMenuActionProtocol <NSObject>

@optional
/**消息、设置、编辑资料事件*/
- (void)headerMenuActionsWithType:(HPMenuActionType)type;
/**不同类型订单事件 0 全部订单 1待付款*/
- (void)orderMenuActionsWithIndex:(NSInteger)index;
/**我的工具按钮事件*/
- (void)toolsMenuActionsWithIndex:(NSInteger)index;

@end

#endif /* HPersonalMenuActionProtocol_h */
