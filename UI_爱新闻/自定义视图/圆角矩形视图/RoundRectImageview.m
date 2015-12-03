//
//  RoundRectImageview.m
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/10.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "RoundRectImageview.h"

@implementation RoundRectImageview
// 代码创建，使用这个方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8;
    }
    return self;
}

// 用xib创建，会自动调用这个方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8;
    }
    return self;
}

@end
