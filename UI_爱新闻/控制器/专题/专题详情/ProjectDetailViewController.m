//
//  ProjectDetailViewController.m
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/11.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "ProjectDetailViewController.h"
#import "ProjectDetailModel.h"
#import "AppsCell.h"
#import "ProjectDetailHeaderView.h"
#import "NBTableSectionHeaderView.h"
#import "AppsDetailViewController.h"
@interface ProjectDetailViewController ()

@end

@implementation ProjectDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createNavigationItemButtonWithFrame:CGRectZero title:@"列表" image:@"backButton" action:@selector(backItemClick:) isLeft:YES];
    [self cancelRefreshView];
    [self loadData];
}

- (void)backItemClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadData {
    NSString *url = [NSString stringWithFormat:self.urlFormat, self.ID];
    [NBRequest requestWithURL:url type:RequestNormal success:^(NSData *requestData) {
        // NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingMutableContainers error:nil];
        // [NBHelper createModelWithDictionary:dict];
        ProjectDetailModel *model = [[ProjectDetailModel alloc] initWithData:requestData error:nil];
        // 创建表头
        [self createTableHeaderView:model];
        [self.dataArray setArray:model.apps];
        [self endRefresh];
    } failed:^(NSError *error) {
        [self endRefresh];
    }];
}

- (void)createTableHeaderView:(ProjectDetailModel *)model {
    ProjectDetailHeaderView *view = [[ProjectDetailHeaderView alloc] initWithModel:model];
    self.tableView.tableHeaderView = view;
}

- (void)registerCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"AppsCell" bundle:nil] forCellReuseIdentifier:@"appsCell"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"appsCell" forIndexPath:indexPath];
    [cell updateCellWithModel:self.dataArray[indexPath.row] row:indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[NBTableSectionHeaderView alloc] initWithTitle:@"    本专题包含的Apps"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppsDetailViewController *vc=[[AppsDetailViewController alloc]init];
    vc.appID=[self.dataArray[indexPath.row] app_id];
    vc.urlFormat=APP_DETAIL_URL;
    vc.navigationItemStringTitle=@"详细介绍";
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
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
