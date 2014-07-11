//
//  BloodModifyController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "BloodModifyController.h"
#import "UIBarButtonItem+TPCategory.h"
#import "AlertHelper.h"
#import "NSDate+TPCategory.h"
#import "BloodHelper.h"
#import "TKLabelCell.h"
#import "TKCalendarFieldCell.h"
#import "TKSelectFieldCell.h"
@interface BloodModifyController ()

@end

@implementation BloodModifyController

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
    
    UIImage *img=[UIImage imageNamed:@"logo2"];
    CGFloat topY=self.view.bounds.size.height-[self topHeight]-img.size.height-10;
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-img.size.width)/2, topY, img.size.width, img.size.height)];
    [imageView setImage:img];
    [self.view addSubview:imageView];
    
    self.title=@"血壓測量";
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonWithTitle:@"儲存" target:self action:@selector(buttonSubmitClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect r=self.view.bounds;
    r.size.height-=[self topHeight];
    _userTable=[[UITableView alloc] initWithFrame:r style:UITableViewStylePlain];
    _userTable.dataSource=self;
    _userTable.delegate=self;
    _userTable.backgroundColor=[UIColor clearColor];
    _userTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    _userTable.bounces=NO;
    [self.view addSubview:_userTable];
    
    TKLabelCell *cell1=[[TKLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell1.label.text=@"提醒對象";
    
    TKSelectFieldCell *cell2=[[TKSelectFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell2.select.popText.field.placeholder=@"請選擇名字";
    if (self.systemUsers&&[self.systemUsers count]>0) {
        [cell2.select setDataSourceForArray:self.systemUsers dataTextName:@"Name" dataValueName:@"ID"];
    }
    if (self.operType==1) {//新增
        [cell2.select setIndex:0];
    }
    

    TKLabelCell *cell3=[[TKLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell3.label.text=@"頻率";
    
    TKRateViewCell *cell4=[[TKRateViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell4.select.delegate=self;
    cell4.select.popText.field.placeholder=@"請選擇頻率";
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Frequency" ofType:@"plist"];
    [cell4.select setDataSourceForArray:[NSArray arrayWithContentsOfFile:path] dataTextName:@"Name" dataValueName:@"ID"];
    
    TKLabelCell *cell5=[[TKLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell5.label.text=@"時間1";
    
    TKCalendarFieldCell *cell6=[[TKCalendarFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell6.calendar.popText.field.placeholder=@"請選擇時間1";
    cell6.calendar.datePicker.datePickerMode=UIDatePickerModeTime;
    [cell6.calendar.dateForFormat setDateFormat:@"HH:mm"];
    
    if (self.operType==2) {
        [cell2.select setSelectedValue:self.Entity.UserId];
        [cell4.select setSelectedValue:self.Entity.Rate component:0];
        [cell4.select setSelectedValue:[NSString stringWithFormat:@"%d",self.Entity.RateCount] component:1];
    }
    if (self.operType==1) {//新增
         self.cells=[NSMutableArray arrayWithObjects:cell1,cell2,cell3,cell4,cell5,cell6, nil];
    }else{//修改
        NSArray *tiems=[self.Entity.TimeSpan componentsSeparatedByString:@";"];
        self.cells=[NSMutableArray arrayWithObjects:cell1,cell2,cell3,cell4, nil];
        for (NSInteger i=0; i<tiems.count; i++) {
            TKLabelCell *labcell=[[TKLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            labcell.label.text=[NSString stringWithFormat:@"時間%d",i+1];
            [self.cells addObject:labcell];
            
            
            TKCalendarFieldCell *calendarCell=[[TKCalendarFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            calendarCell.calendar.popText.field.placeholder=[NSString stringWithFormat:@"請選擇時間%d",i+1];;
            calendarCell.calendar.datePicker.datePickerMode=UIDatePickerModeTime;
            [calendarCell.calendar.dateForFormat setDateFormat:@"HH:mm"];
            calendarCell.calendar.popText.field.text=tiems[i];
            [self.cells addObject:calendarCell];
        }
    }
   
    [_userTable reloadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//完成
- (void)buttonSubmitClick:(UIButton*)btn{
    TKSelectFieldCell *cell1=self.cells[1];
    if ([cell1.select.value length]==0) {
        [AlertHelper initWithTitle:@"提示" message:@"請選擇名字"];
        return;
    }
    
    TKRateViewCell *cell2=self.cells[3];
    if ([cell2.select.value length]==0) {
        [AlertHelper initWithTitle:@"提示" message:@"請選擇頻率"];
        return;
    }
    BOOL boo=YES;
    NSInteger start=1;
    for (NSInteger i=5; i<self.cells.count; i++) {
        if (i%2==0) continue;
        TKCalendarFieldCell *canlendarCell=self.cells[i];
        if ([canlendarCell.calendar.popText.field.text length]==0) {
            boo=NO;
            [AlertHelper initWithTitle:@"提示" message:[NSString stringWithFormat:@"請選擇時間%d",start]];
            break;
        }
        start+=1;
    }
    if (!boo) {
        return;
    }
    
    if (self.operType==1) {
        self.Entity=[[Blood alloc] init];
        self.Entity.ID=[NSString createGUID];
        self.Entity.CreateDate=[NSDate stringFromDate:[NSDate date] withFormat:@"yyyy/MM/dd HH:mm:ss"];
    }
    self.Entity.UserId=cell1.select.value;
    self.Entity.UserName=cell1.select.key;
    self.Entity.Rate=cell2.select.value;
    self.Entity.RateCount=cell2.select.rateCount;
    
    NSMutableArray *times=[NSMutableArray array];
    for (NSInteger i=5; i<self.cells.count; i++) {
        if (i%2==0) continue;
        TKCalendarFieldCell *canlendarCell=self.cells[i];
        [times addObject:canlendarCell.calendar.popText.field.text];
    }
    
    self.Entity.TimeSpan=[times componentsJoinedByString:@";"];
    
    BloodHelper *_helper=[[BloodHelper alloc] init];
    //[_helper addEditDrugWithModel:self.Entity name:cell1.select.key];
    [_helper addBloodWithModel:self.Entity name:cell1.select.key];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark CVUISelectDelegate Methods
//关闭
-(void)closeSelect:(id)sender{
    if ([sender isKindOfClass:[CVUIRateView class]]) {
        if (self.cells.count>6) {
            NSMutableArray *indexPaths=[NSMutableArray array];
            for (NSInteger i=6; i<self.cells.count; i++) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
            [self.cells removeObjectsInRange:NSMakeRange(6, self.cells.count-6)];
            [self.userTable beginUpdates];
            [self.userTable deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            [self.userTable endUpdates];
        }
    }
}
-(void)doneChooseItem:(id)sender{
    if ([sender isKindOfClass:[CVUIRateView class]]) {//
        TKRateViewCell *cell=self.cells[3];
        NSInteger total=cell.select.rateCount-1;
        NSInteger len=(self.cells.count-6)/2;
        if (total>len) {//新增
            NSMutableArray *indexPaths=[NSMutableArray array];
            NSInteger val=(self.cells.count-4)/2;
            for (NSInteger i=0;i<total-len;i++) {
                TKLabelCell *cell1=[[TKLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell1.label.text=[NSString stringWithFormat:@"時間%d",val+i+1];
                [self.cells addObject:cell1];
                [indexPaths addObject:[NSIndexPath indexPathForRow:self.cells.count-1 inSection:0]];
                
                TKCalendarFieldCell *cell2=[[TKCalendarFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell2.calendar.popText.field.placeholder=[NSString stringWithFormat:@"請選擇時間%d",val+i+1];
                cell2.calendar.datePicker.datePickerMode=UIDatePickerModeTime;
                [cell2.calendar.dateForFormat setDateFormat:@"HH:mm"];
                [self.cells addObject:cell2];
                [indexPaths addObject:[NSIndexPath indexPathForRow:self.cells.count-1 inSection:0]];
            }
            if (indexPaths.count>0) {
                [self.userTable beginUpdates];
                [self.userTable insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
                [self.userTable endUpdates];
            }
            
        }else{//移除
            NSMutableArray *indexPaths=[NSMutableArray array];
            NSInteger s=self.cells.count-1;
            for (NSInteger i=0; i<len-total; i++) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:s inSection:0]];
                [indexPaths addObject:[NSIndexPath indexPathForRow:s-1 inSection:0]];
                s-=2;
            }
            if (indexPaths.count>0) {
                [self.cells removeObjectsInRange:NSMakeRange(s-1, self.cells.count-s-1)];
                [self.userTable beginUpdates];
                [self.userTable deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
                [self.userTable endUpdates];
            }
        }
    }
}
#pragma mark UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.cells count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=self.cells[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    /**
     if ([self.cells[indexPath.row] isKindOfClass:[TKSelectFieldCell class]]) {
     return 40.0f;
     }
     **/
    return 40.0f;
}
@end
