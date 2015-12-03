//
//  AppsFrameViewController.m
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/10.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "AppsFrameViewController.h"
#import "SCNavTabBarController.h"
#import "AppsViewController.h"

@interface AppsFrameViewController ()

@end

@implementation AppsFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createViewControllers];
}

#pragma mark - 创建视图控制器
- (void)createViewControllers {
    // 价格分类 (all 所有, free 免费，pricedrop 限免，paid 付费)
    NSArray *prices = @[@"all", @"free", @"pricedrop", @"paid"];
    NSArray *titles = @[@"全部", @"免费", @"限免", @"付费"];
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (int i = 0; i<prices.count; i++) {
        AppsViewController *vc = [[AppsViewController alloc] init];
        vc.price = prices[i];
        vc.title = titles[i];
        vc.urlFormat = self.urlFormat;
        [viewControllers addObject:vc];
    }
    SCNavTabBarController *tbc = [[SCNavTabBarController alloc] init];
    tbc.subViewControllers = viewControllers;
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
