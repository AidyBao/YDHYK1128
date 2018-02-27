//
//  ZXNetworkEngine.m
//  ZXStructure
//
//  Created by JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "ZXNetworkEngine.h"
#import "ZXAPIURL.h"
#import "ZXNotificationCenter.h"
#import "ZXAPISign.h"
#import <AFNetworking/AFHTTPSessionManager.h>

#define ZX_SHOW_LOG 0

NSString * ZXAPI_Address(NSString * module){
    NSMutableString * strAPIURL = [NSMutableString stringWithFormat:@"%@:%@",ZXROOT_URL,ZXPORT];
    if (module && [module respondsToSelector:@selector(length)] && module.length) {
        if ([module hasPrefix:@"/"]) {
            [strAPIURL appendString:module];
        }else{
            [strAPIURL appendString:[NSString stringWithFormat:@"/%@",module]];
        }
    }
    return strAPIURL;
}

NSString * ZXIMG_Address(NSString * path){
    NSMutableString * strAPIURL = nil;
#if ZXTARGET == 1
    strAPIURL = [NSMutableString stringWithFormat:@"%@",ZXIMAGE_URL];
#else
    strAPIURL = [NSMutableString stringWithFormat:@"%@:%@",ZXIMAGE_URL,ZXIMAGE_PORT];
#endif
    if (path && [path respondsToSelector:@selector(length)] && path.length) {
        if ([path hasPrefix:@"/"]) {
            [strAPIURL appendString:path];
        }else{
            [strAPIURL appendString:[NSString stringWithFormat:@"/%@",path]];
        }
        
    }
    return strAPIURL;
}

NSString * ZXStore_Address(NSString * module) {
    NSMutableString * strAPIURL = [NSMutableString stringWithFormat:@"%@",ZXSTORE_URL];
    if (module && [module respondsToSelector:@selector(length)] && module.length) {
        if ([module hasPrefix:@"/"]) {
            [strAPIURL appendString:module];
        }else{
            [strAPIURL appendString:[NSString stringWithFormat:@"/%@",module]];
        }
    }
    return strAPIURL;
}

//NSString * ZXWebStore_Address(NSString * storeId,NSString * memberId,NSString * token){
//    NSMutableString * strWebStoreURL = [NSMutableString stringWithString:ZXWEBSTORE_URL];
//    NSMutableArray * arrParams = [NSMutableArray array];
//    if ([storeId isKindOfClass:[NSString class]] && [storeId length]) {
//        [arrParams addObject:[NSString stringWithFormat:@"&drugstoreId=%@",storeId]];
//    }
//    if ([memberId isKindOfClass:[NSString class]] && [memberId length]) {
//        [arrParams addObject:[NSString stringWithFormat:@"&memberId=%@",memberId]];
//    }
//    if ([token isKindOfClass:[NSString class]] && [token length]) {
//        [arrParams addObject:[NSString stringWithFormat:@"&token=%@",token]];
//    }
//    if (arrParams.count) {
//        [strWebStoreURL appendFormat:@"?%@",[arrParams componentsJoinedByString:@"&"]];
//        [strWebStoreURL appendFormat:@"&uTime=%@",[ZXStringUtils generateUUIDString]];
//    }else{
//        [strWebStoreURL appendFormat:@"?uTime=%@",[ZXStringUtils generateUUIDString]];
//    }
//    return strWebStoreURL;
//}

@implementation ZXNetworkEngine

+ (void)commonProcess:(id)content zxCompletion:(ZXRequestCompletion)zxCompletion{
    if (ZX_SHOW_LOG) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:content options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"接口返回数据:\n%@",str);
        NSLog(@"------------结束------------");
    }
    if ([content isKindOfClass:[NSDictionary class]]) {
        NSInteger status = [content[@"status"] integerValue];
        
        if (status == ZXAPI_LOGIN_INVALID) {
            if (zxCompletion) {
                zxCompletion(content,ZXAPI_LOGIN_INVALID,true,content[@"msg"]);
            }
            [ZXNotificationCenter postNotificationName:ZXNOTICE_LOGIN_OFFLINE object:nil];
        }else if (zxCompletion) {
            if (status == ZXAPI_SUCCESS) {
                zxCompletion(content,status,true,nil);
            }else{
                zxCompletion(content,status,true,content[@"msg"]);
            }
        }
    }else{
        if (zxCompletion) {
            zxCompletion(content,ZXAPI_FORMAT_ERROR,false,ZXFORMAT_ERROR_MSG);
        }
    }
}

+ (void)httpError:(NSError *)error zxCompletion:(ZXRequestCompletion)zxCompletion{
    if (ZX_SHOW_LOG) {
        NSLog(@"接口错误返回数据:\n%@",error);
        NSLog(@"------------结束------------");
    }
    if (zxCompletion) {
        if (error.code == ZXAPI_HTTP_TIME_OUT) {
            zxCompletion(error,ZXAPI_HTTP_TIME_OUT,false,ZXAPI_HTTP_TIMEOUT_MSG);
        }else{
            zxCompletion(error,ZXAPI_HTTP_ERROR,false,ZXAPI_HTTP_ERROR_MSG);
        }
    }
}

+ (NSURLSessionDataTask *)asycnRequestWithURL:(NSString *)url
                     params:(NSDictionary *)params
                      token:(NSString *)token
                     method:(ZXRequestMethod)method zxCompletion:(ZXRequestCompletion)zxCompletion{
    
    NSMutableDictionary * dicP = [NSMutableDictionary dictionaryWithDictionary:params];
    
    if ([token isKindOfClass:[NSString class]]) {
        [dicP setObject:[ZXAPISign signWithDictionary:dicP withToken:token] forKey:@"sign"];//添加签名
        [dicP setObject:token forKey:@"token"];
    }
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = ZXAPI_TIMEOUT_INTREVAL;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    NSURLSessionDataTask * task = nil;
    
    if (ZX_SHOW_LOG) {
        NSLog(@"------------开始------------");
        NSLog(@"请求地址:\n%@",url);
        NSLog(@"请求参数:\n%@",dicP);
    }
    
    switch (method) {
        case GET:
        {
            task = [manager GET:url parameters:dicP progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self commonProcess:responseObject zxCompletion:zxCompletion];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self httpError:error zxCompletion:zxCompletion];
            }];
        }
            break;
        case POST:
        {
            task = [manager POST:url parameters:dicP progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self commonProcess:responseObject zxCompletion:zxCompletion];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self httpError:error zxCompletion:zxCompletion];
            }];
        }
            break;
        case DELETE:
        {
            task = [manager DELETE:url parameters:dicP success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self commonProcess:responseObject zxCompletion:zxCompletion];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self httpError:error zxCompletion:zxCompletion];
            }];
        }
            break;
        default:
            break;
    }
    return task;
}

+ (NSURLSessionDataTask *)uploadImageToResourceURL:(NSString *)resourceURL
                          images:(NSArray *)images
                  compressQulity:(float)qulity
                        filePath:(ZXFilePath)filePath
                           token:(NSString *)token
                          params:(NSDictionary *)params
                    zxCompletion:(ZXRequestCompletion)zxCompletion{
    NSMutableDictionary * dicP = [NSMutableDictionary dictionaryWithDictionary:params];
    switch (filePath) {
        case ZXPathThumb:
        {
            [dicP setObject:ZXAPI_Thumb_Path   forKey:@"directory"];
        }
            break;
        case ZXPathChuFang:
        {
            [dicP setObject:ZXAPI_ChuFang_Path forKey:@"directory"];
        }
            break;
        case ZXPathHYD:
        {
            [dicP setObject:ZXAPI_HYD_Path     forKey:@"directory"];
        }
            break;
        default:
            break;
    }
    
    if ([token isKindOfClass:[NSString class]]) {
        [dicP setObject:[ZXAPISign signWithDictionary:dicP withToken:token] forKey:@"sign"];//添加签名
        [dicP setObject:token forKey:@"token"];
    }
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];
//    NSData * certData =[NSData dataWithContentsOfFile:cerPath];
//    NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    // 是否允许,NO-- 不允许无效的证书
//    [securityPolicy setAllowInvalidCertificates:YES];
//    // 设置证书
//    [securityPolicy setPinnedCertificates:certSet];
//    manager.securityPolicy = securityPolicy;
    if (ZX_SHOW_LOG) {
        NSLog(@"------------开始------------");
        NSLog(@"请求地址:%@",resourceURL);
        NSLog(@"请求参数:\n%@",dicP);
    }
    NSURLSessionDataTask * task = [manager POST:resourceURL parameters:dicP constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        for (id img in images) {
    
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat =@"yyyyMMddHHmmss";
            NSString * str = [formatter stringFromDate:[NSDate date]];
            NSString * fileName = [NSString stringWithFormat:@"%@.jpg", str];
            
            //上传的参数(上传图片，以文件流的格式)
            [formData appendPartWithFileData:UIImageJPEGRepresentation(img, qulity)
                                    name:@"file"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        //上传成功
        [self commonProcess:responseObject zxCompletion:zxCompletion];
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        //上传失败
        [self httpError:error zxCompletion:zxCompletion];
    }];
    return task;
}


@end
