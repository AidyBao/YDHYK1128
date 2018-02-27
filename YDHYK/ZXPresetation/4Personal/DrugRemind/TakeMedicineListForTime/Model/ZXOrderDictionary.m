//
//  ZXOrderDictionary.m
//  YDHYK
//
//  Created by 120v on 2017/3/3.
//  Copyright © 2017年 screson. All rights reserved.
//

#import "ZXOrderDictionary.h"

@implementation ZXOrderDictionary


#pragma mark - 字典排序
+ (MutableOrderedDictionary *)orderedWithDictionary:(NSDictionary *)dictionary{
    MutableOrderedDictionary *orderedDict = [MutableOrderedDictionary dictionary];
    NSMutableDictionary *originalDict = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    if ([originalDict isKindOfClass:[NSDictionary class]] && [originalDict count]) {
        NSArray *keyArray = [originalDict allKeys];
        NSArray *orderedArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        
        for (int i =0; i<orderedArray.count; i++) {
            NSString *dictkey = orderedArray[i];
            [orderedDict insertObject:[originalDict objectForKey:dictkey] forKey:dictkey atIndex:i];
        }
    }
    return orderedDict;
}

#pragma mark - 筛选距当前时间最近的item
+ (void)sortedWithArray:(NSArray *)array completion:(void (^)(NSInteger))completion{
    NSString *cuttentDateStr = [ZXDateUtils getCurrentTimeNeedSecond:FALSE];
    
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"HH:mm";
    
    __block NSDictionary *dict = nil;
    __block NSMutableDictionary *dateDict = [[NSMutableDictionary alloc]initWithCapacity:10];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dict = obj;
        
        // 推送时间
        NSString *pushDateStr =[NSString stringWithFormat:@"%@",[obj allKeys].firstObject] ;
        NSDate *pushDate = [dateFomatter dateFromString:pushDateStr];
        
        // 当前时间data格式
        NSDate *nowDate = [dateFomatter dateFromString:cuttentDateStr];
        
        //取与当前时间比较后的绝对值
        NSTimeInterval pushTimeIn = [pushDate timeIntervalSinceReferenceDate];
        NSTimeInterval nowTimeIn = [nowDate timeIntervalSinceReferenceDate];
        long interval = fabs(pushTimeIn - nowTimeIn);
        [dateDict setValue:[NSNumber numberWithLong:interval] forKey:[NSString stringWithFormat:@"%lu",(unsigned long)idx]];
    }];
    
    //排序
    NSArray *keys = [dateDict allValues];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[NSString stringWithFormat:@"%@",obj1] compare:[NSString stringWithFormat:@"%@",obj2] options:NSNumericSearch];
    }];
    
    //滚动到指定距当前时间最近item
    __block NSNumber *tempStr = nil;
    [dateDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            tempStr =(NSNumber *)obj;
            NSString *keyStr = key;
            
            if (tempStr == sortedArray.firstObject) {
                *stop = TRUE;
                
                if (completion) {
                    completion(keyStr.integerValue);
                }
                
//                NSIndexPath *index = [NSIndexPath indexPathForItem:keyStr.integerValue inSection:0];
//                [self.collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            }
        }
    }];

}

@end
