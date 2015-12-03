//
//  Define.h
//  Project_demo
//
//  Created by YuTengxiao on 15/9/6.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#ifndef Project_demo_Define_h
#define Project_demo_Define_h

/* 新闻界面
 category_ids: 类别的id列表， 新闻界面中每个类别对应一个id号
 count:        显示数据的个数
 ID:       类别             对应关系
 @"0":     @"全部"
 @"9999":  @"头条"
 @"1"      @"快讯"
 @"10"     @"视频"
 @"11"     @"游戏"
 @"1967"   @"应用"
 @"4"      @"业界"
 @"43"     @"库克"
 @"2634"   @"乔布斯"
 @"3"      @"炫配"
 @"8"      @"活动"
 @"6"      @"ipone应用技巧"
 @"5"      @"iPad技巧"
 @"230"    @"Mac技巧"
 @"7"      @"appStore技巧"
 @"12"     @"iTunes技巧"
 */
#define NEWS_URL @"http://api.ipadown.com/apple-news-client/news.list.php?category_ids=%@&max_id=%ld&count=%ld"

/* 新闻详情
 news_id: 新闻的news_id号
 */
#define NEWS_DETAIL_URL @"http://api.ipadown.com/apple-news-client/news.php?news_id=%@"
/* 短信分享 新闻链接
 参数: news_id
 */
#define NEWS_MESSAGE_URL @"http://news.ipadown.com/%@"

/* 应用界面
 count: 10      下载一页10个数据
 page:  1       下载第一页数据
 price: all     价格分类 (all 所有, free 免费，pricedrop 限免，paid 付费)
 */
#define APPS_URL @"http://api.ipadown.com/iphone-client/apps.list.php?device=iPhone&t=commend&count=%ld&page=%ld&device=iPhone&price=%@"

/* 应用详情 : 接口数据是html!
 appid: 应用的app_id号
 */
#define APP_DETAIL_URL @"http://m.ipadown.com/iphone.client.php?appid=%@"

/* 点击应用详情webView最下面开发商的接口，实际推出的是应用页面
开发商: sellerid://345439319  --  sellerid=345439319
 */
#define APP_SELLER_URL @"http://api.ipadown.com/iphone-client/apps.list.php?sellerid=%@"
/* 点击应用详情webView最下面分类的接口，实际推出的是应用页面
 分类:   cateid://6011  --  cateid=6011
 */
#define APP_CATE_URL @"http://api.ipadown.com/iphone-client/apps.list.php?cateid=%@"
/* 这个并不是一个接口，只是用于拼接上面两个字段，组成最终接口使用 */
#define TRAILING @"&count=%ld&page=%ld&device=iPhone&price=%@"

/* 专题 (新闻界面的滚动广告视图，实际上就是此接口，count=5&page=1)
 count: 10    获取10个应用的详细信息
 page : 1     获取第1页数据
 */
#define PROJECT_URL @"http://api.ipadown.com/iphone-client/zt.list.php?parent_id=4118&count=%ld&page=%ld"

/* 专题详情
 id : 专题的ID号
 */
#define PROJECT_DETAIL_URL @"http://api.ipadown.com/iphone-client/zt.detail.php?id=%@"


/* 壁纸
 page:     第几页
 count:    一页显示多少数据
 category: 类别
 orderby:  排序的方式
 device:   获取那种设备中的壁纸
 */
// http://api.ipadown.com/pic/pic.api.php?page=1&count=6&category=0&orderby=rand&device=iPhone
// http://api.ipadown.com/pic/pic.api.php?page=1&count=6&category=0&orderby=rand&device=iPhone
#define WALL_PAPER_URL @"http://api.ipadown.com/pic/pic.api.php?page=%ld&count=%d&category=%d&orderby=rand&device=iPhone"

// 链接App下载：http://link.ipadown.com/907394324 (应用详情页面下载，也是这个链接)
#define APPDOWNLOAD_URL @"http://link.ipadown.com/%@"


/* 更多 如下接口，保存在More.plist中
 ieliwb@gmail.com 意见反馈 （发送邮件）
 http://www.ipadown.com/ 技术支持
 http://link.ipadown.com/438195021 去AppStore给我们评分，实际连接的是下面的地址。 会在网页上进行跳转。
 只有真机有效，模拟器下无效。 另，如果想直接打开app将如下地址https://替换为itms://或者itms-apps://
 https://itunes.apple.com/cn/app/id438195021?mt=8
 
 http://api.ipadown.com/client/page-by-id.php?id=2 关于I派党
 http://api.ipadown.com/client/page-by-id.php?id=5 团队联系方式
 http://api.ipadown.com/client/page-by-id.php?id=83 APP玩家交流群
 
 http://www.ipadown.com/           意见反馈
 http://link.ipadown.com/438195021 技术支持
 // 下面这三个，跟: 去AppStore给我们评分一样，都是进行网页跳转。
 http://link.ipadown.com/534041869 《爱新闻HD》for iPad
 http://link.ipadown.com/457802407 《精品限时免费》for iPhone
 http://link.ipadown.com/467267027 《精品限时免费》for iPad
 */

// iOS7版本的适配
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#endif
