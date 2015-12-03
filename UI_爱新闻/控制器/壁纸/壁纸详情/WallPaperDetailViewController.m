//
//  WallPaperDetailViewController.m
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/12.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "WallPaperDetailViewController.h"
#import "NBClickedImageVIew.h"
#import "UIImageView+WebCache.h"
#import "WallPaperModel.h"
#import "MBProgressHUD+NBExtensions.h"
//这个框架主要是用于处理消息的（发邮件，消息）
#import <MessageUI/MessageUI.h>
//如果要邮件要返回，必须遵守这个协议
@interface WallPaperDetailViewController ()<UIScrollViewDelegate,UIActionSheetDelegate,MFMailComposeViewControllerDelegate>{

    UIScrollView *_scrollView;
    //scrollView上所有的imageView的数组
    NSMutableArray *_imageViewArray;
    UILabel *_detailLabel;
    
    
}

@end

@implementation WallPaperDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationItemButtonWithFrame:CGRectZero title:@"返回" image:@"backButton" action:@selector(backButtonClick:) isLeft:YES];
    
    [self createButtonOnToolBar];
    [self createScrollView];
    [self createDetailLabel];
    // Do any additional setup after loading the view.
}


-(void)backButtonClick:(UIButton *)button{

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createButtonOnToolBar{

    [self.navigationController .toolbar setBackgroundImage:[UIImage imageNamed:@"top-bg"] forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    UIButton *button=[NBControl createButtonWithFrame:CGRectMake(0, 0, 60, 30) tag:0 image:@"navButton" target:self action:@selector(sharedButton:)];
    [button setTitle:@"更多" forState:UIControlStateNormal];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:button];
    UIBarButtonItem *spaceItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width=SCREEN_WIDTH-60-30;
    self.toolbarItems=@[spaceItem,item];
}


-(void)sharedButton:(UIButton *)button{
    UIActionSheet *as=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存",@"复制",@"邮箱", nil];

    [as showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSInteger index=_scrollView.contentOffset.x/SCREEN_WIDTH;
    NBClickedImageVIew *imageView=_imageViewArray[index];
    switch (buttonIndex) {
        case 0://保存
        {
            UIImageWriteToSavedPhotosAlbum(imageView.image, self,@selector(image:didFinishSavingWithError: contentInfo:), NULL);
            break;
        }
        case 1:{//保存到剪切板
            
            UIPasteboard *board = [UIPasteboard generalPasteboard];
            board.image=imageView.image;
            break;
        }
            
        case 2:{//邮箱
            
            if ([MFMailComposeViewController canSendMail]) {//判断是否能发
                //创建一个发送邮件的视图控制器
                MFMailComposeViewController *mailViewController=[[MFMailComposeViewController alloc]init];
                mailViewController.mailComposeDelegate=self;
                
                // 设置发送主题
                [mailViewController setSubject:@"相册"];
                //设置发送数据
                
                NSData *data=UIImagePNGRepresentation(imageView.image);
                [mailViewController addAttachmentData:data mimeType:@"image/png" fileName:@"bg.png"];
                [self presentViewController:mailViewController animated:YES completion:nil];
                
                
            }
            
            
            
            break;
        }
    }
}

-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contentInfo:(void *)contentInfo{
    if (error) {
        [MBProgressHUD showError:@"保存失败" duration:0.75];
    }else{
    [MBProgressHUD showError:@"保存成功" duration:0.75];
        
    }
    
}
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    //present 过后后，要dismiss回来
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)createScrollView{
    _imageViewArray=[[NSMutableArray alloc]init];
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44-64)];
    NSArray *urls=[self.model.imgs componentsSeparatedByString:@"\""];
    NSInteger i=0;
    for (NSString *url in urls) {
        if (![url hasPrefix:@"http://"]) {
            continue;
        }
        NBClickedImageVIew *imageView=[[NBClickedImageVIew alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44-64)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder-pic"]];
        imageView.tapTag=i+10;
        __weak typeof(self) weakself=self;
        
    [imageView setTapBlock:^(NSInteger tapTag) {
    BOOL status=[UIApplication sharedApplication].statusBarHidden;
        [weakself setEveryBarShowOrHidenStates: status];
        
    }];
        [_scrollView addSubview:imageView];
        [_imageViewArray addObject:imageView];
        i++;
    }
    
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.contentSize=CGSizeMake(i*SCREEN_WIDTH, SCREEN_HEIGHT-64-49);
    _scrollView.delegate=self;
    _scrollView.pagingEnabled=YES;
    [self.view addSubview:_scrollView];
    [self createNavigationItemTitleViewWithTitle:[NSString stringWithFormat:@"1 / %ld",i]];
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    BOOL status=[UIApplication sharedApplication].statusBarHidden;
    if (status==NO) {
        [self setEveryBarShowOrHidenStates: NO];
    }
    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index=scrollView.contentOffset.x/SCREEN_WIDTH;
    [self createNavigationItemTitleViewWithTitle:[NSString stringWithFormat:@"%ld / %ld",index+1,_imageViewArray.count]];
    
    
    
}
-(void)setEveryBarShowOrHidenStates:(BOOL)currentStatus{
    
    [UIApplication sharedApplication].statusBarHidden=!currentStatus;
    self.navigationController.navigationBarHidden=!currentStatus;
    self.navigationController.toolbarHidden=!currentStatus;
    _detailLabel.hidden=!currentStatus;
    //status是yes，表示是影藏的，那么，这个时候，相当于各个bar都显示了
    //
    CGPoint center=_scrollView.center;
    if (currentStatus==YES) {
        center.y-=64;
    }else{
    
        center.y+=64;
    }
    _scrollView.center=center;
    
}
-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:NO animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createDetailLabel{
    _detailLabel=[NBControl createLabelWithFrame:CGRectZero tag:0 title:self.model.title  font:15];
    _detailLabel.backgroundColor=[UIColor blackColor];
    _detailLabel.textColor=[UIColor whiteColor];
    CGFloat height=[NBHelper sizeWithText:self.model.title size:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX) fontSize:15].height;
    _detailLabel.frame=CGRectMake(0,SCREEN_HEIGHT-64-44-height-10, SCREEN_WIDTH, height+10);
    _detailLabel.alpha=0.5;
    _detailLabel.numberOfLines=0;
    [self.view addSubview:_detailLabel];
    

    
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
