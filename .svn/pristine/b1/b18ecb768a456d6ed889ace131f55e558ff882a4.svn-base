//
//  ZXOrderDictionary.h
//  YDHYK
//
//  Created by 120v on 2017/3/3.
//  Copyright © 2017年 screson. All rights reserved.
//

#import <OrderedDictionary/OrderedDictionary.h>

@interface ZXOrderDictionary : OrderedDictionary

/**
 @pragram 有序字典
 @dictionary 需要排序的字典
**/
+ (MutableOrderedDictionary *)orderedWithDictionary:(NSDictionary *)dictionary;

/**
 @pragram 筛选与当前时间最近的Item
 @array 需要筛选的数据
 @completion 回调
 **/
+ (void)sortedWithArray:(NSMutableArray *)array completion:(void(^)(NSInteger index))completion;

@end
