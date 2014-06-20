//
//  RecordViewController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/6/13.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "RecordViewController.h"
#import "RecordTopView.h"
#import "RecordCalendar.h"
#import "TKRecordCalendarCell.h"
#import "TKRecordDetailCell.h"
#import "NSDate+TPCategory.h"
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
    self.recordHelper=[[RecordRemindHelper alloc] init];
    self.recordType=@"1";
    
    self.title=@"記錄";
    RecordTopView *topView=[[RecordTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    topView.delegate=self;
    [self.view addSubview:topView];
    
    /***
    _recordCalendarView=[[VRGCalendarView alloc] initWithFrame:CGRectMake(0, 50,320, 291)];
    _recordCalendarView.delegate=self;
    [self.view addSubview:_recordCalendarView];
     ***/
    
    CGRect r=self.view.bounds;
    r.origin.y=50;
    r.size.height-=[self topHeight]+r.origin.y;
    _userTable=[[UITableView alloc] initWithFrame:r style:UITableViewStylePlain];
    _userTable.dataSource=self;
    _userTable.delegate=self;
    _userTable.backgroundColor=[UIColor clearColor];
    _userTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    _userTable.bounces=NO;
    [self.view addSubview:_userTable];
    
    TKRecordCalendarCell *cell1=[[TKRecordCalendarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell1.calendarView.delegate=self;
    //cell1.calendarView.currentMonth=[NSDate date];
    self.cells=[NSMutableArray arrayWithObjects:cell1,nil];
    
}
- (void)updateSourceWithDate:(NSString*)str{
    NSArray *arr=[self.recordHelper searchRecordWithType:self.recordType searchDate:str];
    [self.cells removeObjectsInRange:NSMakeRange(1, self.cells.count-1)];
    if (arr&&[arr count]>0) {
        for (RecordRemind *item in arr) {
            TKRecordDetailCell *cell2=[[TKRecordDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            if ([item.Type isEqualToString:@"2"]) {
                [cell2 setTime:item.TimeSpan name:item.Name value1:item.DetailValue1 value2:item.DetailValue2];
            }else{
                [cell2 setTime:item.TimeSpan name:item.Name detail:item.Description];
            }
            [self.cells addObject:cell2];
        }
    }
    [_userTable reloadData];
}
#pragma mark -VRGCalendarViewDelegate Methods
//切换月份处理
-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated{
    NSDate *date=calendarView.currentMonth;
    NSDate *sdate=[date monthFirstDay];
    NSDate *edate=[date monthLastDay];
    NSString *time1=[sdate stringWithFormat:@"yyyy-MM-dd"];
    NSString *time2=[edate stringWithFormat:@"yyyy-MM-dd"];
    NSArray *arr=[self.recordHelper searchRecordWithType:self.recordType startDate:time1 endDate:time2];
    if (arr&&[arr count]>0) {
         [calendarView markDates:arr];
    }else{
         [calendarView markDates:nil];
    }
    
    NSString *time=[self.recordHelper searchMaxDateWithType:self.recordType startDate:time1 endDate:time2];
    if (time&&[time length]>0) {
        TKRecordCalendarCell *cell1=self.cells[0];
        NSDate *date3=[NSDate dateFromString:time withFormat:@"yyyy-MM-dd"];
        TKDateInformation info=[date3 dateInformation];
        [cell1.calendarView selectDate:info.day];
    }else{
        [self.cells removeObjectsInRange:NSMakeRange(1, self.cells.count-1)];
        [_userTable reloadData];
    }
    
}
//选中某天处理
-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date{
    NSString *str=[date stringWithFormat:@"yyyy-MM-dd"];
    NSArray *arr=[self.recordHelper searchRecordWithType:self.recordType searchDate:str];
    [self.cells removeObjectsInRange:NSMakeRange(1, self.cells.count-1)];
    if (arr&&[arr count]>0) {
        for (RecordRemind *item in arr) {
           TKRecordDetailCell *cell2=[[TKRecordDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            if ([item.Type isEqualToString:@"2"]) {
                [cell2 setTime:item.TimeSpan name:item.Name value1:item.DetailValue1 value2:item.DetailValue2];
            }else{
                [cell2 setTime:item.TimeSpan name:item.Name detail:item.Description];
            }
            [self.cells addObject:cell2];
        }
    }
    [_userTable reloadData];
}
-(void)calendarView:(VRGCalendarView *)calendarView changeCalendarHeight:(CGFloat)height{
    id v=[calendarView superview];
    while (![v isKindOfClass:[TKRecordCalendarCell class]]) {
        v=[v superview];
    }
    TKRecordCalendarCell *cell=(TKRecordCalendarCell*)v;
    cell.cellHeight=height+5;
    [_userTable reloadData];
}
#pragma mark - RecordTopViewDelegate Methods
- (void)selectedButton:(UIButton*)btn type:(NSInteger)type{
    BOOL boo=NO;
    if ([self.recordType integerValue]!=type) {
        boo=YES;
    }
    self.recordType=[NSString stringWithFormat:@"%d",type];
    if (boo) {//表示发生改变
        TKRecordCalendarCell *cell=self.cells[0];
        [cell.calendarView reset];
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
#pragma mark UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        TKRecordCalendarCell *cell1=self.cells[indexPath.row];
        return cell1.cellHeight;
    }
    TKRecordDetailCell *cell=self.cells[indexPath.row];
    if (cell.showValue1) {
        
        CGFloat h=cell.cellHeight+20;
        if (DeviceIsPad) {
            return h<90.0f?90.0f:h;
        }
        return h<70.0f?70.0f:h;
    }else{
        CGFloat h=cell.cellHeight+20;
        return h<90.0f?90.0f:h;
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
