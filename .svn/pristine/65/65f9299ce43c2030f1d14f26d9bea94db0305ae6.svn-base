//
//  ZXPrescriptionModel.m
//  YDHYK
//
//  Created by screson on 2016/12/15.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXPrescriptionModel.h"

@implementation ZXPrescriptionModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"pId":@"id"};
}

- (NSString *)imageURL{
    if (self.arrImages) {
        return [self.arrImages firstObject];
    }
    return @"";
}

- (NSArray *)arrImages{
    if ([_attachFilesStr isKindOfClass:[NSString class]]) {
        NSArray * arrImgs = [_attachFilesStr componentsSeparatedByString:@","];
        return arrImgs;
    }
    return nil;
}

@end
