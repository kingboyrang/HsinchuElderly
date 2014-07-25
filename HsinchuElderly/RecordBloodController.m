//
//  RecordBloodController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "RecordBloodController.h"
#import "UIBarButtonItem+TPCategory.h"
#import "AlertHelper.h"
#import "TkRecordShrinkCell.h"
#import "TkTimeViewCell.h"
#import "TKRecordCalendarCell.h"
#import "TKCalendarTimeCell.h"
#import "RollTooBar.h"
#import "TKLabelCell.h"
#import "TKCalendarFieldCell.h"
#import "NSDate+TPCategory.h"
@interface RecordBloodController ()

@end

@implementation RecordBloodController

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
    
    self.title=@"血壓記錄";
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
    
   
    
    
    TkRecordShrinkCell *cell1=[[TkRecordShrinkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    //TKCalendarTimeCell *cell2=[[TKCalendarTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    TkTimeViewCell *cell2=[[TkTimeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    TKRecordCalendarCell *cell3=[[TKRecordCalendarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
  
    
    
    TKLabelCell *cell5=[[TKLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell5.label.text=@"時間";
    cell5.label.textAlignment=NSTextAlignmentCenter;
    
    TKCalendarFieldCell *cell6=[[TKCalendarFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell6.calendar.popText.field.placeholder=@"請選擇時間";
    cell6.calendar.datePicker.datePickerMode=UIDatePickerModeTime;
    [cell6.calendar.dateForFormat setDateFormat:@"HH:mm"];
    if (self.operType==2) {
         cell6.calendar.popText.field.text=self.Entity.TimeSpan;
    }else{
        cell6.calendar.popText.field.text=[cell6.calendar calendarValue];
    }
    
    TKLabelCell *cell7=[[TKLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell7.label.text=@"日期";
    cell7.label.textAlignment=NSTextAlignmentCenter;
    
    TKCalendarFieldCell *cell8=[[TKCalendarFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell8.calendar.popText.field.placeholder=@"請選擇日期";
    if (self.operType==2) {
        cell8.calendar.popText.field.text=self.Entity.RecordDate;
    }else{
        cell8.calendar.popText.field.text=[NSDate stringFromDate:[NSDate date] withFormat:@"yyyy-MM-dd"];
    }
    if (DeviceIsPad) {
         self.cells=[NSMutableArray arrayWithObjects:cell1,cell2,cell3, nil];
    }else{
        self.cells=[NSMutableArray arrayWithObjects:cell1,cell5,cell6,cell7,cell8, nil];
    }
    if (self.operType==2) {//修改
        [cell1.shrinkView setSelectedValue:self.Entity.Diastolic component:0];
        [cell1.shrinkView setSelectedValue:self.Entity.Shrink component:1];
        [cell1.shrinkView setSelectedValue:self.Entity.Pulse component:2];
        if (DeviceIsPad) {
            [cell2.timeView setSelectedValue:self.Entity.TimeSpan];
            [cell3.calendarView setSelectedValue:self.Entity.RecordDate];
        }
    }else{
        self.Entity=[[RecordBlood alloc] init];
    }
}

//完成
- (void)buttonFinishedClick:(UIButton*)btn{
    TkRecordShrinkCell *cell1=self.cells[0];
    if (DeviceIsPad) {
        TkTimeViewCell *cell2=self.cells[1];
        TKRecordCalendarCell *cell3=self.cells[2];
        
        self.Entity.TimeSpan=cell2.timeView.timeValue;
        self.Entity.RecordDate=cell3.calendarView.calendarValue;
    }else{
        TKCalendarFieldCell *cell2=self.cells[2];
        TKCalendarFieldCell *cell3=self.cells[4];
        
        if ([cell2.calendar.popText.field.text length]==0) {
            [AlertHelper initWithTitle:@"提示" message:@"請選擇時間!"];
            return;
        }
        if ([cell3.calendar.popText.field.text length]==0) {
            [AlertHelper initWithTitle:@"提示" message:@"請選擇日期!"];
            return;
        }
        self.Entity.TimeSpan=cell2.calendar.popText.field.text;
        self.Entity.RecordDate=cell3.calendar.popText.field.text;
    }
   
    
    self.Entity.UserId=self.userId;
    self.Entity.Shrink=cell1.shrinkView.shrinkValue;
    self.Entity.Diastolic=cell1.shrinkView.diastolicValue;
    self.Entity.Pulse=cell1.shrinkView.pulseValue;
   
    BOOL boo;
    NSString *memo=@"新增";
    if (self.operType==1) {
        boo=[self.bloodHelper addRecord:self.Entity];
    }else{
        memo=@"修改";
        boo=[self.bloodHelper editRecord:self.Entity];
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
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.cells[indexPath.row] isKindOfClass:[TkRecordShrinkCell class]]) {
        return 202;
    }
    if (DeviceIsPad) {
        if ([self.cells[indexPath.row] isKindOfClass:[TkTimeViewCell class]]) {
            return 195;
        }
        return 200;
    }
    return 44.0f;
}
@end
