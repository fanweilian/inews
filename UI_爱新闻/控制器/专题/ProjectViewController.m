//
//  ProjectViewController.m
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/10.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "ProjectViewController.h"
#import "ProjectModel.h"
#import "ProjectCell.h"
#import "ProjectDetailViewController.h"

@interface ProjectViewController ()

@property (nonatomic, assign) NSInteger page;

@end

@implementation ProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 1;
    self.requestType=RequestNormal;
    [self loadData];
}

- (void)registerCell {
    [self.tableView registerClass:[ProjectCell class] forCellReuseIdentifier:@"projectCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"projectCell"];
    [cell updateCellWithModel:self.dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProjectDetailViewController *vc = [[ProjectDetailViewController alloc] init];
    vc.urlFormat = PROJECT_DETAIL_URL;
    ProjectModel *model = self.dataArray[indexPath.row];
    vc.ID = model.ID;
    vc.navigationItemStringTitle = model.post_title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadNewData {
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
    NSString *url = [NSString stringWithFormat:self.urlFormat, 10, self.page];
    [NBRequest requestWithURL:url type:self.requestType success:^(NSData *requestData) {
        if (self.isRefresh) {
            [self.dataArray removeAllObjects];
        }
        NSArray *array = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingMutableContainers error:nil];
        // [NBHelper createModelWithDictionary:array[0]];
        for (NSDictionary *dict in array) {
            ProjectModel *model = [[ProjectModel alloc] initWithDictionary:dict error:nil];
            [self.dataArray addObject:model];
        }
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
