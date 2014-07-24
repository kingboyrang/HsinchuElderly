//
//  RecordBloodSugarController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "RecordBloodSugarController.h"
#import "UIBarButtonItem+TPCategory.h"
#import "AlertHelper.h"
#import "TKRecordBloodSugarCell.h"
#import "TkTimeViewCell.h"
#import "TKRecordCalendarCell.h"
#import "RollTooBar.h"
@interface RecordBloodSugarController ()

@end

@implementation RecordBloodSugarController

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
    self.bloodSugarHelper=[[RecordBloodSugarHelper alloc] init];
    self.title=@"血糖記錄";
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonWithTitle:@"完成" target:self action:@selector(buttonFinishedClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect r=self.view.bounds;
    r.size.height-=[self topHeight];
    _bloodTable=[[UITableView alloc] initWithFrame:r style:UITableViewStylePlain];
    _bloodTable.dataSource=self;
    _bloodTable.delegate=self;
    _bloodTable.backgroundColor=[UIColor clearColor];
    _bloodTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    _bloodTable.bounces=NO;
    [self.view addSubview:_bloodTable];
    
    if (!DeviceIsPad) {//如果为iphone
        
        RollTooBar *roll=[[RollTooBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [roll.btnDown addTarget:self action:@selector(buttonRollDownClick) forControlEvents:UIControlEventTouchUpInside];
        [roll.btnUp addTarget:self action:@selector(buttonRollUpClick) forControlEvents:UIControlEventTouchUpInside];
        CGRect rect=roll.frame;
        rect.origin.x=self.view.bounds.size.width-rect.size.width-5;
        rect.origin.y=self.view.bounds.size.height-[self topHeight]-rect.size.height-15;
        roll.frame=rect;
        [self.view addSubview:roll];
        
    }
    
    
    TKRecordBloodSugarCell *cell1=[[TKRecordBloodSugarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    TkTimeViewCell *cell2=[[TkTimeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    TKRecordCalendarCell *cell3=[[TKRecordCalendarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    self.cells=[NSMutableArray arrayWithObjects:cell1,cell2,cell3, nil];
    

    if (self.operType==2) {//修改
        NSLog(@"BloodSugar=%@",self.Entity.BloodSugar);
        [cell1.sugarView setSelectedValue:self.Entity.Measure];
        cell1.sugarView.sugarField.text=self.Entity.BloodSugar;
        [cell2.timeView setSelectedValue:self.Entity.TimeSpan];
        [cell3.calendarView setSelectedValue:self.Entity.RecordDate];
    }else{
        self.Entity=[[RecordBloodSugar alloc] init];
        
    }
}
- (void)buttonRollDownClick{
    NSIndexPath *indxPath= [NSIndexPath indexPathForRow:self.cells.count-1 inSection:0];
    [_bloodTable scrollToRowAtIndexPath:indxPath atScrollPosition:UITableViewScrollPositionBottom  animated:YES];
}
- (void)buttonRollUpClick{
    [_bloodTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
//完成
- (void)buttonFinishedClick:(UIButton*)btn{
    TKRecordBloodSugarCell *cell1=self.cells[0];
    TkTimeViewCell *cell2=self.cells[1];
    TKRecordCalendarCell *cell3=self.cells[2];
    
    if (!cell1.sugarView.hasValue) {
        [AlertHelper showMessage:@"請輸入血糖值!"];
        return;
    }
    if (![cell1.sugarView.sugarField.text isNumberString]) {
        [AlertHelper showMessage:@"血糖值只能為0～999之間的數字!"];
        return;
    }
    self.Entity.UserId=self.userId;
    self.Entity.Measure=cell1.sugarView.bloodValue;
    self.Entity.BloodSugar=cell1.sugarView.sugarField.text;
    self.Entity.TimeSpan=cell2.timeView.timeValue;
    self.Entity.RecordDate=cell3.calendarView.calendarValue;
    BOOL boo;
    NSString *memo=@"新增";
    if (self.operType==1) {
        boo=[self.bloodSugarHelper addRecord:self.Entity];
    }else{
        memo=@"修改";
        boo=[self.bloodSugarHelper editRecord:self.Entity];
    }
    NSString *msg=[NSString stringWithFormat:@"%@血壓記錄%@",memo,boo?@"成功":@"失敗"];
    [AlertHelper showMessage:msg confirmAction:^{
        if (boo) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if ([self.cells[indexPath.row] isKindOfClass:[TKRecordBloodSugarCell class]]) {
        return DeviceIsPad?256:202;
    }
    if ([self.cells[indexPath.row] isKindOfClass:[TkTimeViewCell class]]) {
        return 195;
    }
    return 200;
}

@end
