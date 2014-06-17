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
#import "VRGCalendarView.h"
#import "TKRecordCalendarCell.h"
#import "TKRecordDetailCell.h"
@interface RecordViewController ()<RecordTopViewDelegate,VRGCalendarViewDelegate>

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
    self.title=@"記錄";
    RecordTopView *topView=[[RecordTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    topView.delegate=self;
    [self.view addSubview:topView];
    
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
    TKRecordDetailCell *cell2=[[TKRecordDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell2 setTime:@"18:00" name:@"王大明" detail:@"吃  腸胃藥"];
    self.cells=[NSMutableArray arrayWithObjects:cell1,cell2, nil];
    
//    RecordCalendar *calendar=[[RecordCalendar alloc] initWithFrame:CGRectMake(10, 60, 300, 200)];
//    [self.view addSubview:calendar];
}
#pragma mark -VRGCalendarViewDelegate Methods
-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated{

}
-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date{
    
}
-(void)calendarView:(VRGCalendarView *)calendarView changeCalendarHeight:(CGFloat)height{
    id v=[calendarView superview];
    while (![v isKindOfClass:[TKRecordCalendarCell class]]) {
        v=[v superview];
    }
    TKRecordCalendarCell *cell=(TKRecordCalendarCell*)v;
    cell.cellHeight=height+5;
    //NSIndexPath *indexPath=[_userTable indexPathForCell:cell];
    
    //[self tableView:_userTable heightForRowAtIndexPath:indexPath];
    [_userTable reloadData];
    //[_userTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
}
#pragma mark - RecordTopViewDelegate Methods
- (void)selectedButton:(UIButton*)btn type:(NSInteger)type{
    if (type==1) {//用藥
        
    }else if(type==2)//血壓
    {
        
    }else{//血糖
    
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
