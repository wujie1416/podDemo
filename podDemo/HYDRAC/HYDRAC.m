//
//  HYDRAC.m
//  podDemo
//
//  Created by wujie on 2017/12/22.
//  Copyright © 2017年 wujie. All rights reserved.
//

#import "HYDRAC.h"
#import <ReactiveObjC.h>

@interface HYDRAC ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *myView;
@end

@implementation HYDRAC

- (void)observe
{
    [[self.myView rac_signalForSelector:@selector(click)] subscribeNext:^(RACTuple * _Nullable x) {
        
    }];
}

- (void)click
{
    
}
@end
