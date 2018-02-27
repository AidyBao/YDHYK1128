//
//  ZXReportAnalyseViewModel.m
//  YDHYK
//
//  Created by screson on 2016/12/17.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXReportAnalyseViewModel.h"

static NSArray <ZXCheckItemListModel *> * itemList = nil;

@implementation ZXReportAnalyseViewModel

+ (void)getLabReportListWithMemberId:(NSString *)memberId pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize token:(NSString *)token completion:(void (^)(NSArray<ZXReportListModel *> *, NSInteger, NSInteger, BOOL, NSString *))completion{
    
    NSMutableDictionary * dicp = [NSMutableDictionary dictionary];
    if (memberId) {
        [dicp setObject:memberId forKey:@"memberId"];
    }
    pageNum  = pageNum  <= 0 ? 1 : pageNum;
    pageSize = pageSize <= 0 ? 1 : pageSize;
    [dicp setObject:@(pageNum) forKey:@"pageNum"];
    [dicp setObject:@(pageSize) forKey:@"pageSize"];
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_REPORT_LIST) params:dicp token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            NSInteger totalPage = [content[@"data"][@"pageTotal"]  integerValue];
            id list = content[@"data"][@"listData"];
            NSMutableArray<ZXReportListModel *> * arrList = [NSMutableArray array];
            if ([list isKindOfClass:[NSArray class]] && [list count]) {
                for (NSDictionary * dic in list) {
                    ZXReportListModel * model = [ZXReportListModel mj_objectWithKeyValues:dic];
                    [arrList addObject:model];
                }
            }
            if (completion) {
                completion(arrList,totalPage,status,success,errorMsg);
            }
        }else{
            if (completion) {
                completion(nil,0,status,success,errorMsg);
            }
        }
    }];
}

+ (void)getLabReportDetailByReportId:(NSString *)reportId memberId:(NSString *)memberId token:(NSString *)token completion:(void (^)(NSArray<ZXItemShortModel *> *, ZXPatientInfo *, NSInteger, BOOL, NSString *))completion{
    NSMutableDictionary * dicp = [NSMutableDictionary dictionary];
    if (memberId) {
        [dicp setObject:memberId forKey:@"memberId"];
    }
    if (reportId) {
        [dicp setObject:reportId forKey:@"id"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_REPORT_VIEW) params:dicp token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            id list = content[@"data"][@"laboratorySheetDetailList"];
            NSMutableArray<ZXItemShortModel *> * arrList = [NSMutableArray array];
            if ([list isKindOfClass:[NSArray class]] && [list count]) {
                for (NSDictionary * dic in list) {
                    ZXItemShortModel * model = [ZXItemShortModel mj_objectWithKeyValues:dic];
                    [arrList addObject:model];
                }
            }
            if (completion) {
                completion(arrList,[ZXPatientInfo mj_objectWithKeyValues:content[@"data"]],status,success,errorMsg);
            }
        }else{
            if (completion) {
                completion(nil,nil,status,success,errorMsg);
            }
        }
    }];
}

+ (void)getAnalyseResultByReportId:(NSString *)reportId memberId:(NSString *)memberId token:(NSString *)token completion:(void (^)(NSArray<ZXAnalyseResutItemModel *> *, NSInteger, BOOL, NSString *))completion{
    NSMutableDictionary * dicp = [NSMutableDictionary dictionary];
    if (memberId) {
        [dicp setObject:memberId forKey:@"memberId"];
    }
    if (reportId) {
        [dicp setObject:reportId forKey:@"id"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_ANALYSERESUT_VIEW) params:dicp token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            id list = content[@"data"][@"laboratoryItems"];
            NSMutableArray<ZXAnalyseResutItemModel *> * arrList = [NSMutableArray array];
            if ([list isKindOfClass:[NSArray class]] && [list count]) {
                for (NSDictionary * dic in list) {
                    ZXAnalyseResutItemModel * model = [ZXAnalyseResutItemModel mj_objectWithKeyValues:dic];
                    [arrList addObject:model];
                }
            }
            if (completion) {
                completion(arrList,status,success,errorMsg);
            }
        }else{
            if (completion) {
                completion(nil,status,success,errorMsg);
            }
        }
    }];
}

+ (void)getCheckItemListByTemplateKey:(NSString *)key memberId:(NSString *)memberId token:(NSString *)token completion:(void (^)(NSArray<ZXCheckItemListModel *> *, NSInteger, BOOL, NSString *))completion{
    NSMutableDictionary * dicp = [NSMutableDictionary dictionary];
    if (memberId) {
        [dicp setObject:memberId forKey:@"memberId"];
    }
    if (key) {
        [dicp setObject:key forKey:@"key"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_CHECKITEM_LIST) params:dicp token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            id list = content[@"data"];
            NSMutableArray<ZXCheckItemListModel *> * arrList = [NSMutableArray array];
            if ([list isKindOfClass:[NSArray class]] && [list count]) {
                for (NSDictionary * dic in list) {
                    ZXCheckItemListModel * model = [ZXCheckItemListModel mj_objectWithKeyValues:dic];
                    [arrList addObject:model];
                }
                [arrList sortUsingComparator:^NSComparisonResult(ZXCheckItemListModel *  _Nonnull obj1, ZXCheckItemListModel *  _Nonnull obj2) {
                    NSString * p1 = obj1.pinyin;
                    NSString * p2 = obj2.pinyin;
                    return [p1 compare:p2 options:NSLiteralSearch];
                }];
            }
            if (completion) {
                completion(arrList,status,success,errorMsg);
            }
        }else{
            if (completion) {
                completion(nil,status,success,errorMsg);
            }
        }
    }];
}

+ (void)getAllCheckItemListWithMemberId:(NSString *)memberId token:(NSString *)token completion:(void (^)(NSArray<ZXCheckItemListModel *> *, NSInteger, BOOL, NSString *))completion{
    NSMutableDictionary * dicp = [NSMutableDictionary dictionary];
    if (memberId) {
        [dicp setObject:memberId forKey:@"memberId"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_CHECKITEM_LIST) params:dicp token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            id list = content[@"data"];
            NSMutableArray<ZXCheckItemListModel *> * arrList = [NSMutableArray array];
            if ([list isKindOfClass:[NSArray class]] && [list count]) {
                for (NSDictionary * dic in list) {
                    ZXCheckItemListModel * model = [ZXCheckItemListModel mj_objectWithKeyValues:dic];
                    [arrList addObject:model];
                }
                itemList = nil;
                [arrList sortUsingComparator:^NSComparisonResult(ZXCheckItemListModel *  _Nonnull obj1, ZXCheckItemListModel *  _Nonnull obj2) {
                    NSString * p1 = obj1.pinyin;
                    NSString * p2 = obj2.pinyin;
                    return [p1 compare:p2 options:NSLiteralSearch];
                }];
                itemList = arrList;
            }
            if (completion) {
                completion(arrList,status,success,errorMsg);
            }
        }else{
            if (completion) {
                completion(nil,status,success,errorMsg);
            }
        }
    }];
}



+ (NSArray<ZXCheckItemListModel *> *)checkItemList{
    return itemList;
}

+ (void)addAnalyseReportWithMemberId:(NSString *)memberId age:(NSString *)age sex:(NSString *)sex itemList:(NSArray<HItemModel *> *)itemList imgUrl:(NSString *)imgUrl token:(NSString *)token completion:(void (^)(NSString *, BOOL, NSInteger, BOOL, NSString *))completion{
    
    NSMutableDictionary * dicp = [NSMutableDictionary dictionary];
    if (memberId) {
        [dicp setObject:memberId forKey:@"memberId"];
    }
    if (age) {
        [dicp setObject:age forKey:@"age"];
    }
    if (sex) {
        [dicp setObject:sex forKey:@"sex"];
    }
    if (imgUrl) {
        [dicp setObject:imgUrl forKey:@"img"];
    }
    if (itemList) {
        NSMutableArray * arrList = [NSMutableArray array];
        [itemList enumerateObjectsUsingBlock:^(HItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary * dicTT = [obj mj_keyValues];
            [dicTT setObject:obj.itemId forKey:@"itemId"];
            [arrList addObject:dicTT];
        }];
        [dicp setObject:[arrList mj_JSONString] forKey:@"itemList"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_ADD_ANALYSE_REPORT) params:dicp token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            id rId = [NSString stringWithFormat:@"%@",content[@"data"][@"id"]];
            if ([rId isKindOfClass:[NSString class]] && [rId length]) {
                if (completion) {
                    completion(rId,[content[@"data"][@"isAbnormal"] boolValue],status,success,errorMsg);
                }
            }else{
                if (completion) {
                    completion(nil,false,status,success,errorMsg);
                }
            }
        }else{
            if (completion) {
                completion(nil,false,status,success,errorMsg);
            }
        }
    }];
}

+ (void)deleteAnalyseReportWithId:(NSString *)sheetId memberId:(NSString *)memberId token:(NSString *)token completion:(void (^)(BOOL, NSInteger, BOOL, NSString *))completion{
    NSMutableDictionary * dicp = [NSMutableDictionary dictionary];
    if (sheetId) {
        [dicp setObject:sheetId forKey:@"sheetId"];
    }
    if (memberId) {
        [dicp setObject:memberId forKey:@"memberId"];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_DELETE_ANALYSE) params:dicp token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            if (completion) {
                completion(true,status,success,nil);
            }
        }else{
            if (completion) {
                completion(false,status,success,errorMsg);
            }
        }
    }];

}

@end
