//
//  ApiHttpRequestUtil.h
//  podDemo
//
//  Created by wujie on 2017/12/12.
//  Copyright © 2017年 wujie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "HYDRequestEnums.h"
#import "ApiRequestGenerator.h"

typedef void(^ApiHttpRequestCallBack) (id response, NSURLRequest *request);

typedef void(^ApiHttpRequestUploadCallback) (NSProgress *uploadProgress);

@class ApiHttpRequestUtil;

/**
 网络请求回掉代理
 */
@protocol ApiHttpRequestUtilDelegate <NSObject>

/**
 网络请求成功回掉
 */
- (void)requestUtil:(ApiHttpRequestUtil *)util didGetSuccessResponse:(id)response andRequest:(NSURLRequest *)request;

/**
 网络请求失败回掉
 */
- (void)requestUtil:(ApiHttpRequestUtil *)util didGetFailedResponse:(id)response andRequest:(NSURLRequest *)request;
@end

@interface ApiHttpRequestUtil : NSObject
@property (nonatomic, assign) LEHttpRequestMethod requestMethod; //默认为使用AF发送网络请求
@property (nonatomic, weak) id <ApiHttpRequestUtilDelegate> requestDelegate; // 只有在非单例情况下才可以使用，否则会造成混乱

+ (instancetype)shareInstance;

- (instancetype)initWithTimeoutInterval:(NSTimeInterval)time;

/**
 发送GET请求

 @param params 请求输入参数
 @param methodName 请求路径不包含服务器地址的部分
 @param serviceType 指定请求地址类型
 @param success 请求成功回调
 @param fail 请求失败回调
 @return 请求任务的taskIdentifier
 */
- (NSURLSessionDataTask *)callGetWithParams:(NSDictionary *)params
                                 methodName:(NSString *)methodName
                                serviceType:(HYDServiceType)serviceType
                                    success:(ApiHttpRequestCallBack)success
                                       fail:(ApiHttpRequestCallBack)fail;

/**
 发送Post请求

 @param params 请求输入参数
 @param methodName 请求路径不包含服务器地址的部分
 @param serviceType 指定请求地址的类型
 @param success 请求成功的回调
 @param fail 请求失败的回调
 @return 请求任务的taskIdentifier
 */
- (NSURLSessionDataTask *)callPostWithParams:(NSDictionary *)params
                                  methodName:(NSString *)methodName
                                 serviceType:(HYDServiceType)serviceType
                                     success:(ApiHttpRequestCallBack)success
                                        fail:(ApiHttpRequestCallBack)fail;

/**
 发送Post请求

 @param wholeUrl 完整的请求Url
 @param params 请求参数
 @param extraParams 额外的请求参数，此参数是和jsonParams并集的参数字典
 @param success 请求成功的回调
 @param fail 请求失败的回调
 @return 请求任务的taskIdentifier
    {
        age = 27;
        jsonParams = "6OpVk3LxHtiTVRi6uTWZgi/kg3B3lSJt11RxxbRGcFibTgauBp+oHsOAThuKE2ISTdGyDrz9zzXlONacBb88AV/CJTKzb372MnRNwLOr3h6RtnUAh3lJ0sJ8iKgNvd8TraySNxpJdQAbUcxatkAOBOW5ws3qDt5IdTk7J1gqFqgExwnEk2mIYDQRX7C1dPRuY7rqBGDPxNJy3wBZi4OaqmcD7O5c+iMyAIHSzSFqXTpLtHU+BlaaNUBB9br9KGk2";
    }
 */
- (NSURLSessionDataTask *)callPostWithUrl:(NSString *)wholeUrl
                                   params:(NSDictionary *)params
                              extraParams:(NSDictionary *)extraParams
                                  success:(ApiHttpRequestCallBack)success
                                     fail:(ApiHttpRequestCallBack)fail;


/**
 上传图片文件

 @param url 服务地址
 @param fileData 上传的文件
 @param name 文件的后缀名
 @param success 成功的回调
 @param fail 失败的回调
 @param fileUploadProgress 上传文件进度的回调
 @return 请求任务的taskIdentifier
 */
- (NSURLSessionDataTask *)uploadImageWithAFNRequesturl:(NSString *)url
                                              fileData:(NSData *)fileData
                                                  name:(NSData *)name
                                               success:(ApiHttpRequestCallBack)success
                                                  fail:(ApiHttpRequestCallBack)fail
                                              progress:(ApiHttpRequestUploadCallback)fileUploadProgress;


/**
 上传文件

 @param url 服务地址
 @param fileData 上传的文件
 @param name 文件的后缀名
 @param mimeType http://www.iana.org/assignments/media-types/.
 @param success 成功的回调
 @param fail 失败的回调
 @param fileUploadProgress 上传文件的进度回调
 @return 请求任务的taskIdentifier
 */
- (NSURLSessionDataTask *)uploadApiWithAFNRequestUrl:(NSString *)url
                                            fileData:(NSData *)fileData
                                                name:(NSString *)name
                                            mimeType:(NSString *)mimeType
                                             success:(ApiHttpRequestCallBack)success
                                                fail:(ApiHttpRequestCallBack)fail
                                            progress:(ApiHttpRequestUploadCallback)fileUploadProgress;



































@end
