//
//  ParentTableViewController.m
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/10.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "ParentTableViewController.h"
#import "MJRefresh.h"

@interface ParentTableViewController ()

@end

@implementation ParentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTableView];
    [self createRefreshView];
}

#pragma mark - 创建表格视图，及初始化数据源数组，及注册cell
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    // 初始化数据源数组
    self.dataArray = [[NSMutableArray alloc] init];
    // 注册cell
    [self registerCell];
}

// 子类要重写这个方法
- (void)registerCell {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"userCell"];
}

#pragma mark - UITableViewDelegate 方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

// 子类要重写这个方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell" forIndexPath:indexPath];
    return cell;
}

// 因为这个项目里，所有的cell高度都是100，所以，这里写了，所有的子类都不需要写了!
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

#pragma mark - 创建上拉，和下拉的刷新控件
- (NSArray *)imagesArrayFrom:(NSInteger)fromIndex to:(NSInteger)toIndex {
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (NSInteger i=fromIndex; i<=toIndex; i++) {
        NSString *file = [NSString stringWithFormat:@"dropdown_anim__%05ld",i];
        UIImage *image = [UIImage imageNamed:file];
        [images addObject:image];
    }
    return images;
}

- (void)createRefreshView {
    // 下拉刷新
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [header setImages:[self imagesArrayFrom:31 to:60] forState:MJRefreshStateIdle];
    [header setImages:[self imagesArrayFrom:10 to:30] forState:MJRefreshStatePulling];
    [header setImages:[self imagesArrayFrom:1 to:9] forState:MJRefreshStateRefreshing];
    self.tableView.header = header;
    // 上拉加载
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setImages:[self imagesArrayFrom:10 to:30] forState:MJRefreshStateRefreshing];
    self.tableView.footer = footer;
}

// 下面两个方法放空，由子类重写
- (void)loadNewData {
    
}

- (void)loadMoreData {
    
}

// 由子类调用，结束刷新的方法
- (void)endRefresh {
    [self.tableView reloadData];
    if (self.isRefresh) {
        [self.tableView.header endRefreshing];
        self.isRefresh = NO;
    } else {
        [self.tableView.footer endRefreshing];
    }
}

- (void)cancelRefreshView {
    [self cancelRefreshHeaderView];
    [self cancelRefreshFooterView];
}

- (void)cancelRefreshHeaderView {
    self.tableView.header = nil;
}

- (void)cancelRefreshFooterView {
    self.tableView.footer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
