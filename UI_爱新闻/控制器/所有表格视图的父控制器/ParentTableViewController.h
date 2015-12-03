//
//  ParentTableViewController.h
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/10.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "ParentViewController.h"

@interface ParentTableViewController : ParentViewController <UITableViewDataSource, UITableViewDelegate>

// 表格视图的对象，和数据源数组
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

// 是否是下拉刷新!
@property (nonatomic, assign) BOOL isRefresh;
// 子类要重写的方法 (下拉刷新，和上拉加载，要调用的方法)
- (void)loadNewData;
- (void)loadMoreData;

// 子类要重写的方法，注册cell
- (void)registerCell;

// 子类请求数据完成(成功或失败)后，需要调用的方法
- (void)endRefresh;
// 子类调用的方法，取消刷新视图
- (void)cancelRefreshHeaderView;
- (void)cancelRefreshFooterView;
- (void)cancelRefreshView;

@end
