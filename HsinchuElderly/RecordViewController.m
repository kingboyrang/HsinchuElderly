//
//  RecordViewController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/6/13.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "RecordViewController.h"
#import "UIBarButtonItem+TPCategory.h"
#import "PolygonalScrollView.h"
#import "RecordBloodController.h"
#import "RecordBloodSugarController.h"
#import "RecordBloodListController.h"
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
    r.origin.y=50;
    r.origin.x=10;
    r.size.width-=r.origin.x*2;
    r.size.height-=[self topHeight]+r.origin.y;
    
    PolygonalScrollView *scrollView=[[PolygonalScrollView alloc] initWithFrame:r];
    [self.view addSubview:scrollView];
}
//视图将出现时加载不同的图表资料
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self switchLoadSource];
}
//切换显示不同的图表
- (void)switchLoadSource{
    if (self.topView.selectedIndex==1) {//血压记录
        if (self.bloodList&&[self.bloodList count]>0) {
            [self.bloodList removeAllObjects];
        }
        self.bloodList=[self.bloodHelper findByUser:self.userId];
        
    }else{//血糖记录
        if (self.sugarList&&[self.sugarList count]>0) {
            [self.sugarList removeAllObjects];
        }
        self.sugarList=[self.bloodSugarHelper findByUser:self.userId];
    }
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
