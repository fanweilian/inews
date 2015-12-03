//
//  MBProgressHUD+NBExtensions.h
//  MBT
//
//  Created by YuTengxiao on 15/10/5.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (NBExtensions)

// 显示成功消息
+ (void)showSuccess:(NSString *)success;
// 显示成功消息，及持续时间
+ (void)showSuccess:(NSString *)success duration:(NSTimeInterval)interval;
// 显示成功消息，及持续时间，及所在的视图
+ (void)showSuccess:(NSString *)success duration:(NSTimeInterval)interval toView:(UIView *)view;
// 显示成功消息，及持续时间，及所在的视图，及成功图片
+ (void)showSuccess:(NSString *)success duration:(NSTimeInterval)interval toView:(UIView *)view image:(NSString *)image;

// 显示出错消息
+ (void)showError:(NSString *)error;
// 显示出错消息，及持续时间
+ (void)showError:(NSString *)error duration:(NSTimeInterval)interval;
// 显示出错消息，及持续时间，及所在的视图
+ (void)showError:(NSString *)error duration:(NSTimeInterval)interval toView:(UIView *)view;
// 显示出错消息，及持续时间，及所在的视图，及成功图片
+ (void)showError:(NSString *)error duration:(NSTimeInterval)interval toView:(UIView *)view image:(NSString *)image;

// 显示信息（加载动画）
+ (MBProgressHUD *)showMessage:(NSString *)message;
// 显示信息（加载动画）及所在视图
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
// 隐藏view上的HUD
+ (void)hideHUDForView:(UIView *)view;
// 隐藏HUD
+ (void)hideHUD;

@end
