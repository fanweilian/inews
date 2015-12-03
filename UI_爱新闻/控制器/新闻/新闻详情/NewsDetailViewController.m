//
//  NewsDetailViewController.m
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/12.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NewsDetailModel.h"
#import "NewsCommentVIew.h"
#import <MessageUI/MessageUI.h>
#import "NewsCommentsViewController.h"
@interface NewsDetailViewController () <NewsCommentViewDelegate,UIActionSheetDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>{

    UIWebView *_webView;
    
}
@property(nonatomic,strong) NewsDetailModel *model;
@end
@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createWebView];
    [self createCommentView];
    [self loadData];
    [self createNavigationItemButtonWithFrame:CGRectZero title:@"返回" image:@"backButton" action:@selector(backButtonClick:) isLeft:YES];
    // Do any additional setup after loading the view.
}

-(void)createCommentView{
    NewsCommentVIew *view=[[[NSBundle mainBundle] loadNibNamed:@"NewsCommentView" owner:self options:nil] lastObject];
    CGRect frame=view.frame;
    frame.origin.y=SCREEN_HEIGHT-view.frame.size.height-64;
    view.frame=frame;
    view.delegate=self;
    [self.view addSubview:view];
    
}
-(void)commentView:(NewsCommentVIew *)view commentButtonClick:(UIButton *)button{
    NewsCommentsViewController *vc=[[NewsCommentsViewController alloc]init];
    vc.navigationItemStringTitle=@"评论";
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
-(void)commentView:(NewsCommentVIew *)view shareButtonClick:(UIButton *)button{

    UIActionSheet *as=[[UIActionSheet alloc]initWithTitle:@"请选择你的操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"Email推荐给朋友",@"短信分享给好友",@"复制到剪切板", nil];
    [as showInView:self.view];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *url=[NSString stringWithFormat:NEWS_MESSAGE_URL,self.model.news_id];
    NSString *info=[NSString stringWithFormat:@"%@\n%@",self.model.title,url];

    switch (buttonIndex) {
            
        case 0://Email给好友
        {
            if ([MFMailComposeViewController canSendMail]) {//判断是否能发
            //创建一个发送邮件的视图控制器
            MFMailComposeViewController *mailViewController=[[MFMailComposeViewController alloc]init];
            mailViewController.mailComposeDelegate=self;
            
            // 设置发送主题
            [mailViewController setSubject:[NSString stringWithFormat:@"精彩推荐:%@",self.model.title]];
            //设置发送数据(邮件主题)
            [mailViewController setMessageBody:info isHTML:YES];
            
            // NSData *data=UIImagePNGRepresentation(imageView.image);
            // [mailViewController addAttachmentData:data mimeType:@"image/png" fileName:@"bg.png"];
            [self presentViewController:mailViewController animated:YES completion:nil];
            
            
        }

            break;
        }
        case 1:{//短信
            if ([MFMessageComposeViewController canSendText]) {
                MFMessageComposeViewController *messageViewController=[[MFMessageComposeViewController alloc]init];
                messageViewController.messageComposeDelegate=self;
               
                [messageViewController setBody:info];
                
                [self presentViewController:messageViewController animated:YES completion:nil];
                
            }
            
           
        
            break;
        }
            
        case 2:{//剪切板
            
             UIPasteboard *board = [UIPasteboard generalPasteboard];
            board.string=info;
            break;
        }
    }

    
    
}
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:nil];

    
}
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissViewControllerAnimated:YES completion:nil];
    

}
-(void)backButtonClick:(UIButton *)button{

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadData{
    NSString *url=[NSString stringWithFormat:self.urlFormat,self.newsID];
    NSLog(@"****%@",url);
    [NBRequest requestWithURL:url type:RequestNormal success:^(NSData *requestData) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"%@",dict);
        //[NBHelper createModelWithDictionary:dict];
        self.model=[[NewsDetailModel alloc]initWithDictionary:dict error:nil];
        NSString *path=[[NSBundle mainBundle] pathForResource:@"news" ofType:@"html"];
        NSString *format=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"------%@",format);
        //把数据装换为string
        NSString *htmlString=[NSString stringWithFormat:format,self.model.title,self.model.pubDate,self.model.catename,self.model.description];
        [_webView loadHTMLString:htmlString baseURL:nil];
        
        
        
        
    } failed:^(NSError *error) {
        
    }];
   // _webView=[UIWebView alloc]initWithFrame:<#(CGRect)#>
    
}
-(void)createWebView{

    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-44)];
    [self.view addSubview:_webView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
