//
//  HYDRefreshViewController.m
//  podDemo
//
//  Created by wujie on 2017/12/26.
//  Copyright © 2017年 wujie. All rights reserved.
//

//https://github.com/CoderMJLee/MJRefresh

#import "HYDRefreshViewController.h"
#import <MJRefresh.h>
#define WS(weakSelf)   __weak typeof(self) weakSelf = self
@interface HYDRefreshViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MJRefreshGifHeader *header;
@property (nonatomic, strong) MJRefreshAutoGifFooter *footer;
@property (nonatomic, strong) MJRefreshBackGifFooter *gitFooter;

@property (nonatomic, strong) NSArray *idleImages;
@property (nonatomic, strong) NSArray *pullingImages;
@property (nonatomic, strong) NSArray *refreshingImages;
@end

@implementation HYDRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

- (void)loadMoreData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
    });
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",arc4random() % 100];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 5:
            [self.tableView.mj_header beginRefreshing];
            break;
        case 29:
            [self.tableView.mj_footer beginRefreshing];
            break;
        default:
            break;
    }
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor darkGrayColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsZero;
//        _tableView.mj_header = self.header;
//        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//        }];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//        [_tableView.mj_header beginRefreshing];
//        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//
//        }];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//        _tableView.mj_footer = self.footer;
        //The pull to refresh 06-Hidden After loaded
//        _tableView.mj_footer.hidden = YES;
//        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//
//        }];
//        _tableView.mj_footer = self.gitFooter;
    }
    return _tableView;
}

- (MJRefreshGifHeader *)header
{
    if (!_header) {
        _header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//        [_header setImages:self.idleImages forState:MJRefreshStateIdle];
//        [_header setImages:self.pullingImages forState:MJRefreshStatePulling];
//        [_header setImages:self.refreshingImages forState:MJRefreshStateRefreshing];
//        _header.lastUpdatedTimeLabel.hidden = YES;
//        _header.stateLabel.hidden = YES;
        [_header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
        [_header setTitle:@"Please to refresh" forState:MJRefreshStatePulling];
        [_header setTitle:@"Loading..." forState:MJRefreshStateRefreshing];
        _header.stateLabel.font = [UIFont systemFontOfSize:20];
        _header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:16];
        _header.stateLabel.textColor = [UIColor redColor];
        _header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    }
    return _header;
}

- (MJRefreshAutoGifFooter *)footer
{
    if (!_footer) {
        _footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{

        }];
//        [_footer setImages:self.refreshingImages forState:MJRefreshStateRefreshing];
//        _footer.refreshingTitleHidden = YES;
        [_footer setTitle:@"Click or drag up to refresh" forState:MJRefreshStateIdle];
        [_footer setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
        [_footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
        _footer.stateLabel.font = [UIFont systemFontOfSize:17];
        _footer.stateLabel.textColor = [UIColor blueColor];
    }
    return _footer;
}

- (MJRefreshBackGifFooter *)gitFooter
{
    if (!_gitFooter) {
        _gitFooter = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
            
        }];
        [_gitFooter setImages:self.idleImages forState:MJRefreshStateIdle];
        [_gitFooter setImages:self.pullingImages forState:MJRefreshStatePulling];
        [_gitFooter setImages:self.refreshingImages forState:MJRefreshStateRefreshing];
    }
    return _gitFooter;
}


- (NSArray *)idleImages
{
    if (!_idleImages) {
        _idleImages = @[[UIImage imageNamed:@"1"]];
    }
    return _idleImages;
}

- (NSArray *)pullingImages
{
    if (!_pullingImages) {
        _pullingImages = @[[UIImage imageNamed:@"2"]];
    }
    return _pullingImages;
}

- (NSArray *)refreshingImages
{
    if (!_refreshingImages) {
        _refreshingImages = @[[UIImage imageNamed:@"3"]];
    }
    return _refreshingImages;
}
@end
