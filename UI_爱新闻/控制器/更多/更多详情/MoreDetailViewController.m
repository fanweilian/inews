//
//  MoreDetailViewController.m
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/14.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "MoreDetailViewController.h"
#import "ModetailModel.h"

@interface MoreDetailViewController (){

    UITextView *_textView;
}

@end

@implementation MoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationItemButtonWithFrame:CGRectMake(0, 0, 90, 30) title:@"关于I叛党" image:@"backButton" action:@selector(backBUttonClick:) isLeft:YES];
    self.title=@"";
    [self ceeateTextView];
    [self loaddata];
    // Do any additional setup after loading the view.
}

-(void)backBUttonClick:(UIButton *)button{

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)ceeateTextView{

    _textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,SCREEN_HEIGHT-64-49)];
    _textView.editable=NO;
    _textView.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:_textView];
    
    
    
}

-(void)loaddata{
    [NBRequest requestWithURL:self.urlFormat type:RequestNormal success:^(NSData *requestData) {
        ModetailModel *model=[[ModetailModel alloc]initWithData:requestData error:nil];
        _textView.text=model.post_content;
        
        
    
    } failed:^(NSError *error) {
    
    }];
    
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
