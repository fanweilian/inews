//
//  NewsComimtView.h
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/13.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsComimtView : UIView

@property (weak, nonatomic) IBOutlet UITextView *textView;


-(void)addCommitButtonTarget:(id)target action:(SEL)action;
@end
