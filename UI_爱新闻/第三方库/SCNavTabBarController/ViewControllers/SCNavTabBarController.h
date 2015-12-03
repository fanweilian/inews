//
//  SCNavTabBarController.h
//  SCNavTabBarController
//
//  Created by ShiCang on 14/11/17.
//  Copyright (c) 2014年 SCNavTabBarController. All rights reserved.
//

/* yutx noted: 2015-09-10 在使用SCNavTabBarController管理多个视图控制器的时候，每个页面都会执行viewDidLoad, viewWillAppear:， viewDidAppear: 如果是非网络应用的话，还可以。但考虑到使用网络的应用，则会增加太多的非主动网络请求。因此，对此代码进行了调整。
 主要修改:
    一开始调整为懒加载的方式控制，即：当用户滑动到哪个视图控制器，再加载哪个。但在实际使用中发现，这种策略严重影响用户体验（滑动到一个未加载过的页面，滑动过程中是空白页面，滑动结束时才能显示），因此废弃掉。 之所以在这里提及，是想建议使用这个框架的同仁，放弃此种想法。
    后将代码改回：页面预先加载。但是，增加回调，由使用者在回调中进行第一次加载页面时的网络请求。
 重要: 
    1. 只需要遵守协议，实现协议方法即可。不需要设置代理，SCNavTabBarController，已经获取了所有子视图控制器的指针。
    2. 这个回调，只针对每个子视图控制器，第一次呈现在屏幕上，进行网络请求时（当然，其他处理也可以）使用。这个页面其他时刻的网络请求，比如上拉加载，或者下拉刷新，需要自己处理。
    3. 只需要将第一次网络请求放在回调函数中进行即可，不用关心，滑动回来时，还会触发回调，来进行二次请求。
    4. 注意，是第一次，且只是第一次。
 
 其他修改:
    调整SCPopView上标签按钮的位置；
    增加保护，防止下拉按钮盖住SCPopView上的标签按钮；
    增加SCPopView出现时，当前控制器标签按钮的标记（选中的视图控制器为黑色，其他为灰色）
 
    调整在滑动时，SCNavTabBar上出现的还没有滑动过去，就切换按钮标签的指示线的小bug；
    SCNavTabBar，在计算标签按钮的文本长度的时候，增加iOS7以上版本兼容。
 */

#import <UIKit/UIKit.h>

/* yutx added 2015-09-10 增加协议方法， */
@protocol SCNavTabBarControllerDelegate <NSObject>

@optional
- (void)firstRequestControllerTryToVisableOnScreen;

@end
/* yutx added end 2015-09-10 */


@class SCNavTabBar;

@interface SCNavTabBarController : UIViewController

@property (nonatomic, assign)   BOOL        canPopAllItemMenu;          // Default value: YES
@property (nonatomic, assign)   BOOL        scrollAnimation;            // Default value: NO
@property (nonatomic, assign)   BOOL        mainViewBounces;            // Default value: NO

@property (nonatomic, strong)   NSArray     *subViewControllers;        // An array of children view controllers

@property (nonatomic, strong)   UIColor     *navTabBarColor;            // Could not set [UIColor clear], if you set, NavTabbar will show initialize color
@property (nonatomic, strong)   UIColor     *navTabBarLineColor;
@property (nonatomic, strong)   UIImage     *navTabBarArrowImage;

/**
 *  Initialize Methods
 *
 *  @param show - can pop all item menu
 *
 *  @return Instance
 */
- (id)initWithCanPopAllItemMenu:(BOOL)can;

/**
 *  Initialize SCNavTabBarViewController Instance And Show Children View Controllers
 *
 *  @param subViewControllers - set an array of children view controllers
 *
 *  @return Instance
 */
- (id)initWithSubViewControllers:(NSArray *)subViewControllers;

/**
 *  Initialize SCNavTabBarViewController Instance And Show On The Parent View Controller
 *
 *  @param viewController - set parent view controller
 *
 *  @return Instance
 */
- (id)initWithParentViewController:(UIViewController *)viewController;

/**
 *  Initialize SCNavTabBarViewController Instance, Show On The Parent View Controller And Show On The Parent View Controller
 *
 *  @param subControllers - set an array of children view controllers
 *  @param viewController - set parent view controller
 *  @param can            - can pop all item menu
 *
 *  @return Instance
 */
- (id)initWithSubViewControllers:(NSArray *)subControllers andParentViewController:(UIViewController *)viewController canPopAllItemMenu:(BOOL)can;

/**
 *  Show On The Parent View Controller
 *
 *  @param viewController - set parent view controller
 */
- (void)addParentController:(UIViewController *)viewController;

@end
