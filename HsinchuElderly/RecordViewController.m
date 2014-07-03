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
   
    self.recordType=@"1";
    
    //状态栏右上角内容
    UIBarButtonItem *btn1=[UIBarButtonItem barButtonWithTitle:@"列表" target:self action:@selector(buttonListClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn2=[UIBarButtonItem barButtonWithTitle:@"記錄" target:self action:@selector(buttonRecordClick:) forControlEvents:UIControlEventTouchUpInside];
    NSArray *actionButtonItems = [NSArray arrayWithObjects:btn2,btn1, nil];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    
    
    //self.title=@"記錄";
    self.topView=[[RecordTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    self.topView.delegate=self;
    [self.view addSubview:self.topView];
    
  
    
    CGRect r=self.view.bounds;
    r.origin.y=50;
    r.origin.x=10;
    r.size.width-=r.origin.x*2;
    r.size.height-=[self topHeight]+r.origin.y;
    
    PolygonalScrollView *scrollView=[[PolygonalScrollView alloc] initWithFrame:r];
    [self.view addSubview:scrollView];
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
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
