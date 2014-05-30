//
//  HEWelfareViewController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "HEWelfareViewController.h"
#import "HEWelfareHelper.h"
#import "TKWelfareCell.h"
#import "HEWelfareSearchController.h"
@interface HEWelfareViewController ()

@end

@implementation HEWelfareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"福利";
    CGRect r=self.view.bounds;
    r.size.height-=[self topHeight];
    _refreshTable=[[UITableView alloc] initWithFrame:r style:UITableViewStylePlain];
    _refreshTable.dataSource=self;
    _refreshTable.delegate=self;
    _refreshTable.backgroundColor=[UIColor clearColor];
    _refreshTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_refreshTable];
    
    HEWelfareHelper *helper=[[HEWelfareHelper alloc] init];
    self.list=[helper categorys];
    if (self.list&&[self.list count]>0) {
        [self.list removeObjectAtIndex:0];
    }
    [_refreshTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"medicalCareCell";
    TKWelfareCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[TKWelfareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary *dic=self.list[indexPath.row];
    cell.labName.text=[dic objectForKey:@"Name"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *entity=self.list[indexPath.row];
    CGFloat leftX=10;
    CGFloat w=self.view.bounds.size.width-leftX-20-5-2;
    CGSize size=[[entity objectForKey:@"Name"] textSize:[UIFont fontWithName:defaultDeviceFontName size:18] withWidth:w];
  
    if (size.height+20.0f>60.0f) {
        return size.height+20.0f;
    }
    return 60.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     NSDictionary *dic=self.list[indexPath.row];
    HEWelfareSearchController *welfare=[[HEWelfareSearchController alloc] init];
    welfare.title=self.title;
    welfare.categoryGuid=[dic objectForKey:@"ID"];
    welfare.categoryName=[dic objectForKey:@"Name"];
    [self.navigationController pushViewController:welfare animated:YES];
}
@end
