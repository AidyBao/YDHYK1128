//
//  ZXPrescriptionModel.h
//  YDHYK
//
//  Created by screson on 2016/12/15.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

/*处方Model*/
@interface ZXPrescriptionModel : NSObject

@property (nonatomic,copy) NSString * pId;
@property (nonatomic,copy) NSString * title;
//@property (nonatomic,copy) NSString * attachFiles; //多张图片 逗号分割 现在只返回一张
@property (nonatomic,copy) NSString * attachFilesStr;
@property (nonatomic,copy) NSString * uploadDateStr;

////调整
@property (nonatomic,strong) NSArray * arrImages;
@property (nonatomic,copy)   NSString * imageURL;//第一张图片

@end
