//
//  CTMediator+AViewController.m
//  podDemo
//
//  Created by wujie on 2017/12/18.
//  Copyright © 2017年 wujie. All rights reserved.
//

#import "CTMediator+AViewController.h"

@implementation CTMediator (AViewController)

- (UIViewController *)aViewController
{
    return [self performTarget:@"A" action:@"viewController" params:nil shouldCacheTarget:NO];
}

@end
