//
//  MoreViewController.m
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/10.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreCell.h"
#import "MoreModel.h"
#import "NBTableSectionHeaderView.h"
#import "NBMore.h"
#import "MoreDetailViewController.h"
#import "MBProgressHUD+NBExtensions.h"
#import <MessageUI/MessageUI.h>
#import "MoreStorageViewController.h"
#import "UIImageView+WebCache.h"
#import "NBCacheManager.h"
@interface MoreViewController ()<MFMailComposeViewControllerDelegate>

@property (nonatomic, copy) NSArray *sections;

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self parserPlist];
    [self cancelRefreshView];
    [self createTableHeader];
    
}
-(void)createTableHeader{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    UIImageView *imageView=[NBControl createImageViewWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-10-10, 80) tag:0 image:@"logo_empty" cornerRadius:0];
    [view addSubview:imageView];
    self.tableView.tableHeaderView=view;
}
- (void)parserPlist {
    NBMore *more=[NBMore sharedManager];
    [self.dataArray setArray:more.allRowsName];
    self.sections = more.allSectionsName;
}

- (void)registerCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"MoreCell" bundle:nil] forCellReuseIdentifier:@"moreCell"];
}

#pragma mark - 这个页面比较特殊，重写协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell" forIndexPath:indexPath];
    NSArray *array = self.dataArray[indexPath.section];
    cell.title.text = array[indexPath.row];
    cell.detail.text=[[NBMore sharedManager]detailTitleWithRowTitle:array[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *title=self.dataArray[indexPath.section][indexPath.row];
    NBMore *manager=[NBMore sharedManager];
    NSDictionary *dict=[[NBMore sharedManager] dictionaryWithRowTitle:title];
    MoreType type=[manager moreTypeWithDictionary:dict];
    switch (type) {
        case MTViewController:{
            
            if ([[manager viewControllerWithDictionary:dict] isEqualToString:@"MoreStorageViewController"]) {
                
                MoreStorageViewController *vc=[[MoreStorageViewController alloc]init];
                vc.navigationItemStringTitle=@"我的收藏列表";
                [self.navigationController pushViewController:vc animated:YES];
                
                
            }else{
            
                Class cls=NSClassFromString([manager viewControllerWithDictionary:dict]);
                ParentViewController *vc=[[cls alloc]init];
                vc.urlFormat=[manager urlWithDictionary:dict];
                vc.navigationItemStringTitle=title;
                [self.navigationController pushViewController:vc animated:YES];
            
            }
            
        }
            //NSLog(@"推出控制器");
            break;
        case MTConnectURL:{
            NSString *url=[manager urlWithDictionary:dict];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            
            
        }
            
            break;
        case MTClearCache:
        {
            //清空自己的缓存
            [[NBCacheManager sharedManager] clearAllCache];
            //清空SDWebImage的缓存
            [[SDImageCache sharedImageCache] cleanDisk];
            //nsurl相关缓存
            [[NSURLCache sharedURLCache] removeAllCachedResponses];
            
            NSString *info=[manager infoViewWithDictionary:dict];
            [MBProgressHUD showSuccess:info duration:2 toView:self.view image:@"smile"
             ];
            
        
            
            
        }
            NSLog(@"清空缓存");
            break;
        case MTMail:{
            if ([MFMailComposeViewController canSendMail ]) {
                MFMailComposeViewController *mailComposeViewController=[[MFMailComposeViewController alloc]init];
                NSString *mail=[manager mailWithDictionary:dict];
                [mailComposeViewController setToRecipients:@[mail]];
                mailComposeViewController.mailComposeDelegate=self;
                [self presentViewController:mailComposeViewController animated:YES completion:nil];
                
            }
        }
           
            break;
        case MTNothing:
            NSLog(@"什么都不做");
            break;
        case MTShowHUD:{
            
            NSString *title=[manager infoViewWithDictionary:dict];
            [MBProgressHUD showSuccess:title duration:2 toView:self.view image:@"smile"];
            
        
        }
           
            break;

            
      
    }
    
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
