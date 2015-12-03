//
//  MBProgressHUD+NBExtensions.m
//  MBT
//
//  Created by YuTengxiao on 15/10/5.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "MBProgressHUD+NBExtensions.h"

@implementation MBProgressHUD (NBExtensions)
// 迭代调用
+ (void)show:(NSString *)string duration:(NSTimeInterval)interval toView:(UIView *)view image:(NSString *)image {
    if (!interval) interval = 1;
    if (!view) view = [UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = string;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:interval];
}

+ (void)showSuccess:(NSString *)success duration:(NSTimeInterval)interval toView:(UIView *)view image:(NSString *)image {
    [self show:success duration:interval toView:view image:image];
}

+ (void)showSuccess:(NSString *)success duration:(NSTimeInterval)interval toView:(UIView *)view {
    [self showSuccess:success duration:interval toView:view image:nil];
}

+ (void)showSuccess:(NSString *)success duration:(NSTimeInterval)interval {
    [self showSuccess:success duration:interval toView:nil];
}

+ (void)showSuccess:(NSString *)success {
    [self showSuccess:success duration:0];
}

+ (void)showError:(NSString *)error duration:(NSTimeInterval)interval toView:(UIView *)view image:(NSString *)image {
    [self show:error duration:interval toView:view image:image];
}

+ (void)showError:(NSString *)error duration:(NSTimeInterval)interval toView:(UIView *)view {
    [self showError:error duration:interval toView:view image:nil];
}

+ (void)showError:(NSString *)error duration:(NSTimeInterval)interval {
    [self showError:error duration:interval toView:nil];
}

+ (void)showError:(NSString *)error {
    [self showError:error duration:0];
}

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (!view) view = [UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground = YES;
    return hud;
}

+ (MBProgressHUD *)showMessage:(NSString *)message {
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view {
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD {
    [self hideHUDForView:nil];
}

@end
