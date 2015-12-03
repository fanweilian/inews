//
//  SCPopView.h
//  SCNavTabBarController
//
//  Created by ShiCang on 14/11/17.
//  Copyright (c) 2014年 SCNavTabBarController. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCPopViewDelegate <NSObject>

@optional
- (void)viewHeight:(CGFloat)height;
- (void)itemPressedWithIndex:(NSInteger)index;

@end

@interface SCPopView : UIView

@property (nonatomic, weak)     id      <SCPopViewDelegate>delegate;
@property (nonatomic, strong)   NSArray *itemNames;
/* yutx added 2015-09-10 增加一个方法，根据当前索引，标记当前的按钮*/
- (void)markCurrentButtonWithIndex:(NSInteger)currentIndex;
/* yutx added 2015-09-10 */

@end
