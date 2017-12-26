//
//  HYDDes.h
//  podDemo
//
//  Created by wujie on 2017/12/13.
//  Copyright © 2017年 wujie. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DESKEY [HYDDes getDesKey]

@interface HYDDes : NSObject

/**
 获取默认秘钥
 */
+ (NSString *)getDesKey;

/**
 加密
 */
+ (NSString *)encryptWithText:(NSString *)sText isKey:(NSString *)isKey;

/**
 解密
 */
+ (NSString *)decryptWithText:(NSString *)sText isKey:(NSString *)isKey;
@end
