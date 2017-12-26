//
//  ApiHttpRequestUtil.m
//  podDemo
//
//  Created by wujie on 2017/12/12.
//  Copyright © 2017年 wujie. All rights reserved.
//

#import "ApiHttpRequestUtil.h"

@interface ApiHttpRequestUtil ()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation ApiHttpRequestUtil
{
    NSURLSessionDataTask *_currentDataTask;
    NSTimeInterval _timeoutSeconds;
}

+ (instancetype)shareInstance
{
    static ApiHttpRequestUtil *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[ApiHttpRequestUtil alloc] init];
    });
    return shareInstance;
}

- (instancetype)init
{
//    if (self = [super init]) {
//        _requestMethod = 0;
//        _timeoutSeconds = kNetworkingTimeoutSeconds;
//    }
//    return self;
    return [self initWithTimeoutInterval:kNetworkingTimeoutSeconds];
}

- (instancetype)initWithTimeoutInterval:(NSTimeInterval)time
{
    if (self = [super init]) {
        _timeoutSeconds = time;
    }
    return self;
}

- (void)dealloc
{
    [self.sessionManager.session invalidateAndCancel];
}

#pragma mark - public methods

//- (NSURLSessionDataTask *)callGetWithParams:(NSDictionary *)params
//                                 methodName:(NSString *)methodName
//                                serviceType:(HYDServiceType)serviceType
//                                    success:(ApiHttpRequestCallBack)success
//                                       fail:(ApiHttpRequestCallBack)fail
//{
//    NSURLRequest *request = [[ApiRequestGenerator shareInstance] generateGETRequestWithParams:params methodName:methodName serviceType:serviceType];
//    NSURLSessionDataTask *dataTask =
//}


/** 这个函数存在的意义在于，如果将来要把AFNetworking换掉，只要修改这个函数的实现即可。 */
- (NSURLSessionDataTask *)callApiWithRequest:(NSURLRequest *)request
                                     success:(ApiHttpRequestCallBack)success
                                        fail:(ApiHttpRequestCallBack)fail
{
    NSURLSessionDataTask *dataTask = nil;
    switch (self.requestMethod) {
        case LEHttpRequestMethodAFN:
        {
            dataTask = [self callApiWithAFNRequest:request success:success fail:fail];
        }
            break;
            
        default:
            break;
    }
    _currentDataTask = dataTask;
    return dataTask;
}

- (NSURLSessionDataTask *)callApiWithAFNRequest:(NSURLRequest *)request
                                        success:(ApiHttpRequestCallBack)success
                                           fail:(ApiHttpRequestCallBack)fail
{
    NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSNumber *requestID = @([dataTask taskIdentifier]);
        NSHTTPURLResponse *httpURLResponse = (NSHTTPURLResponse *)response;
        if (error) {
            if (httpURLResponse.statusCode == 304) {//缓存中读取数据 没有进行网络请求
                success ? success(nil,request) : nil;
                if ([_requestDelegate respondsToSelector:@selector(requestUtil:didGetSuccessResponse:andRequest:)]) {
                    [_requestDelegate requestUtil:self didGetSuccessResponse:nil andRequest:request];
                }
            } else {
                
            }
        } else {
            
        }
    }];
    return dataTask;
}

- (AFHTTPSessionManager *)sessionManager
{
    if (!_sessionManager) {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfig.timeoutIntervalForRequest = _timeoutSeconds;
        sessionConfig.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:sessionConfig];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/html", nil];
    }
    return _sessionManager;
}





















@end
