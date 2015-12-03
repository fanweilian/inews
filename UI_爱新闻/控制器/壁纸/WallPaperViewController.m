//
//  WallPaperViewController.m
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/10.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "WallPaperViewController.h"
#import "WallPaperCell.h"
#import "WallPaperModel.h"
#import "WallPaperDetailViewController.h"
@interface WallPaperViewController ()

@end

@implementation WallPaperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page=1;
    self.requestType=RequestNormal;
    [self loadData];
    // Do any additional setup after loading the view.
}

-(void)registerCell{
    [self.tableView registerNib:[UINib nibWithNibName:@"WallPaperCell" bundle:nil] forCellReuseIdentifier:@"wallPaperCell"];

    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WallPaperCell *cell=[tableView dequeueReusableCellWithIdentifier:@"wallPaperCell" forIndexPath:indexPath];
    __weak typeof(self) weakSelf=self;
   [cell updateCellWithModelArray:self.dataArray[indexPath.row] tapBlock:^(NSInteger taptag) {
      // WallPaperModel *model=weakSelf.dataArray[indexPath.row][taptag];
       WallPaperDetailViewController *vc=[[WallPaperDetailViewController alloc]init];
       //vc.urlFormat =model.imgs;
       vc.model=weakSelf.dataArray[indexPath.row][taptag];
       vc.hidesBottomBarWhenPushed=YES;
       [weakSelf.navigationController pushViewController:vc animated:YES];
       
       
       
       
       
   }];
    
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 222.0f;
    
}
-(void)loadNewData{
    self.page=1;
    self.requestType=RequestRefresh;
    self.isRefresh=YES;
    [self loadData];

}
-(void)loadMoreData{
    self.page++;
    self.requestType=RequestMore;
    [self loadData];
    

}
-(void)loadData{
    NSString *url=[NSString stringWithFormat:self.urlFormat,self.page,6,0];
    [NBRequest requestWithURL:url type:self.requestType success:^(NSData *requestData) {
        NSArray *array=[NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingMutableContainers error:nil];
 [NBHelper createModelWithDictionary:array[0]];
        
        NSMutableArray *subArray=nil;
            for (int i=0; i<array.count; i++) {
                 WallPaperModel *model=[[WallPaperModel alloc]initWithDictionary:array[i] error:nil];
                if (i%3==0) {
                    subArray=[NSMutableArray arrayWithObject:model];
                    
                }else{
                
                    [subArray addObject:model];
                }
                if (i%3==2||i==array.count-1) {
                    [self.dataArray addObject:subArray];
                }
            }
        
        [self endRefresh];
    } failed:^(NSError *error) {
        [self endRefresh];
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
