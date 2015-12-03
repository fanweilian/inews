//
//  NewsCommentsViewController.m
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/13.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "NewsCommentsViewController.h"
#import "NewsCommitModel.h"
#include "NewsComimtView.h"
#import "NewsCommitCell.h"
@interface NewsCommentsViewController (){

    NewsComimtView *_commitView;
}

@end

@implementation NewsCommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationItemButtonWithFrame:CGRectZero title:@"正文" image:@"backButton" action:@selector(backBarButtonClick:) isLeft:YES];
    [self createNavigationItemButtonWithFrame:CGRectZero title:@"首页" image:@"navButton" action:@selector(homeButtonClick:) isLeft:NO];
    
    CGRect frame=self.tableView.frame;
    frame.size.height-=250;
    self.tableView.frame=frame;
    
    [self cancelRefreshView];
    [self createFooterView];
    
    // Do any additional setup after loading the view.
}

-(void)registerCell{

    [self.tableView registerNib:[UINib nibWithNibName:@"NewsCommitCell" bundle:nil] forCellReuseIdentifier:@"newsCommitCell"];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCommitCell *cell=[tableView dequeueReusableCellWithIdentifier:@"newsCommitCell"];
    [cell updateCellWithModel:self.dataArray[indexPath.row] row:indexPath.row];
    return cell;
    
    
    
}

-(void)backBarButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)homeButtonClick:(UIButton *)button{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void)createFooterView{
    _commitView=[[[NSBundle mainBundle] loadNibNamed:@"NewsCommitView" owner:nil options:nil] lastObject];
    [_commitView addCommitButtonTarget:self action:@selector(commitButtonClick:)];
    self.tableView.tableFooterView=_commitView;
    
    //作为第一响应者；
    [_commitView.textView  becomeFirstResponder];
    
    
}
-(void)commitButtonClick:(UIButton *)button{
    // 也可以通过这个方法拿到textView
  //  NewsComimtView *view=(NewsComimtView *)self.tableView.tableFooterView;
    if (_commitView.textView.text.length!=0) {
        NewsCommitModel *model=[[NewsCommitModel alloc]init];
        
        UIDevice *currentDevice=[UIDevice currentDevice];
        model.uesrName=currentDevice.name;
        model.date=@"刚刚";
        model.content=_commitView.textView.text;
        [self.dataArray addObject:model];
        [self.tableView reloadData];
        
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        // 清空text
        _commitView.textView.text=@"";
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCommitModel *model=self.dataArray[indexPath.row];
    CGFloat height=[NBHelper sizeWithText:model.content size:CGSizeMake(316, CGFLOAT_MIN) fontSize:17].height;
    return height+41+20;
    
    
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
