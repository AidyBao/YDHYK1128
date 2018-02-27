//
//  ZXDrugCollectModel.h
//  YDHYK
//
//  Created by screson on 2016/12/27.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ZXDrugTypeRX    = 0, //处方药
    ZXDrugTypeOTC   = 1  //非处方药
} ZXDrugType;

/**药品收藏 - 药品*/
@interface ZXDrugCollectModel : NSObject
/**收藏记录id*/
@property (nonatomic,strong) NSString * collectId;
/**店铺信息*/
@property (nonatomic,strong) NSString * drugstoreId;
@property (nonatomic,strong) NSString * drugstoreName;
/**药品id*/
@property (nonatomic,strong) NSString * drugId;
@property (nonatomic,strong) NSString * drugName;
@property (nonatomic,strong) NSNumber * price;
@property (nonatomic,strong) NSString * attachFiles;   //相对地址
@property (nonatomic,strong) NSString * attachFilesStr;//绝对地址
/**规格*/
@property (nonatomic,strong) NSString * packingSpec;
/**生成厂商*/
@property (nonatomic,strong) NSString * manufacturer;
/**药品类型 - OTC/RX*/
@property (nonatomic,assign) ZXDrugType drugType;

@end
