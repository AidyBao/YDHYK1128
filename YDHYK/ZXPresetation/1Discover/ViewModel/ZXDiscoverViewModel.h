//
//  ZXDiscoverViewModel.h
//  YDHYK
//
//  Created by JuanFelix on 01/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZXDiscoverModel;

typedef void(^ZXDiscoverCompletion)(NSMutableArray<ZXDiscoverModel *> * lists,NSInteger totalPage,NSInteger status, BOOL success, NSString *errorMsg);

@interface ZXDiscoverViewModel : NSObject

//#warning --- 测试接口
//+ (void)testLogin:(ZXRequestCompletion)completion;

/**获取发现列表*/
+ (void)loadDiscoverListByMemberId:(NSString *)memberId
                           pageNum:(NSInteger)pageNum
                          pageSize:(NSInteger)pageSize
                             token:(NSString *)token
                      zxCompletion:(ZXDiscoverCompletion)zxCompletion;

/**资讯详细内容*/
+ (void)loadDiscoverDetailByPromotionId:(NSString *)pID
                               memberId:(NSString *)memberId
                                  token:(NSString *)token
                           zxCompletion:(void(^)(ZXDiscoverModel * model,NSInteger status, BOOL success, NSString *errorMsg))zxCompletion;
@end
