//
//  NewsCommentVIew.m
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/13.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "NewsCommentVIew.h"
@interface NewsCommentVIew()

@end
@implementation NewsCommentVIew

//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super initWithCoder:aDecoder]) {
//        
//    }
//    return self;
//}

- (IBAction)commentButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(commentView:commentButtonClick:)]) {
        [self.delegate commentView:self commentButtonClick:sender];
    }
    
}
- (IBAction)shareButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(commentView:shareButtonClick:)]) {
        [self.delegate commentView:self shareButtonClick:sender];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
