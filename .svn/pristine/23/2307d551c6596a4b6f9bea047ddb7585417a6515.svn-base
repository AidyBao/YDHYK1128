//
//  ZXNetworkEngine.h
//  ZXStructure
//
//  Created by JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXAPISign.h"

/**构造完整接口地址*/
extern NSString * ZXAPI_Address(NSString * module);
/**构造完整资源地址*/
extern NSString * ZXIMG_Address(NSString * imgPath);
/**构造完整WebStore地址*/
//extern NSString * ZXWebStore_Address(NSString * storeId,NSString * memberId,NSString * token);

NSString * ZXStore_Address(NSString * module);

typedef enum : NSUInteger {
    POST,
    GET,
    DELETE
} ZXRequestMethod;

typedef enum : NSUInteger {
    ZXPathThumb,  //头像
    ZXPathChuFang,//处方
    ZXPathHYD,    //化验单
    ZXPathCustom  //自定义
} ZXFilePath;

/**content：接口返回的原始数据
 * code:    从接口解析的状态码
 * success: true:接口访问成功（不代表code = 0） false 接口访问失败
 * errorMsg: 接口错误信息，取值于接口msg字段
 */
typedef void(^ZXRequestCompletion)(id content,NSInteger status,BOOL success,NSString * errorMsg);

@interface ZXNetworkEngine : NSObject

/**统一接口数据处理*/
+ (void)commonProcess:(id)content zxCompletion:(ZXRequestCompletion)zxCompletion;
/**HTTP 请求失败*/
+ (void)httpError:(NSError *)error zxCompletion:(ZXRequestCompletion)zxCompletion;


/**
 *  异步接口请求
 *
 *  @param url          接口地址
 *  @param params       接口参数
 *  @param token        有Token 才添加签名
 *  @param method       请求方式 GET POST DELETE
 *  @param zxCompletion 接口请求完成回调
 */

+ (NSURLSessionDataTask *)asycnRequestWithURL:(NSString *)url
                                       params:(NSDictionary *)params
                                        token:(NSString *)token
                                       method:(ZXRequestMethod)method
                                 zxCompletion:(ZXRequestCompletion)zxCompletion;


/**
 *  图片文件上传
 *
 *  @param resourceURL 资源接口地址
 *  @param images      图片数组
 *  @param token       签名用
 *  @param qulity      压缩图片质量 0~1 0 最大压缩 1 不压缩
 *  @param params      接口请求参数
 *  @param zxCompletion    请求完成回调
 */

+(NSURLSessionDataTask *)uploadImageToResourceURL:(NSString *)resourceURL
                                           images:(NSArray *)images
                                   compressQulity:(float)qulity
                                         filePath:(ZXFilePath)filePath
                                            token:(NSString *)token
                                           params:(NSDictionary *)params
                                     zxCompletion:(ZXRequestCompletion)zxCompletion;

@end
