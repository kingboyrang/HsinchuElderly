//
//  RecordViewController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/6/13.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "RecordViewController.h"
#import "UIBarButtonItem+TPCategory.h"
#import "RecordBloodController.h"
#import "RecordBloodSugarController.h"
#import "RecordBloodListController.h"
#import "TKChartRecordCell.h"
#import "ChartView.h"
@interface RecordViewController ()<RecordTopViewDelegate>
- (void)switchLoadSource;
@end

@implementation RecordViewController

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
    UIBarButtonItem *btn1=[UIBarButtonItem barButtonWithTitle:@"列表" target:self action:@selector(buttonListClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn2=[UIBarButtonItem barButtonWithTitle:@"記錄" target:self action:@selector(buttonRecordClick:) forControlEvents:UIControlEventTouchUpInside];
    NSArray *actionButtonItems = [NSArray arrayWithObjects:btn2,btn1, nil];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
   //表头
    self.topView=[[RecordTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    self.topView.delegate=self;
    [self.view addSubview:self.topView];
    
  
    //图表内容
    CGRect r=self.view.bounds;
    r.origin.y=self.topView.frame.size.height;
    r.size.height-=[self topHeight]+r.origin.y;
    
    _chartTable=[[UITableView alloc] initWithFrame:r style:UITableViewStylePlain];
    _chartTable.dataSource=self;
    _chartTable.delegate=self;
    _chartTable.backgroundColor=[UIColor clearColor];
    _chartTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    _chartTable.bounces=NO;
    [self.view addSubview:_chartTable];
    
}
//视图将出现时加载不同的图表资料
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self switchLoadSource];
}
//切换显示不同的图表
- (void)switchLoadSource{
    if (self.cells&&[self.cells count]>0) {
        [self.cells removeAllObjects];
        [self.chartTable reloadData];
    }
    if (self.topView.selectedIndex==1) {//血压记录
        if (self.bloodList&&[self.bloodList count]>0) {
            [self.bloodList removeAllObjects];
        }
        self.bloodList=[self.bloodHelper findByUser:self.userId];
        //加载图表
        [self loadBloodChart];
    }else{//血糖记录
        if (self.sugarList&&[self.sugarList count]>0) {
            [self.sugarList removeAllObjects];
        }
        self.sugarList=[self.bloodSugarHelper findByUser:self.userId];
        [self loadBloodSugarChart];
    }
}
//血压记录图表加载
- (void)loadBloodChart{
    if (!self.cellHeights) {
        self.cellHeights=[NSMutableArray array];
    }
    if (self.cells&&[self.cells count]>0) {
        [self.cells removeAllObjects];
    }
    if (self.cellHeights&&[self.cellHeights count]>0) {
        [self.cellHeights removeAllObjects];
    }
    //表示有值
    if (self.bloodList&&[self.bloodList count]>0) {
        NSMutableArray *results=[NSMutableArray array];
        //舒张压与收缩压
        //舒张压
        NSMutableArray  *diastoles=[self.bloodHelper charDiastolesWithSource:self.bloodList];
        //收缩压
        NSMutableArray  *shrinks=[self.bloodHelper charShrinksWithSource:self.bloodList];
        if ([diastoles count]>0||[shrinks count]>0) {
            TKChartRecordCell *cell1=[[TKChartRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell1.labTitle.text=@"血壓折線圖";
            [cell1.chart drawChartWithSource:diastoles otherSource:shrinks];
            [results addObject:cell1];
            [self.cellHeights addObject:[NSNumber numberWithFloat:270+80]];
            
        }
        //脉搏
        NSMutableArray *pulues=[self.bloodHelper charPulsesWithSource:self.bloodList];
        if ([pulues count]>0) {
            TKChartRecordCell *cell1=[[TKChartRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell1.labTitle.text=@"脈搏折線圖";
            [cell1.chart drawChartWithSource:pulues chartHeight:240 lineColor:nil];
            [results addObject:cell1];
            [self.cellHeights addObject:[NSNumber numberWithFloat:240+80]];
        }
        self.cells=results;
    }
    [self.chartTable reloadData];
}
//血糖记录图表加载
- (void)loadBloodSugarChart{
    if (!self.cellHeights) {
        self.cellHeights=[NSMutableArray array];
    }
    if (self.cells&&[self.cells count]>0) {
        [self.cells removeAllObjects];
    }
    if (self.cellHeights&&[self.cellHeights count]>0) {
        [self.cellHeights removeAllObjects];
    }
    //表示有值
    if (self.sugarList&&[self.sugarList count]>0) {
        NSMutableArray *results=[NSMutableArray array];
        //飯前血糖
         NSMutableArray *beforeMelas=[self.bloodSugarHelper beforeMealsWithSource:self.sugarList];
        if ([beforeMelas count]>0) {
            TKChartRecordCell *cell1=[[TKChartRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell1.labTitle.text=@"飯前血糖折線圖";
            cell1.chart.rate=270.0f/999.0f;
            [cell1.chart drawChartWithSource:beforeMelas];
            [results addObject:cell1];
            [self.cellHeights addObject:[NSNumber numberWithFloat:270+80]];
        }
        //飯後血糖
        NSMutableArray *afterMelas=[self.bloodSugarHelper afterMealsWithSource:self.sugarList];
        if ([afterMelas count]>0) {
            TKChartRecordCell *cell1=[[TKChartRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell1.labTitle.text=@"飯後血糖折線圖";
            cell1.chart.rate=270.0f/999.0f;
            [cell1.chart drawChartWithSource:afterMelas];
            [results addObject:cell1];
            [self.cellHeights addObject:[NSNumber numberWithFloat:270+80]];
        }
        self.cells=results;
    }
    [self.chartTable reloadData];
}
//列表
- (void)buttonListClick:(UIButton*)btn{
    RecordBloodListController *recordList=[[RecordBloodListController alloc] init];
    recordList.userId=self.userId;
    [self.navigationController pushViewController:recordList animated:YES];
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
#pragma mark - RecordTopViewDelegate Methods
- (void)selectedButton:(UIButton*)btn type:(NSInteger)type{
    [self switchLoadSource];
}
#pragma mark UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
       return [self.cells count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=self.cells[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber *num=self.cellHeights[indexPath.row];
    return [num floatValue];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
