//
//  AppsViewController.m
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/11.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "AppsViewController.h"
#import "SCNavTabBarController.h"
#import "AppsModel.h"
#import "AppsCell.h"
#import "AppsDetailViewController.h"
@interface AppsViewController () <SCNavTabBarControllerDelegate>

@property (nonatomic, assign) NSInteger page;

@end

@implementation AppsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
}


- (void)registerCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"AppsCell" bundle:nil] forCellReuseIdentifier:@"appsCell"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"appsCell" forIndexPath:indexPath];
    [cell updateCellWithModel:self.dataArray[indexPath.row] row:indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppsDetailViewController *vc=[[AppsDetailViewController alloc]init];
    vc.model=self.dataArray[indexPath.row];
    vc.urlFormat=APP_DETAIL_URL;
    vc.navigationItemStringTitle=@"详细介绍";
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
- (void)firstRequestControllerTryToVisableOnScreen {
    // NSLog(@"requestUrl : %@",[NSString stringWithFormat:self.urlFormat, 10L, self.page, self.price]);
    self.page=1;
    self.requestType=RequestNormal;
    [self loadData];
}

- (void)loadNewData {
    // 默认从第一页开始请求数据
    self.page = 1;
    self.requestType=RequestRefresh;
    self.isRefresh = YES;
    [self loadData];
}

- (void)loadMoreData {
    self.page++;
    self.requestType=RequestMore;
    [self loadData];
}

- (void)loadData {
    NSString *url = [NSString stringWithFormat:self.urlFormat, 10L, self.page, self.price];
    [NBRequest requestWithURL:url type:self.requestType success:^(NSData *requestData) {
        if (self.isRefresh) {
            [self.dataArray removeAllObjects];
        }
        NSArray *array = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingMutableContainers error:nil];
        // [NBHelper createModelWithDictionary:array[0]];
        for (NSDictionary *dict in array) {
            AppsModel *model = [[AppsModel alloc] initWithDictionary:dict error:nil];
            [self.dataArray addObject:model];
        }
        // 不要忘记结束刷新
        [self endRefresh];
    } failed:^(NSError *error) {
        [self endRefresh];
    }];
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
