//
//  BloodSugarViewController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "BloodSugarViewController.h"
#import "BloodSugaModifyController.h"
#import "UIBarButtonItem+TPCategory.h"
#import "AlertHelper.h"
#import "TKDrugCell.h"
#import "AppHelper.h"
@interface BloodSugarViewController ()
- (NSString*)getShowName:(BloodSugar*)entity;
@end

@implementation BloodSugarViewController

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
    self.title=@"血糖測量";
    
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonWithTitle:@"新增" target:self action:@selector(buttonAddClick:) forControlEvents:UIControlEventTouchUpInside];
    self.userHelper=[[BloodSugarHelper alloc] init];
    self.systemUserHelper=[[SystemUserHelper alloc] init];
    [self.systemUserHelper loadDataSource];
    
    CGRect r=self.view.bounds;
    r.size.height-=[self topHeight];
    _userTable=[[UITableView alloc] initWithFrame:r style:UITableViewStylePlain];
    _userTable.dataSource=self;
    _userTable.delegate=self;
    _userTable.backgroundColor=[UIColor clearColor];
    _userTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    _userTable.bounces=NO;
    [self.view addSubview:_userTable];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.userHelper loadDataSource];//重新載入數據
    self.list=[self.userHelper pressureBloodSugars];
    [_userTable reloadData];
}//新增
- (void)buttonAddClick:(UIButton*)btn{
    BloodSugaModifyController *user=[[BloodSugaModifyController alloc] init];
    user.operType=1;
    user.systemUsers=[self.systemUserHelper dictonaryUsers];
    [self.navigationController pushViewController:user animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString*)getShowName:(BloodSugar*)entity{
    SystemUser *mod=[self.systemUserHelper findUserWithId:entity.UserId];
    if (mod) {
        return mod.Name;
    }
    return @"";
}
//删除
- (void)buttonDeleteClick:(UIButton*)btn{
    [AlertHelper initWithTitle:@"提示" message:@"確定刪除？" cancelTitle:@"取消" cancelAction:nil confirmTitle:@"確認" confirmAction:^{
        id v=[btn superview];
        while (![v isKindOfClass:[UITableViewCell class]]) {
            v=[v superview];
        }
        UITableViewCell *cell=(UITableViewCell*)v;
        NSIndexPath *indexPath=[self.userTable indexPathForCell:cell];
        
        BloodSugar *entity=self.list[indexPath.row];
        [AppHelper removeLocationNoticeWithName:entity.ID];
        
        [self.list removeObjectAtIndex:indexPath.row];
        [self.userTable beginUpdates];
        [self.userTable deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
        [self.userTable endUpdates];
        [self.userHelper saveWithSources:self.list];
        [AlertHelper initWithTitle:@"提示" message:@"刪除成功！"];
    }];
}
#pragma mark UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"drugCell";
    TKDrugCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[TKDrugCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell.deleteButton addTarget:self action:@selector(buttonDeleteClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    BloodSugar *entity=self.list[indexPath.row];
    cell.drugName.text=[self getShowName:entity];
    cell.timeText.text=entity.TimeSpan;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BloodSugar *entity=self.list[indexPath.row];
    CGFloat leftX=10,topY=10,total=0;
    CGFloat w=self.view.bounds.size.width-leftX-20-5-2;
    NSString *title=[self getShowName:entity];
    CGSize size=[title textSize:[UIFont fontWithName:defaultDeviceFontName size:18] withWidth:w];
    total+=topY+size.height+5;
    
    
    size=[entity.TimeSpanText textSize:[UIFont fontWithName:defaultDeviceFontName size:14] withWidth:w];
    total+=size.height+topY;
    
    return total>70.0f?total:70.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BloodSugaModifyController *user=[[BloodSugaModifyController alloc] init];
    user.operType=2;
    user.systemUsers=[self.systemUserHelper dictonaryUsers];
    user.Entity=self.list[indexPath.row];
    [self.navigationController pushViewController:user animated:YES];
}

@end
