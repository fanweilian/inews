//
//  NBControl.h
//  UI_06工厂设计模式
//
//  Created by YuTengxiao on 15/8/26.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 工厂设计模式，把不同的零件送进去，可以产生出不同的产品。
// 这就好比是一个类的工厂，产生出一个个对象。

@interface NBControl : NSObject

+ (UIButton *)createButtonWithFrame:(CGRect)frame tag:(NSInteger)tag title:(NSString *)title target:(id)target action:(SEL)action;

+ (UIButton *)createButtonWithFrame:(CGRect)frame tag:(NSInteger)tag image:(NSString *)image target:(id)target action:(SEL)action;

+ (UILabel *)createLabelWithFrame:(CGRect)frame tag:(NSInteger)tag title:(NSString *)title font:(NSInteger)font;

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame tag:(NSInteger)tag image:(NSString *)image cornerRadius:(CGFloat)cornerRadius;

+ (UITextField *)createTextFieldWithFrame:(CGRect)frame tag:(NSInteger)tag borderStyle:(UITextBorderStyle)style delegate:(id <UITextFieldDelegate>)delegate isSecret:(BOOL)isSecret;

+ (UIAlertView *)showAlertWithWithTitle:(NSString *)title message:(NSString *)message delegate:(id <UIAlertViewDelegate>)delegate buttonTitle:(NSString *)buttonTitle;

@end
