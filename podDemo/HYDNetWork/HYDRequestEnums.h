//
//  HYDRequestEnums.h
//  podDemo
//
//  Created by wujie on 2017/12/12.
//  Copyright © 2017年 wujie. All rights reserved.
//

#ifndef HYDRequestEnums_h
#define HYDRequestEnums_h

static NSTimeInterval kNetworkingTimeoutSeconds = 30.0f;

typedef NS_ENUM(NSInteger, APIURLResponseStatus){
    APIURLResponseStatusSuccess,        //作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层的RTApiBaseManager来决定。
    APIURLResponseStatusErrorTimeout,
    APIURLResponseStatusErrorNoNetwork  // 默认除了超时以外的错误都是无网络错误。
};

typedef NS_ENUM(NSInteger, LEHttpRequestMethod){
    LEHttpRequestMethodAFN = 0, // 表示使用AFN发送HTTP请求
};

typedef NS_ENUM(NSInteger, HYDServiceType){
    ServiceTypeBase         = 0,            //恒易贷
    ServiceTypeJsd          = 1,            //极速贷
    ServiceTypeHelp         = 2,            //帮助中心
    ServiceTypeCustom       = 4             //自定义
};
#endif /* HYDRequestEnums_h */
