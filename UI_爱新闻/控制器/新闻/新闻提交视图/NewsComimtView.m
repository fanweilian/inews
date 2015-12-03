//
//  NewsComimtView.m
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/13.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "NewsComimtView.h"
@interface NewsComimtView ()

@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property(nonatomic,weak) id target;
@property(nonatomic,assign) SEL action;

@end



@implementation NewsComimtView
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"


- (IBAction)commitButton:(UIButton *)sender {
    if ([self.target respondsToSelector:self.action]) {
        [self.target performSelector:self.action withObject:sender];
    }
}
#pragma clang diagnostic pop

-(void)addCommitButtonTarget:(id)target action:(SEL)action{

    self.target=target;
    self.action=action;
    
}
//可以重写这个方法，对控件进绘制
-(void)drawRect:(CGRect)rect{
    //首先调用父类方法
    [super drawRect:rect];
    //设置按钮的边框颜色，
    self.commitButton.layer.borderColor=[UIColor blackColor].CGColor;
    self.commitButton.layer.borderWidth=1;
    
    [self.commitButton setBackgroundImage:[UIImage imageNamed:@"navButton"] forState:UIControlStateHighlighted];
    self.commitButton.layer.cornerRadius=8;

    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
