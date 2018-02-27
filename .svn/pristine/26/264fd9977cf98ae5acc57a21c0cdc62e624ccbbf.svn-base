//
//  ZXPrescriptionViewModel.h
//  YDHYK
//
//  Created by screson on 2016/12/15.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXPrescriptionModel.h"

@interface ZXPrescriptionViewModel : NSObject



/**获取处方列表*/
+ (void)getPrescriptionListWithMemberId:(NSString *)memberId
                                pageNum:(NSInteger)pageNum
                               pageSize:(NSInteger)pageSize
                                  token:(NSString *)token
                             completion:(void(^)(NSArray<ZXPrescriptionModel *> * list,NSInteger totalPage,NSInteger status,BOOL success,NSString * errorMsg))completion;
/**新增处方  
 *attachFiles:多张时逗号分割 【先通过文件上传接口上传获取地址】
 */
+ (void)addPrescriptionWithMemberId:(NSString *)memberId
                              title:(NSString *)title
                        attachFiles:(NSString *)filesPath
                              token:(NSString *)token
                         completion:(void(^)(BOOL addSuccess,NSInteger status,BOOL success,NSString * errorMsg))completion;
/**删除处方*/
+ (void)deletePrescriptionById:(NSString *)pId
                      memberId:(NSString *)memberId
                         token:(NSString *)token
                    completion:(void(^)(BOOL deleteSuccess,NSInteger status,BOOL success,NSString * errorMsg))completion;

@end
