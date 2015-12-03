//
//  ParentViewController.h
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/10.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParentViewController : UIViewController
@property(nonatomic,assign) NBRequestType requestType;
// 请求的接口的格式字符串
@property (nonatomic, copy) NSString *urlFormat;

// 导航栏上的titleView，显示的图片名字
@property (nonatomic, copy) NSString *navigationItemImageTitle;
// 导航栏上的titleView，显示的字符串内容
@property (nonatomic, copy) NSString *navigationItemStringTitle;

// 用一个图片，来创建创建导航条titleView
- (void)createNavigationItemTitleViewWithImage:(NSString *)imageName;
// 用一个字符串，来创建导航条titleView
- (void)createNavigationItemTitleViewWithTitle:(NSString *)title;
// 创建导航栏上的左右标签按钮的方法
- (void)createNavigationItemButtonWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)image action:(SEL)action isLeft:(BOOL)isLeft;

@end
