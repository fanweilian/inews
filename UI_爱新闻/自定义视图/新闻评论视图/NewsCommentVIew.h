//
//  NewsCommentVIew.h
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/13.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsCommentVIew;
@protocol NewsCommentViewDelegate <NSObject>

@optional
-(void)commentView:(NewsCommentVIew *)view commentButtonClick:(UIButton *)button;

-(void)commentView:(NewsCommentVIew *)view shareButtonClick:(UIButton *)button;

@end
@interface NewsCommentVIew : UIView
@property(nonatomic,weak) id <NewsCommentViewDelegate> delegate;
@end
