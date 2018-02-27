//
//  ZXDiscoverModel.m
//  YDHYK
//
//  Created by JuanFelix on 01/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "ZXDiscoverModel.h"

@implementation ZXDiscoverModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"promotionId":@"id"};
}

//- (NSString *)promotionTypeName{
//    switch ([_promotionType integerValue]) {
//        case 1:
//            return @"促销";
//        case 2:
//            return @"资讯";
//        case 3:
//            return @"广告";
//    }
//    return @"药直达";
//}

- (NSString *)publishDate{
    if ([_sendDateStr isKindOfClass:[NSString class]]) {
        return [[_sendDateStr componentsSeparatedByString:@" "] firstObject];
    }
    return @"";
}

@end
