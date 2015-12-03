//
//  NBCustomView.m
//  UI_09用代码来定义单元格
//
//  Created by YuTengxiao on 15/9/19.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "NBCustomView.h"
#import "NBClickedImageVIew.h"
#import "UIImageView+WebCache.h"
@interface NBWeakObject : NSObject

@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;

- (void)timerIsFire;

@end

@implementation NBWeakObject
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"
- (void)timerIsFire {
    if ([self.target respondsToSelector:self.action]) {
        [self.target performSelector:self.action];
    }
}
#pragma clang diagnostic pop
@end

@interface NBCustomView () <UIScrollViewDelegate> {
    UIScrollView *_scrollView; // 滚动视图
    UIPageControl *_pageControl; // 页面控制视图
    NSMutableArray *_imageArray; // 保存所有图片的数组
    NSMutableArray *_titleArray; // 保存所有标题的数组
    NSTimer *_timer;
}

@end

@implementation NBCustomView

- (void)dealloc {
  
    if ([_timer isValid]) {
        [_timer invalidate];
    }
}

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images titles:(NSArray *)titles titleHeight:(CGFloat)height isAutoScroll:(BOOL)isAuto isShowPageControl:(BOOL)isShow subTitle:(NSString *)subTitle tapBlock:(void (^)(NSInteger))block{
    if (self = [super initWithFrame:frame]) {
        [self createScrollViewWithImages:images titles:titles height:height block:block];
        if (isShow) {
            [self createPageControlWithHeight:height subTitle:subTitle];
        }
        if (isAuto) {
            [self createTimer];
        }
    }
    return self;
}

- (void)createTimer {
    NBWeakObject *weakObject = [[NBWeakObject alloc] init];
    weakObject.target = self;
    weakObject.action = @selector(autoScroll);
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:weakObject selector:@selector(timerIsFire) userInfo:nil repeats:YES];
    }

- (void)autoScroll {
    CGPoint offset = _scrollView.contentOffset;
    offset.x += self.bounds.size.width;
    [_scrollView setContentOffset:offset animated:YES];
    if (_scrollView.contentOffset.x == (_imageArray.count-1)*self.bounds.size.width) {
        _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    }
    
    _pageControl.currentPage = (_pageControl.currentPage+1) == _imageArray.count-2 ? 0 : _pageControl.currentPage+1;
}

- (void)createPageControlWithHeight:(CGFloat)height subTitle:(NSString *)subTitle {
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-height, self.bounds.size.width, height)];
    imageView.userInteractionEnabled=YES;
    imageView.alpha=0.6;
    imageView.image=[UIImage imageNamed:@"navbar_background"];
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width-100, 0, 100, height)];
    _pageControl.numberOfPages = _imageArray.count-2;
    _pageControl.currentPage = 0;
    // _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    // _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [_pageControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [imageView addSubview:_pageControl];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, height)];
    label.text=subTitle;
    label.textColor=[UIColor blueColor];
    label.font=[UIFont systemFontOfSize:14];
    [imageView addSubview:label];
    
    [self addSubview:imageView];
}

// pc 0 ~ 3     0：1x， 1：2x
- (void)valueChanged:(UIPageControl *)pc {
    [_scrollView setContentOffset:CGPointMake((pc.currentPage+1)*self.bounds.size.width, 0) animated:YES];
}

- (void)createScrollViewWithImages:(NSArray *)images titles:(NSArray *)titles height:(CGFloat)height block:(void (^)(NSInteger))block{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-height)];
    // 初始化图片数组，5123451
    _imageArray = [[NSMutableArray alloc] initWithArray:images];
    [_imageArray addObject:[images firstObject]];
    [_imageArray insertObject:[images lastObject] atIndex:0];
    // 初始化标题数组 (如果两个数组元素个数相同，则创建，否则，不创建标题数组)
    if (images.count == titles.count) {
        _titleArray = [[NSMutableArray alloc] initWithArray:titles];
        [_titleArray addObject:[titles firstObject]];
        [_titleArray insertObject:[titles lastObject] atIndex:0];
    }
    for (int i=0; i<_imageArray.count; i++) {
        NBClickedImageVIew *imageView = [[NBClickedImageVIew alloc] initWithFrame:CGRectMake(i*self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height-height)];
        //如果是本地图片，或则是 url
        if ([_imageArray[i] hasPrefix:@"http://"]) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[i]] placeholderImage:[UIImage imageNamed:@"placeholder-zt"]];
            
        }else{
        imageView.image = [UIImage imageNamed:_imageArray[i]];
        }
        //设置tapTag以及block
        imageView.tapBlock=block;
        if (i==0) {
            imageView.tapTag=_imageArray.count-1-2;
        }else if (i==_imageArray.count-1){
        
            imageView.tapTag=0;
        }else{
        
            imageView.tapTag=i-1;
            
        }
        
        
        [_scrollView addSubview:imageView];
        // 为每一张图片增加标题
        if (_titleArray) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-height-height, self.bounds.size.width, height)];
            label.backgroundColor = [UIColor blackColor];
            label.alpha = 0.5;
            label.textColor = [UIColor whiteColor];
            label.text = _titleArray[i];
            [imageView addSubview:label];
            
        }
    }
    _scrollView.contentSize = CGSizeMake(self.bounds.size.width*_imageArray.count, self.bounds.size.height);
    _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    [self addSubview:_scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == 0) {
        scrollView.contentOffset = CGPointMake((_imageArray.count-2)*self.bounds.size.width, 0);
    } else if (scrollView.contentOffset.x == (_imageArray.count-1)*self.bounds.size.width) {
        scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    }
    _pageControl.currentPage = scrollView.contentOffset.x/self.bounds.size.width-1;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
