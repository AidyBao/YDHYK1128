//
//  ZXCheckItemListModel.h
//  YDHYK
//
//  Created by screson on 2016/12/20.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HItemModel.h"

/**新增化验单-检查项 简单模型*/
@interface ZXCheckItemListModel : NSObject

@property (nonatomic,copy) NSString * itemId;
@property (nonatomic,copy) NSString * itemName;
@property (nonatomic,assign) HItemResultType referenceValueTypeKey;
@property (nonatomic,copy,readonly) NSString * pinyin;
@property (nonatomic,copy,readonly) NSString * firstLetters;

@end
