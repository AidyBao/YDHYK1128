//
//  YDReceiverAddressModel.h
//  YDHYK
//
//  Created by 120v on 2016/12/9.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDReceiverAddressModel : NSObject

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *memberId;
@property (nonatomic, copy) NSString *consignee;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *isDefault;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *isDefaultStr;
@property (nonatomic, copy) NSString *cityAddress;
@property (nonatomic, copy) NSString *detailAddress;
@property (nonatomic, copy) NSString *code;

@end
