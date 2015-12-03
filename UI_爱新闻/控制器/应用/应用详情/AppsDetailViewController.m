//
//  AppsDetailViewController.m
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/14.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "AppsDetailViewController.h"
#import "AppsStorageView.h"
#import "NewsCommentsViewController.h"
#import "AppsFrameViewController.h"
#import "NBDataManager.h"
#import "MBProgressHUD+NBExtensions.h"
@interface AppsDetailViewController ()<UIWebViewDelegate>{

    UIWebView *_webView;
    AppsStorageView *_storageView;
    
}


@end

@implementation AppsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationItemButtonWithFrame:CGRectZero title:@"返回" image:@"backButton" action:@selector(backButtonClick:) isLeft:YES];
    [self createNavigationItemButtonWithFrame:CGRectZero title:@"下载" image:@"navButton" action:@selector(downloadButtonClick:) isLeft:NO];
    [self createWebView];
    [self createStorageVIew];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)backButtonClick:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)downloadButtonClick:(UIButton *)button{
    
    //除了可以发短信，还可以打电话，发短信，发电子邮件
    NSString *url=[NSString stringWithFormat:APPDOWNLOAD_URL,self.appID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    
}
-(void)createStorageVIew{
    _storageView=[[[NSBundle mainBundle] loadNibNamed:@"AppsStorageView" owner:nil options:nil] lastObject];
    CGRect frame=_storageView.frame;
    frame.origin.y=SCREEN_HEIGHT-64-44;
    _storageView.frame=frame;
    __weak typeof(self) weakSelf=self;
    [_storageView addStorageBlock:^{
        [weakSelf storageData];
        
    }];
    
    [self.view addSubview:_storageView];
    if ([[NBDataManager sharedManager] isModelExists:self.model]) {
        _storageView.storageButton.enabled=NO;
        [_storageView.storageButton setBackgroundImage:[UIImage imageNamed:@"storage"] forState:UIControlStateDisabled];
        _storageView.storageLabel.text=@"已收藏";
    }
    
}

-(void)storageData{
    NBDataManager *manager=[NBDataManager sharedManager];
    if ([manager isModelExists:self.model]) {
        [MBProgressHUD showError:@"已经收藏了"];
        
    }else{
        [manager insertModel:self.model];
        _storageView.storageButton.enabled=NO;
        [_storageView.storageButton setBackgroundImage:[UIImage imageNamed:@"storage"] forState:UIControlStateDisabled];
        _storageView.storageLabel.text=@"已收藏";
        [MBProgressHUD showSuccess:@"收藏成功"];
        
    }

    
    
    
}
-(void)createWebView{
    
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-44)];
    _webView.delegate=self;
    //加载视图
    NSString *urlString=[NSString stringWithFormat:APP_DETAIL_URL,self.model.app_id];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 下载完成后，增加如下js语句到webView代码中，可以拦截图片，并进行缩放。
    double width = webView.frame.size.width - 10;
    NSString *js = [NSString stringWithFormat:@"var script = document.createElement('script');"
                    "script.type = 'text/javascript';"
                    "script.text = \"function ResizeImages() { "
                    "var myimg,oldwidth;"
                    "var maxwidth=%f;" //缩放系数
                    "for(i=0;i <document.images.length;i++){"
                    "myimg = document.images[i];"
                    "if(myimg.width > maxwidth){"
                    "oldwidth = myimg.width;"
                    "myimg.width = maxwidth;"
                    "myimg.height = myimg.height * (maxwidth/oldwidth)*2;"
                    "}"
                    "}"
                    "}\";"
                    "document.getElementsByTagName('head')[0].appendChild(script);",width];
    // 这个方法，可以加载js文件
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //sellerid://490634283
    //cateid://6014
    NSString *url=request.URL.description;
    if ([url hasPrefix:@"sellerid://"]) {//开发者
        NSString *sellerID=[[url componentsSeparatedByString:@"://"] lastObject];
        NSString *url=[NSString stringWithFormat:APP_SELLER_URL,sellerID];
        url=[url stringByAppendingString:TRAILING];
        AppsFrameViewController *vc=[[AppsFrameViewController alloc]init];
        vc.urlFormat=url;
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
    }else if ([url hasPrefix:@"cateid://"]){//分类
        
        NSString *cateID=[[url componentsSeparatedByString:@"://"] lastObject];
        NSString *url=[NSString stringWithFormat:APP_CATE_URL,cateID];
        url=[url stringByAppendingString:TRAILING];
        AppsFrameViewController *vc=[[AppsFrameViewController alloc]init];
        vc.urlFormat=url;
        [self.navigationController pushViewController:vc animated:YES];
    
        
    }else if ([url hasPrefix:@"bookmark://"]){//收藏
        
        [self storageData];
        
    
    }else if ([url hasPrefix:@"comment://"]) { // 评论
        NewsCommentsViewController *vc = [[NewsCommentsViewController alloc] init];
        vc.navigationItemStringTitle = @"评论";
        [self.navigationController pushViewController:vc animated:YES];
    }

   
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
