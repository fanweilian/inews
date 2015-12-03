//
//  NewsViewController.m
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/10.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "NewsViewController.h"
#import "SCNavTabBarController.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import "NBCustomView.h"
#import "NewsDetailViewController.h"
#import "ProjectModel.h"
#import "ProjectDetailViewController.h"
// 导入SCNavTabBarController.h， 目的就是为了遵守协议，实现协议方法
@interface NewsViewController () <SCNavTabBarControllerDelegate> {
    // 保存最后一条的ID号
    NSInteger _maxID;
    //专题滚动视图的数据模型
    NSMutableArray *_projectArray;
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// 子类重写父类的注册cell方法
- (void)registerCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:@"newsCell"];
}

// 重写这个方法，呈现cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell" forIndexPath:indexPath];
    [cell updateCellWithModel:self.dataArray[indexPath.row]];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsDetailViewController *vc=[[NewsDetailViewController alloc]init];
    vc.urlFormat=NEWS_DETAIL_URL;
    vc.newsID=[self.dataArray[indexPath.row] news_id];
    vc.hidesBottomBarWhenPushed=YES;
    vc.navigationItemStringTitle=@"正文";
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}
- (void)firstRequestControllerTryToVisableOnScreen {
     _maxID = 0;
    self.requestType=RequestNormal;
    [self loadData];
    if ([self.title isEqualToString:@"全部"]||[self.title isEqualToString:@"头条"]) {
        
        _projectArray=[[NSMutableArray alloc]init];
        [self loadProjectData];
        
    }
}

#pragma mark -加载五个专题
-(void)loadProjectData{
    NSString *url=[NSString stringWithFormat:PROJECT_URL,5L,1L];
    
    [NBRequest requestWithURL:url type:RequestNormal success:^(NSData *requestData) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingMutableContainers error:nil];
        // [NBHelper createModelWithDictionary:array[0]];
        NSMutableArray *images=[[NSMutableArray alloc]init];
        NSMutableArray *titles=[[NSMutableArray alloc]init];
        for (NSDictionary *dict in array) {
            ProjectModel *model = [[ProjectModel alloc] initWithDictionary:dict error:nil];
            [images addObject:model.litpic];
            [titles addObject:model.post_title];
        
            [_projectArray addObject:model];
            
        }
        //创建专题广告视图
        NSString *subTitle=[self.title isEqualToString:@"全部"] ? @"全部新闻" : @"每日推荐";
        NBCustomView *view=[[NBCustomView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220) images:images titles:titles titleHeight:20 isAutoScroll:YES isShowPageControl:YES subTitle:subTitle tapBlock:^(NSInteger tapTag) {
            ProjectDetailViewController *vc = [[ProjectDetailViewController alloc] init];
            vc.urlFormat = PROJECT_DETAIL_URL;
            ProjectModel *model = _projectArray[tapTag];
            vc.ID = model.ID;
            vc.navigationItemStringTitle = model.post_title;
            [self.navigationController pushViewController:vc animated:YES];
            
            
            
        }];
        self.tableView.tableHeaderView=view;
        [self endRefresh];
        
    } failed:^(NSError *error) {
        [self endRefresh];

    }];
    
    

    
}
// 第一次加载，或者是下拉刷新，接口是一样的
- (void)loadNewData {
    _maxID = 0;
    self.requestType=RequestRefresh;
    self.isRefresh = YES;
    [self loadData];
}

// 上拉加载更多
- (void)loadMoreData {
    NewsModel *lastModel = self.dataArray.lastObject;
    // _maxID保存的是最后一条数据的news_id
    self.requestType=RequestMore;
    _maxID = [lastModel.news_id integerValue];
    [self loadData];
}

- (void)loadData {
    NSString *url = [NSString stringWithFormat:self.urlFormat, self.categoryID, _maxID, 10];
    NSLog(@"%@",url);
    [NBRequest requestWithURL:url type:self.requestType success:^(NSData *requestData) {
        // [NBHelper createModelWithDictionary:array[0]];
        if (self.isRefresh) {
            [self.dataArray removeAllObjects];
        }
        NSArray *array = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict in array) {
            NewsModel *model = [[NewsModel alloc] initWithDictionary:dict error:nil];
            [self.dataArray addObject:model];
        }
        [self endRefresh];
    } failed:^(NSError *error) {
        // 失败了，也要结束刷新
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
