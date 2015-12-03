//
//  NBControl.m
//  UI_06工厂设计模式
//
//  Created by YuTengxiao on 15/8/26.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "NBControl.h"

@implementation NBControl

+ (UIButton *)createButtonWithFrame:(CGRect)frame tag:(NSInteger)tag image:(NSString *)image target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.tag = tag;
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    // [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame tag:(NSInteger)tag title:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame tag:(NSInteger)tag title:(NSString *)title font:(NSInteger)font {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.tag = tag;
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:font];
    return label;
}

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame tag:(NSInteger)tag image:(NSString *)image cornerRadius:(CGFloat)cornerRadius {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:image];
    imageView.tag = tag;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = cornerRadius;
    return imageView;
}

+ (UITextField *)createTextFieldWithFrame:(CGRect)frame tag:(NSInteger)tag borderStyle:(UITextBorderStyle)style delegate:(id <UITextFieldDelegate>)delegate isSecret:(BOOL)isSecret {
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.tag = tag;
    textField.borderStyle = style;
    textField.delegate = delegate;
    textField.secureTextEntry = isSecret;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    return textField;
}

+ (UIAlertView *)showAlertWithWithTitle:(NSString *)title message:(NSString *)message delegate:(id <UIAlertViewDelegate>)delegate buttonTitle:(NSString *)buttonTitle {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:buttonTitle otherButtonTitles:nil, nil];
    [av show];
    return av;
}

@end
