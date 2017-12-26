//
//  ApiURLResponse.m
//  podDemo
//
//  Created by wujie on 2017/12/14.
//  Copyright © 2017年 wujie. All rights reserved.
//

#import "ApiURLResponse.h"
#import "HYDDes.h"
@interface ApiURLResponse ()
@property (nonatomic, assign, readwrite) APIURLResponseStatus status;
@property (nonatomic, copy, readwrite) id content;
@property (nonatomic, strong, readwrite) NSError *error;
@property (nonatomic, assign, readwrite) NSInteger requestId;
@end

@implementation ApiURLResponse

#pragma mark - life cycle

static id static_result (NSString *dataStr)
{
    NSMutableDictionary *dict = nil;
    dataStr = [HYDDes decryptWithText:dataStr isKey:DESKEY];
    if (dataStr.length > 0) {
        NSError *error;
        NSData *jsonData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        dict = [NSJSONSerialization JSONObjectWithData:jsonData
                                               options:NSJSONReadingMutableContainers
                                                 error:&error];
        if (dict == nil || error) {
        
        }
    }
    return dict;
}

- (instancetype)initWithResponseData:(NSData *)responseData
                              status:(APIURLResponseStatus)status
                           requestId:(NSNumber *)requestId
{
    if (self = [super init]) {
        self.status = status;
    }
    return self;
}

- (instancetype)initWithResponseData:(NSData *)responseData
                               error:(NSError *)error
                           requestId:(NSNumber *)requestId
{
    return self;
}

- (instancetype)initWithNoDESResponseData:(NSData *)responseData
                                    error:(NSError *)error
                                requestId:(NSNumber *)requestId
{
    return self;
}

- (instancetype)initWithResponseStr:(NSString *)responseStr
                              error:(NSError *)error
                          requestId:(NSNumber *)requestId
{
    return self;
}

- (APIURLResponseStatus)responseStatusWithError:(NSError *)error
{
    if (error) {
        if (error.code == NSURLErrorTimedOut) {// 除了超时以外，所有错误都当成是无网络
            return APIURLResponseStatusErrorTimeout;
        }
        return APIURLResponseStatusErrorNoNetwork;
    } else {
        return APIURLResponseStatusSuccess;
    }
}

@end
