//
//  NBCustomView.h
//  UI_09用代码来定义单元格
//
//  Created by YuTengxiao on 15/9/19.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBCustomView : UIView

//frame自定义广告视图的大小
//images图片名字的数组或者是url
//用来显示去哪不新闻或者日推荐的文字
// tapBlock点击图片调用的block
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images titles:(NSArray *)titles titleHeight:(CGFloat)height isAutoScroll:(BOOL)isAuto isShowPageControl:(BOOL)isShow subTitle:(NSString *)subTitle tapBlock:(void (^)(NSInteger tapTag))block;

@end
