//
//  ZXReportAnalyseViewModel.h
//  YDHYK
//
//  Created by screson on 2016/12/17.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXReportListModel.h"
#import "ZXItemShortModel.h"
#import "ZXAnalyseResutItemModel.h"
#import "ZXConstDicModel.h"
#import "ZXCheckItemListModel.h"



@interface ZXReportAnalyseViewModel : NSObject

/**获取化验单列表*/
+ (void)getLabReportListWithMemberId:(NSString *)memberId
                             pageNum:(NSInteger)pageNum
                            pageSize:(NSInteger)pageSize
                               token:(NSString *)token
                          completion:(void(^)(NSArray <ZXReportListModel *> * list,NSInteger totalPage,NSInteger status,BOOL success,NSString * errorMsg))completion;
/**查看化验单*/
+ (void)getLabReportDetailByReportId:(NSString *)reportId
                            memberId:(NSString *)memberId
                               token:(NSString *)token
                          completion:(void(^)(NSArray<ZXItemShortModel *> * list,ZXPatientInfo * patient,NSInteger status,BOOL success,NSString * errorMsg))completion;

/**查看分析结果*/
+ (void)getAnalyseResultByReportId:(NSString *)reportId
                          memberId:(NSString *)memberId
                             token:(NSString *)token
                        completion:(void(^)(NSArray<ZXAnalyseResutItemModel *> * list,NSInteger status,BOOL success,NSString * errorMsg))completion;


/**获取模板下的检查项列表
 * key-模板key  为空检索所有检查项列表
 * key-模板key  不为空 检索对于模板下的检查项
 */
+ (void)getCheckItemListByTemplateKey:(NSString *)key
                             memberId:(NSString *)memberId
                                token:(NSString *)token
                           completion:(void(^)(NSArray<ZXCheckItemListModel *>* list,NSInteger status,BOOL success,NSString * errorMsg))completion;
/**获取所有检查项列表*/
+ (void)getAllCheckItemListWithMemberId:(NSString *)memberId
                                token:(NSString *)token
                           completion:(void(^)(NSArray<ZXCheckItemListModel *>* list,NSInteger status,BOOL success,NSString * errorMsg))completion;

+ (NSArray <ZXCheckItemListModel *> * )checkItemList;

/**新增化验单*/
+ (void)addAnalyseReportWithMemberId:(NSString *)memberId
                                 age:(NSString *)age
                                 sex:(NSString *)sex
                            itemList:(NSArray <HItemModel *> *)itemList
                              imgUrl:(NSString *)imgUrl
                               token:(NSString *)token
                          completion:(void(^)(NSString * reportId,BOOL isAbnormal,NSInteger status,BOOL success,NSString * errorMsg))completion;

/**删除化验单*/
+ (void)deleteAnalyseReportWithId:(NSString *)sheetId
                         memberId:(NSString *)memberId
                            token:(NSString *)token
                       completion:(void(^)(BOOL success,NSInteger status,BOOL reqSuccess,NSString * errorMsg))completion;


@end
