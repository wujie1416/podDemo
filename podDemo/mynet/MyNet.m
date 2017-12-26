//
//  MyNet.m
//  podDemo
//
//  Created by wujie on 2017/12/6.
//  Copyright © 2017年 wujie. All rights reserved.
//

#import "MyNet.h"
#import "AFNetworking.h"

@interface MyNet()
@property (nonatomic, strong) AFURLSessionManager *afUrlManager;
@property (nonatomic, strong) AFHTTPSessionManager *afHttpManager;
@property (nonatomic, strong) AFNetworkReachabilityManager *afReachabilityManager;
@end

@implementation MyNet
+ (MyNet *)current
{
    static MyNet *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MyNet alloc] init];
    });
    return manager;
}

- (void)AfNetworkStatus
{
    [self.afReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                break;
            case AFNetworkReachabilityStatusNotReachable:
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                break;
            default:
                break;
        }
    }];
}

- (void)download
{
    NSURL *url = [NSURL URLWithString:@""];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *downloadTask = [self.afUrlManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return url;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
    }];
    [downloadTask resume];
}

- (void)upload
{
    NSURL *url = [NSURL URLWithString:@""];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURL *filePath = [NSURL fileURLWithPath:@""];
    NSURLSessionUploadTask *uploadTask = [self.afUrlManager uploadTaskWithRequest:request fromFile:filePath progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    [uploadTask resume];
}

- (void)data
{
    NSURL *url = [NSURL URLWithString:@""];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [self.afUrlManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    [dataTask resume];
}

- (void)get
{
    [self.afHttpManager GET:@"" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)post
{
    [self.afHttpManager POST:@"" parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (AFURLSessionManager *)afUrlManager
{
    if (!_afUrlManager) {
        _afUrlManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return _afUrlManager;
}

- (AFHTTPSessionManager *)afHttpManager
{
    if (!_afHttpManager) {
        _afHttpManager = [[AFHTTPSessionManager alloc] init];
    }
    return _afHttpManager;
}

- (AFNetworkReachabilityManager *)afReachabilityManager
{
    if (!_afReachabilityManager) {
        _afReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    }
    return _afReachabilityManager;
}

@end
