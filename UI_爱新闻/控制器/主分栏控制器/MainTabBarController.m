//
//  MainTabBarController.m
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/10.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "MainTabBarController.h"
#import "ParentViewController.h"
#import "ViewControllerModel.h"

@interface MainTabBarController () {
    UIButton *_selectedButton;
}

@end

@implementation MainTabBarController
//启动画面，我们也可以写在程序入口处，比方说我们可以写在viewzdidload里面，开机启动画面，经常这么做
//可以自动设置，一般命名为default。。。。或者icon。。。。
//也可以自动创建（images。xcasset.sib）
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createViewControllers];
}

#pragma mark - 创建分栏控制器上所有的视图控制器
- (void)createViewControllers {
    NSArray *array = [NBHelper arrayWithPlistFile:@"ViewControllers.plist"];
    NSMutableArray *viewControllers = [NSMutableArray array];
    // 创建一个view，覆盖在系统的tabbar上!
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
    CGFloat width = SCREEN_WIDTH/5;
    view.backgroundColor = [UIColor redColor];
    for (int i=0; i<array.count; i++) {
        // JSONModel 直接将字典，转换成数据模型对象
        ViewControllerModel *model = [[ViewControllerModel alloc] initWithDictionary:array[i] error:nil];
        Class cls = NSClassFromString(model.viewController);
        ParentViewController *vc = [[cls alloc] init];
        //vc.title = model.title;
        vc.urlFormat = model.urlFormat;
        vc.navigationItemImageTitle = model.titleImage;
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
       // nc.tabBarItem.image = [UIImage imageNamed:model.icon];
        [viewControllers addObject:nc];
        // 创建分栏上自定义按钮
        UIButton *button = [NBControl createButtonWithFrame:CGRectMake(width*i, 0, width, 49) tag:10+i image:model.icon target:self action:@selector(buttonClick:)];
        [button setBackgroundImage:[UIImage imageNamed:[model.icon stringByAppendingString:@"_selected"]] forState:UIControlStateSelected];
        if (i == 0) {
            button.selected =  YES;
            _selectedButton = button;
        }
        [view addSubview:button];
    }
    [self.tabBar addSubview:view];
    self.viewControllers = viewControllers;
    
    // 移除tabbar上面的所有系统按钮
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:[UIControl class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)buttonClick:(UIButton *)button {
    self.selectedIndex = button.tag - 10;
    button.selected = YES;
    _selectedButton.selected = NO;
    _selectedButton = button;
    _selectedButton.selected=YES;
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
