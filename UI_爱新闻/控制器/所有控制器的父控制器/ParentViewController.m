//
//  ParentViewController.m
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/10.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "ParentViewController.h"

@interface ParentViewController ()
//保存每次请求的枚举值，（下拉，还是上啦，还是第一次）


@end

@implementation ParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    // 如果这个值不为空，则在导航条上创建一个名字为title的Label，作为titleView
    if (self.navigationItemStringTitle) {
        [self createNavigationItemTitleViewWithTitle:self.navigationItemStringTitle];
    }
    
    // 如果这个值不为空，则在导航条上创建一个图片为imageTitle的imageView，作为titleView
    if (self.navigationItemImageTitle) {
        [self createNavigationItemTitleViewWithImage:self.navigationItemImageTitle];
    }
    
    // 设置导航条背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top-bg"] forBarMetrics:UIBarMetricsDefault];
}

- (void)createNavigationItemTitleViewWithTitle:(NSString *)title {
    UILabel *label = [NBControl createLabelWithFrame:CGRectMake(0, 0, 100, 30) tag:0 title:title font:20];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.shadowColor = [UIColor grayColor];
    label.shadowOffset = CGSizeMake(-1, -1);
    [label sizeToFit];
    self.navigationItem.titleView = label;
}

- (void)createNavigationItemTitleViewWithImage:(NSString *)imageName {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 145, 35)];
    imageView.image = [UIImage imageNamed:imageName];
    self.navigationItem.titleView = imageView;
}

- (void)createNavigationItemButtonWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)image action:(SEL)action isLeft:(BOOL)isLeft {
    // 如果传过来的frame是(0,0,0,0)， 使用默认的frame大小
    if (CGRectEqualToRect(frame, CGRectZero)) {
        frame = CGRectMake(0, 0, 64, 31);
    }
    UIButton *button = [NBControl createButtonWithFrame:frame tag:0 image:image target:self action:action];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    } else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
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
