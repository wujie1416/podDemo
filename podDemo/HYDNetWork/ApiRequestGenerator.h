//
//  ApiRequestGenerator.h
//  podDemo
//
//  Created by wujie on 2017/12/13.
//  Copyright © 2017年 wujie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYDRequestEnums.h"
@interface ApiRequestGenerator : NSObject
@property (nonatomic, strong) NSDictionary *commonParams;
+ (instancetype)shareInstance;


/**
 生成GET请求

 @param requestParams 请求输入参数
 @param methodName 请求路径不包含服务器地址的部分
 @param serviceType 指定请求地址类型
 @return NSURLRequest
 */
- (NSURLRequest *)generateGETRequestWithParams:(NSDictionary *)requestParams
                                    methodName:(NSString *)methodName
                                   serviceType:(HYDServiceType)serviceType;


/**
 生成POST请求

 @param requestParams 请求输入参数
 @param methodName 请求路径不包含服务器地址的部分
 @param serviceType 指定请求地址类型
 @return NSURLRequest
 */
- (NSURLRequest *)generatePOSTRequestWithParams:(NSDictionary *)requestParams
                                     methodName:(NSString *)methodName
                                    serviceType:(HYDServiceType)serviceType;


/**
 生成Post请求

 @param wholeUrl 完整的请求Url
 @param requestParams 请求输入参数
 @param extraParams 额外的请求参数 此参数是和jsonParams并集的参数字典
 @return NSURLRequest
 */
- (NSMutableURLRequest *)generatePOSTRequestWithWholeUrl:(NSString *)wholeUrl
                                                  Params:(NSDictionary *)requestParams
                                             extreParams:(NSDictionary *)extraParams;


/**
 生成UpLoad请求

 @param url 上传图片的地址
 @param block 生成上传图片数据的block
 @return NSURLRequest
 */
- (NSURLRequest *)generateUpLoadRequestWithUrl:(NSString *)url
                     constructingBodyWithBlock:block;



















@end
