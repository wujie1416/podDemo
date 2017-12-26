//
//  ApiURLResponse.h
//  podDemo
//
//  Created by wujie on 2017/12/14.
//  Copyright © 2017年 wujie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYDNetWorkMacro.h"

@interface ApiURLResponse : NSObject
@property (nonatomic, assign, readonly) APIURLResponseStatus status;
@property (nonatomic, strong, readonly) NSError *error;
@property (nonatomic, copy, readonly) id content;
@property (nonatomic, assign ,readonly) NSInteger requestId;

- (instancetype)initWithResponseData:(NSData *)responseData status:(APIURLResponseStatus)status requestId:(NSNumber *)requestId;
- (instancetype)initWithResponseData:(NSData *)responseData error:(NSError *)error  requestId:(NSNumber *)requestId;
- (instancetype)initWithResponseStr:(NSString *)responseStr error:(NSError *)error requestId:(NSNumber *)requestId;
@end
