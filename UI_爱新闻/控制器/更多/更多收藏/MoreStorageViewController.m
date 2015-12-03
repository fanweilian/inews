//
//  MoreStorageViewController.m
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/14.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "MoreStorageViewController.h"
#import "NBDataManager.h"
#import "AppsCell.h"
#import "AppsModel.h"
@interface MoreStorageViewController (){

    UIBarButtonItem *_editItem;
    UIBarButtonItem *_deleteItem;
    NSMutableArray *_deleteArray;
    
    
}

@end

@implementation MoreStorageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationItemButtonWithFrame:CGRectZero title:@"返回" image:@"backButton" action:@selector(BackButtonClick:) isLeft:YES];
    
    [self cancelRefreshView];
    [self loadData];
    [self createEdit];
    // Do any additional setup after loading the view.
}

-(void)createEdit{
    UIButton *button=[NBControl createButtonWithFrame:CGRectMake(0, 0, 60, 30) tag:0 image:@"nacButton" target:self action:@selector(editButtonClick:)];
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _editItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItems=@[_editItem];
    
    
    button =[NBControl createButtonWithFrame:CGRectMake(0, 0, 60, 30) tag:0 image:@"navutton" target:self action:@selector(deleteButtonClick:)];
    [button setTitle:@"删除" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _deleteItem=[[UIBarButtonItem alloc]initWithCustomView:button];

    _deleteArray=[[NSMutableArray alloc]init];
    


    
}
-(void)editButtonClick:(UIButton *)button{

    if ([[button titleForState:UIControlStateNormal] isEqualToString:@"编辑"]) {
        [button setTitle:@"完成" forState:UIControlStateNormal];
        [self.tableView setEditing:YES animated:YES];
    }else{
        [button setTitle:@"编辑" forState:UIControlStateNormal];
        [self.tableView setEditing:NO animated:YES];
        [_deleteArray removeAllObjects];
        self.navigationItem.rightBarButtonItems=@[_editItem];
    }
}

-(void)deleteButtonClick:(UIButton *)button{
    [self.dataArray removeObjectsInArray:_deleteArray];
    for (AppsModel *model in _deleteArray) {
        [[NBDataManager sharedManager]deleteModelForAPPID:model.app_id];
    }
    [_deleteArray removeAllObjects];
    self.navigationItem.rightBarButtonItems=@[_editItem];
    [self.tableView reloadData];
    
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppsModel *model=self.dataArray[indexPath.row];
    if (![_deleteArray containsObject:model]) {
        [_deleteArray removeObject:model];
    }
    if (_deleteArray.count>0) {
        self.navigationItem.rightBarButtonItems=@[_editItem];
        
    }

    

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    AppsModel *model=self.dataArray[indexPath.row];
    if (![_deleteArray containsObject:model]) {
        [_deleteArray addObject:model];
    }
    if (_deleteArray.count>0) {
        self.navigationItem.rightBarButtonItems=@[_editItem,_deleteItem];
        
    }
}
-(void)loadData{
    [self.dataArray setArray:[[NBDataManager sharedManager] allModels]];
    [self.tableView reloadData];
    
}
- (void)registerCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"AppsCell" bundle:nil] forCellReuseIdentifier:@"appsCell"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"appsCell" forIndexPath:indexPath];
    [cell updateCellWithModel:self.dataArray[indexPath.row] row:indexPath.row];
    return cell;
}
-(void)BackButtonClick:(UIButton *)button{

    [self.navigationController popViewControllerAnimated:YES];
    
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
