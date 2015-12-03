//
//  NBTableSectionHeaderView.m
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/11.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "NBTableSectionHeaderView.h"

@implementation NBTableSectionHeaderView

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        [self createUIWithTitle:title];
    }
    return self;
}

- (void)createUIWithTitle:(NSString *)title {
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    self.bounds = frame;
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar_background"]];
    self.alpha = 0.8;
    UILabel *label = [NBControl createLabelWithFrame:frame tag:0 title:title font:22];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:22];
    label.textAlignment = NSTextAlignmentLeft;
    label.shadowColor = [UIColor blackColor];
    label.shadowOffset = CGSizeMake(-1, -1);
    [self addSubview:label];
}

@end
