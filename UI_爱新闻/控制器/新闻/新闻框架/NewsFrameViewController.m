//
//  NewsFrameViewController.m
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/10.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "NewsFrameViewController.h"
#import "NewsViewController.h"
#import "NewsCategoryModel.h"
#import "SCNavTabBarController.h"

@interface NewsFrameViewController ()

@end

@implementation NewsFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSubViewControllers];
}

- (void)createSubViewControllers {
    NSArray *array = [NBHelper arrayWithPlistFile:@"NewsCategory.plist"];
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in array) {
        NewsCategoryModel *model = [[NewsCategoryModel alloc] initWithDictionary:dict error:nil];
        NewsViewController *vc = [[NewsViewController alloc] init];
        vc.title = model.title;
        vc.categoryID = model.categoryID;
        vc.urlFormat = self.urlFormat;
        [viewControllers addObject:vc];
    }
    
    // 用来管理多个控制器的控制器
    SCNavTabBarController *tbc = [[SCNavTabBarController alloc] init];
    tbc.subViewControllers = viewControllers;
    // 可以显示出所有的控制器标签
    tbc.canPopAllItemMenu = YES;
    // 设置导航条的背景色
    tbc.navTabBarColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar_background"]];
    [tbc addParentController:self];
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
