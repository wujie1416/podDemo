//
//  HYDDes.m
//  podDemo
//
//  Created by wujie on 2017/12/13.
//  Copyright © 2017年 wujie. All rights reserved.
//

#import "HYDDes.h"

@implementation HYDDes

+ (NSString *)getDesKey
{
    NSString *str = [NSString stringWithFormat:@"%@%@",[HYDDes showWelcomeStr],[HYDDes getResultStr]];
    NSString *strKey = [str stringByReplacingOccurrencesOfString:@"" withString:@""];
    strKey = [strKey stringByReplacingOccurrencesOfString:@"" withString:@""];
    return strKey;
}

+ (NSString *)showWelcomeStr
{
    NSArray *arr = @[[HYDDes str1],
                     [HYDDes str2],
                     [HYDDes str3]];
    return [arr componentsJoinedByString:@""];
}

+ (NSString *)str1
{
    return @"o9 WL";
}

+ (NSString *)str2
{
    return @"!惹@#";
}

+ (NSString *)str3
{
    return @"8 *3$";
}

+ (NSString *)getResultStr
{
    NSArray *arr = @[[HYDDes resultStr1],
                     [HYDDes resultStr2],
                     [HYDDes resultStr3]];
    return [arr componentsJoinedByString:@""];
}

+ (NSString *)resultStr1{
    return @"D5m赢,";
}

+ (NSString *)resultStr2{
    return @"7,&4(";
}

+ (NSString *)resultStr3{
    return @"荡,F";
}

+ (NSString *)encryptWithText:(NSString *)sText isKey:(NSString *)isKey
{
    return @"";
}

+ (NSString *)decryptWithText:(NSString *)sText isKey:(NSString *)isKey
{
    return @"";
}

//+ (NSString *)encrypt:(NSString *)sText
//     encryptOrDecrypt:()







































@end
