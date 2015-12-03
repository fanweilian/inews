//
//  SCNavTabBarController.m
//  SCNavTabBarController
//
//  Created by ShiCang on 14/11/17.
//  Copyright (c) 2014年 SCNavTabBarController. All rights reserved.
//

#import "SCNavTabBarController.h"
#import "CommonMacro.h"
#import "SCNavTabBar.h"

@interface SCNavTabBarController () <UIScrollViewDelegate, SCNavTabBarDelegate>
{
    NSInteger       _currentIndex;              // current page index
    NSMutableArray  *_titles;                   // array of children view controller's title
    
    SCNavTabBar     *_navTabBar;                // NavTabBar: press item on it to exchange view
    UIScrollView    *_mainView;                 // content view
    /* yutx added 20150910 保存上一次加载的视图控制器的索引，以及保存当前页面是否请求的数组 */
    NSInteger _lastIndex;
    NSMutableArray *_isRequestedArray;
    /* yutx added end 20150910 */

}

@end

@implementation SCNavTabBarController

#pragma mark - Life Cycle
#pragma mark -

- (id)initWithCanPopAllItemMenu:(BOOL)can
{
    self = [super init];
    if (self)
    {
        _canPopAllItemMenu = can;
    }
    return self;
}

- (id)initWithSubViewControllers:(NSArray *)subViewControllers
{
    self = [super init];
    if (self)
    {
        _subViewControllers = subViewControllers;
    }
    return self;
}

- (id)initWithParentViewController:(UIViewController *)viewController
{
    self = [super init];
    if (self)
    {
        [self addParentController:viewController];
    }
    return self;
}

- (id)initWithSubViewControllers:(NSArray *)subControllers andParentViewController:(UIViewController *)viewController canPopAllItemMenu:(BOOL)can;
{
    self = [self initWithSubViewControllers:subControllers];
    
    _canPopAllItemMenu = can;
    [self addParentController:viewController];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initConfig];
    [self viewConfig];
    /* yutx added 2015-09-10 在所有内容处理完毕后，对第0个视图控制器，进行页面请求 */
    if (![_isRequestedArray containsObject:@(0)]) {
        [_isRequestedArray addObject:@(0)];
        UIViewController *vc = _subViewControllers[0];
        if ([vc respondsToSelector:@selector(firstRequestControllerTryToVisableOnScreen)]) {
            [vc performSelector:@selector(firstRequestControllerTryToVisableOnScreen)];
        }
    }
    /* yutx added end 2015-09-10 */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods
#pragma mark -
- (void)initConfig
{
    // Iinitialize value
    _currentIndex = 1;
    
    _navTabBarColor = _navTabBarColor ? _navTabBarColor : NavTabbarColor;
    
    // Load all title of children view controllers
    _titles = [[NSMutableArray alloc] initWithCapacity:_subViewControllers.count];
    for (UIViewController *viewController in _subViewControllers)
    {
        [_titles addObject:viewController.title];
    }
    
    /* yutx added 2015-09-10 增加保存每个页面是否请求过的数组*/
    if (!_isRequestedArray) {
        _isRequestedArray = [[NSMutableArray alloc] init];
    }
    /* yutx added end 2015-09-10 */
}

- (void)viewInit
{
    // Load NavTabBar and content view to show on window
    _navTabBar = [[SCNavTabBar alloc] initWithFrame:CGRectMake(DOT_COORDINATE, DOT_COORDINATE, SCREEN_WIDTH, NAV_TAB_BAR_HEIGHT) canPopAllItemMenu:_canPopAllItemMenu];
    _navTabBar.delegate = self;
    _navTabBar.backgroundColor = _navTabBarColor;
    _navTabBar.lineColor = _navTabBarLineColor;
    _navTabBar.itemTitles = _titles;
    _navTabBar.arrowImage = _navTabBarArrowImage;
    [_navTabBar updateData];
    
    _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(DOT_COORDINATE, _navTabBar.frame.origin.y + _navTabBar.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - _navTabBar.frame.origin.y - _navTabBar.frame.size.height - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT)];
    _mainView.delegate = self;
    _mainView.pagingEnabled = YES;
    _mainView.bounces = _mainViewBounces;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.contentSize = CGSizeMake(SCREEN_WIDTH * _subViewControllers.count, DOT_COORDINATE);
    [self.view addSubview:_mainView];
    [self.view addSubview:_navTabBar];
}

- (void)viewConfig
{
    [self viewInit];
    
    // Load children view controllers and add to content view
    [_subViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        
        UIViewController *viewController = (UIViewController *)_subViewControllers[idx];
        viewController.view.frame = CGRectMake(idx * SCREEN_WIDTH, DOT_COORDINATE, SCREEN_WIDTH, _mainView.frame.size.height);
        [_mainView addSubview:viewController.view];
        [self addChildViewController:viewController];
    }];
}

#pragma mark - Public Methods
#pragma mark -
- (void)setNavTabbarColor:(UIColor *)navTabbarColor
{
    // prevent set [UIColor clear], because this set can take error display
    CGFloat red, green, blue, alpha;
    if ([navTabbarColor getRed:&red green:&green blue:&blue alpha:&alpha] && !red && !green && !blue && !alpha)
    {
        navTabbarColor = NavTabbarColor;
    }
    _navTabBarColor = navTabbarColor;
}

- (void)addParentController:(UIViewController *)viewController
{
    // Close UIScrollView characteristic on IOS7 and later
    if ([viewController respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
}

#pragma mark - Scroll View Delegate Methods
#pragma mark -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    /* yutx modified 2015-09-10 将此处注释掉，滚动时，不进行判断，如果这里进行判断，指示线的显示也会稍微有些问题 */
#if 0
    _currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
    _navTabBar.currentItemIndex = _currentIndex;
#endif
    /* yutx modified end 2015-09-10 */
}

/* yutx added 2015-09-10 增加scrollViewDidEndDecelerating:协议方法，将scrollViewDidScroll:协议方法中得处理，调整到滚动停止 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
    _navTabBar.currentItemIndex = _currentIndex;
    if (_lastIndex != _currentIndex) {
        _lastIndex = _currentIndex;
        if (![_isRequestedArray containsObject:@(_currentIndex)]) {
            [_isRequestedArray addObject:@(_currentIndex)];
            UIViewController *vc = _subViewControllers[_currentIndex];
            if ([vc respondsToSelector:@selector(firstRequestControllerTryToVisableOnScreen)]) {
                [vc performSelector:@selector(firstRequestControllerTryToVisableOnScreen)];
            }
        }
    }
}
/* yutx added end 2015-09-10 */

#pragma mark - SCNavTabBarDelegate Methods
#pragma mark -
- (void)itemDidSelectedWithIndex:(NSInteger)index
{
    [_mainView setContentOffset:CGPointMake(index * SCREEN_WIDTH, DOT_COORDINATE) animated:_scrollAnimation];
    
    /* yutx added 2015-09-10 因此将scrollViewDidScroll:协议方法中得内容，改到scrollViewDidEndDecelerating:。因此，这里进行修正 */
    _currentIndex = _mainView.contentOffset.x / SCREEN_WIDTH;
    _navTabBar.currentItemIndex = _currentIndex;
    if (_lastIndex != _currentIndex) {
        _lastIndex = _currentIndex;
        if (![_isRequestedArray containsObject:@(_currentIndex)]) {
            [_isRequestedArray addObject:@(_currentIndex)];
            UIViewController *vc = _subViewControllers[_currentIndex];
            if ([vc respondsToSelector:@selector(firstRequestControllerTryToVisableOnScreen)]) {
                [vc performSelector:@selector(firstRequestControllerTryToVisableOnScreen)];
            }
        }
    }
    /* yutx added end 2015-09-10 */
}

- (void)shouldPopNavgationItemMenu:(BOOL)pop height:(CGFloat)height
{
    if (pop)
    {
        [UIView animateWithDuration:0.5f animations:^{
            _navTabBar.frame = CGRectMake(_navTabBar.frame.origin.x, _navTabBar.frame.origin.y, _navTabBar.frame.size.width, height + NAV_TAB_BAR_HEIGHT);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5f animations:^{
            _navTabBar.frame = CGRectMake(_navTabBar.frame.origin.x, _navTabBar.frame.origin.y, _navTabBar.frame.size.width, NAV_TAB_BAR_HEIGHT);
        }];
    }
    [_navTabBar refresh];
}

@end
