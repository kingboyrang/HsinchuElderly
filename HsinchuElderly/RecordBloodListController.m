//
//  RecordBloodListController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "RecordBloodListController.h"
#import "UIBarButtonItem+TPCategory.h"
#import "RecordBloodController.h"
#import "RecordBloodSugarController.h"
#import "TKRecordCell.h"
#import "AlertHelper.h"
@interface RecordBloodListController ()
- (void)switchLoadSource;
- (void)buttonPicClick:(UIButton*)btn;
- (void)buttonRecordClick:(UIButton*)btn;
- (void)buttonEditClick:(UIButton*)btn;
- (void)buttonDeleteClick:(UIButton*)btn;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@implementation RecordBloodListController

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
    self.bloodHelper=[[RecordBloodHelper alloc] init];
    self.bloodSugarHelper=[[RecordBloodSugarHelper alloc] init];
    
    //状态栏右上角内容
    UIBarButtonItem *btn1=[UIBarButtonItem barButtonWithTitle:@"圖表" target:self action:@selector(buttonPicClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn2=[UIBarButtonItem barButtonWithTitle:@"記錄" target:self action:@selector(buttonRecordClick:) forControlEvents:UIControlEventTouchUpInside];
    NSArray *actionButtonItems = [NSArray arrayWithObjects:btn2,btn1, nil];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    
    //顶部
    self.topView=[[RecordTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    self.topView.delegate=self;
    [self.view addSubview:self.topView];
    
    //标题
    self.labTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, self.topView.frame.size.height, self.view.bounds.size.width,44)];
    self.labTitle.backgroundColor=[UIColor clearColor];
    self.labTitle.textColor=[UIColor blackColor];
    self.labTitle.textAlignment=NSTextAlignmentCenter;
    self.labTitle.text=@"血壓記錄列表";
    self.labTitle.font=defaultBDeviceFont;
    [self.view addSubview:self.labTitle];
    
    //资料显示table
    CGRect r=self.view.bounds;
    r.origin.y=self.labTitle.frame.origin.y+self.labTitle.frame.size.height;
    r.size.height-=[self topHeight]+r.origin.y;
   
    
    _recordTable=[[UITableView alloc] initWithFrame:r style:UITableViewStylePlain];
    _recordTable.dataSource=self;
    _recordTable.delegate=self;
    _recordTable.backgroundColor=[UIColor clearColor];
    _recordTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    _recordTable.bounces=NO;
    _recordTable.hidden=YES;
    [self.view addSubview:_recordTable];
    
    _userTable=[[UITableView alloc] initWithFrame:r style:UITableViewStylePlain];
    _userTable.dataSource=self;
    _userTable.delegate=self;
    _userTable.backgroundColor=[UIColor clearColor];
    _userTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    _userTable.bounces=NO;
    [self.view addSubview:_userTable];
   
    
}
//初始化加载
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self switchLoadSource];
}
//根据选中不同的对象加载资料
- (void)switchLoadSource{
    if (self.topView.selectedIndex==1) {//血壓
        if (self.list&&[self.list count]>0) {
            [self.list removeAllObjects];
        }
        self.recordTable.hidden=YES;
        self.userTable.hidden=NO;
        [self.view bringSubviewToFront:self.userTable];
        self.list=[self.bloodHelper findByUser:self.userId];
        [self.userTable reloadData];
    }else{//血糖
        if (self.recordlist&&[self.recordlist count]>0) {
            [self.recordlist removeAllObjects];
        }
        self.recordTable.hidden=NO;
        self.userTable.hidden=YES;
        [self.view bringSubviewToFront:self.recordTable];
        self.recordlist=[self.bloodSugarHelper findByUser:self.userId];
        [self.recordTable reloadData];
    }
}
//圖表
- (void)buttonPicClick:(UIButton*)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
//记录
- (void)buttonRecordClick:(UIButton*)btn{
    if (self.topView.bloodButton.selected) {
        RecordBloodController *record=[[RecordBloodController alloc] init];
        record.operType=1;
        record.userId=self.userId;
        [self.navigationController pushViewController:record animated:YES];
    }else{
        RecordBloodSugarController *recordSugar=[[RecordBloodSugarController alloc] init];
        recordSugar.operType=1;
        recordSugar.userId=self.userId;
        [self.navigationController pushViewController:recordSugar animated:YES];
    }
}
//修改
- (void)buttonEditClick:(UIButton*)btn{
    id v=[btn superview];
    while (![v isKindOfClass:[UITableViewCell class]]) {
        v=[v superview];
    }
    UITableViewCell *cell=(UITableViewCell*)v;
    NSIndexPath *indexPath=[self.userTable indexPathForCell:cell];
    if (self.topView.bloodButton.selected) {
        RecordBloodController *record=[[RecordBloodController alloc] init];
        record.operType=2;
        record.userId=self.userId;
        record.Entity=self.list[indexPath.row];
        [self.navigationController pushViewController:record animated:YES];
    }else{
        RecordBloodSugarController *recordSugar=[[RecordBloodSugarController alloc] init];
        recordSugar.operType=2;
        recordSugar.userId=self.userId;
        recordSugar.Entity=self.list[indexPath.row];
        [self.navigationController pushViewController:recordSugar animated:YES];
    }

}
//删除
- (void)buttonDeleteClick:(UIButton*)btn{
    id v=[btn superview];
    while (![v isKindOfClass:[UITableViewCell class]]) {
        v=[v superview];
    }
    UITableViewCell *cell=(UITableViewCell*)v;
    NSIndexPath *indexPath=[self.userTable indexPathForCell:cell];
    
    [AlertHelper initWithTitle:@"提示" message:@"確定是否刪除?" cancelTitle:@"取消" cancelAction:nil confirmTitle:@"確認" confirmAction:^{
        BOOL boo;
        if (self.topView.bloodButton.selected) {//血壓
            RecordBlood *entity=self.list[indexPath.row];
            boo=[self.bloodHelper deleteWithGuid:entity.ID];
        }else{//血糖
            RecordBloodSugar *entity=self.list[indexPath.row];
            boo=[self.bloodSugarHelper deleteWithGuid:entity.ID];
        }
        if (boo&&self.topView.selectedIndex==1) {
            [self.list removeObjectAtIndex:indexPath.row];
            [self.userTable beginUpdates];
            [self.userTable deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
            [self.userTable endUpdates];
        }
        if (boo&&self.topView.selectedIndex==2) {
            [self.recordlist removeObjectAtIndex:indexPath.row];
            [self.recordTable beginUpdates];
            [self.recordTable deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
            [self.recordTable endUpdates];
        }
        [AlertHelper showMessage:[NSString stringWithFormat:@"刪除%@!",boo?@"成功":@"失敗"]];
    }];
}
#pragma mark - RecordTopViewDelegate Methods
- (void)selectedButton:(UIButton*)btn type:(NSInteger)type{
    NSString *msg=type==1?@"血壓記錄列表":@"血糖記錄列表";
    self.labTitle.text=msg;
    
    [self switchLoadSource];
}
#pragma mark UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.userTable==tableView) {
        return [self.list count];
    }
    return [self.recordlist count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (self.recordTable==tableView) {
        static  NSString *cellIdentifier=@"recordSugarCell";
        TKRecordCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell==nil) {
            cell=[[TKRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            [cell.deleteButton addTarget:self action:@selector(buttonDeleteClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.editButton addTarget:self action:@selector(buttonEditClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        RecordBloodSugar *mod=self.recordlist[indexPath.row];
        cell.drugName.text=mod.SugarDetail;
        cell.timeText.text=mod.TimeSpanText;
        return cell;
    }
    static  NSString *cellIdentifier=@"recordCell";
    TKRecordCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[TKRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell.deleteButton addTarget:self action:@selector(buttonDeleteClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.editButton addTarget:self action:@selector(buttonEditClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    RecordBlood *entity=self.list[indexPath.row];
    cell.drugName.text=entity.BloodDetail;
    cell.timeText.text=entity.TimeSpanText;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.topView.selectedIndex==1) {
        RecordBlood *entity=self.list[indexPath.row];
        return [self getCellHeightWithTitle:entity.BloodDetail detailText:entity.TimeSpanText];
    }
    RecordBloodSugar *mod=self.recordlist[indexPath.row];
    return [self getCellHeightWithTitle:mod.SugarDetail detailText:mod.TimeSpanText];
}
//计算cell高度
- (CGFloat)getCellHeightWithTitle:(NSString*)title detailText:(NSString*)detail{
    CGFloat leftX=10,topY=10,total=0;
    CGFloat w=self.view.bounds.size.width-leftX-20-5-2;
    CGSize size=[title textSize:[UIFont fontWithName:defaultDeviceFontName size:18] withWidth:w];
    total+=topY+size.height+5;
    
    
    size=[detail textSize:[UIFont fontWithName:defaultDeviceFontName size:18] withWidth:w];
    total+=size.height+topY;
    
    return total>95.0f?total:95.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
