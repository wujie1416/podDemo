//
//  ApiRequestGenerator.m
//  podDemo
//
//  Created by wujie on 2017/12/13.
//  Copyright © 2017年 wujie. All rights reserved.
//

#import "ApiRequestGenerator.h"
#import <AFNetworking.h>
#import "HYDDes.h"
#import "HYDNetWorkMacro.h"

@interface ApiRequestGenerator ()
@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;
@end

@implementation ApiRequestGenerator

+ (instancetype)shareInstance
{
    static ApiRequestGenerator *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ApiRequestGenerator alloc] init];
        sharedInstance.commonParams = @{@"sourceType":@"2",
                                        @"utmCode":@"201",
                                        @"osVersion":[NSString stringWithFormat:@"iOS_%@",[UIDevice currentDevice].systemVersion],
                                        @"version":[[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                                        @"deviceToken":@"",//待赋值
                                        @"deviceCode":@"",
                                        @"tokenId":@"",
                                        };
    });
    return sharedInstance;
}

- (void)setCommonParams:(NSDictionary *)commonParams
{
    NSMutableDictionary *totalParams = [[NSMutableDictionary alloc] initWithDictionary:_commonParams];
    [totalParams addEntriesFromDictionary:commonParams];
    _commonParams = [NSDictionary dictionaryWithDictionary:totalParams];
}

- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        /*如果用last-modified则需要把cachePolicy设置成NSURLRequestReloadIgnoringLocalCacheData
         _httpRequestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;*/
        _httpRequestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    }
    return _httpRequestSerializer;
}

- (NSURLRequest *)generateGETRequestWithParams:(NSDictionary *)requestParams
                                    methodName:(NSString *)methodName
                                   serviceType:(HYDServiceType)serviceType
{
    NSDictionary *finalParam = [self generateFinalParams:requestParams];
    NSString *urlString = [[self getServiceUrlWithServiceType:serviceType] stringByAppendingString:methodName];
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:finalParam error:nil];
    NSMutableDictionary *header = [NSMutableDictionary dictionaryWithDictionary:request.allHTTPHeaderFields];
    [header setObject:[self generateFinalHeader] forKey:@"common-params"];
    request.allHTTPHeaderFields = header;
    return request;
}

- (NSURLRequest *)generatePOSTRequestWithParams:(NSDictionary *)requestParams
                                     methodName:(NSString *)methodName
                                    serviceType:(HYDServiceType)serviceType
{
    NSDictionary *finalParam = [self generateFinalParams:requestParams];
    NSString *urlString = [[self getServiceUrlWithServiceType:serviceType] stringByAppendingString:methodName];
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:finalParam error:nil];
    NSMutableDictionary *header = [NSMutableDictionary dictionaryWithDictionary:request.allHTTPHeaderFields];
    [header setObject:[self generateFinalHeader] forKey:@"common-params"];
    request.allHTTPHeaderFields = header;
    return request;
}

- (NSMutableURLRequest *)generatePOSTRequestWithWholeUrl:(NSString *)wholeUrl
                                                  Params:(NSDictionary *)requestParams
                                             extreParams:(NSDictionary *)extraParams
{
    NSDictionary *finalParam = [self generateFinalParams:requestParams];
    if (extraParams && extraParams.count > 0) {
        NSMutableDictionary *newFinalParam = [NSMutableDictionary dictionaryWithDictionary:finalParam];
        [newFinalParam addEntriesFromDictionary:extraParams];
        [newFinalParam setObject:finalParam[@"jsonParams"] forKey:@"state"];
        finalParam = newFinalParam;
    }
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:wholeUrl parameters:finalParam error:nil];
    NSMutableDictionary *header = [NSMutableDictionary dictionaryWithDictionary:request.allHTTPHeaderFields];
    [header setObject:[self generateFinalHeader] forKey:@"common-params"];
    request.allHTTPHeaderFields = header;
    return request;
}

- (NSURLRequest *)generateUpLoadRequestWithUrl:(NSString *)url constructingBodyWithBlock:(id)block
{
    NSMutableURLRequest *request = [self.httpRequestSerializer multipartFormRequestWithMethod:@"POST" URLString:url parameters:[self generateFinalParams:nil] constructingBodyWithBlock:block error:nil];
    NSMutableDictionary *header = [NSMutableDictionary dictionaryWithDictionary:request.allHTTPHeaderFields];
    [header setObject:[self generateFinalHeader] forKey:@"common-params"];
    request.allHTTPHeaderFields = header;
    return request;
}

#pragma mark - inline method

- (NSDictionary *)generateFinalParams:(NSDictionary *)requestParams
{
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:self.commonParams];
    if (requestParams) {
        [allParams addEntriesFromDictionary:requestParams];
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:allParams options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *signatureStr = [HYDDes encryptWithText:json isKey:DESKEY];
    return @{@"jsonParams":signatureStr};
}

- (NSString *)generateFinalHeader
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.commonParams options:0 error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]?:@"";
}

- (NSString *)getServiceUrlWithServiceType:(HYDServiceType)serviceType
{
    return [HYDNetWorkMacro getUrlHostWithServiceType:serviceType];
}















@end
