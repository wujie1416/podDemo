//
//  ViewController.m
//  podDemo
//
//  Created by wujie on 2017/12/6.
//  Copyright © 2017年 wujie. All rights reserved.
//

#import "ViewController.h"
#import "CTMediator+AViewController.h"
#import <objc/runtime.h>
#import "HYDRefreshViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"podDemo";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    UIViewController *vc =  [[CTMediator sharedInstance]aViewController];
    HYDRefreshViewController *vc = [[HYDRefreshViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
