//
//  BloodEditController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/11.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "BloodEditController.h"
#import "UIBarButtonItem+TPCategory.h"
#import "AlertHelper.h"
#import "NSDate+TPCategory.h"
#import "BloodHelper.h"
#import "TKLabelCell.h"
#import "TKCalendarFieldCell.h"
#import "TKSelectFieldCell.h"
@interface BloodEditController ()

@end

@implementation BloodEditController

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
    [cell2.select setSelectedValue:self.Entity.UserId];
    
    
    TKLabelCell *cell3=[[TKLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell3.label.text=@"頻率";
    
    TKSelectFieldCell *cell4=[[TKSelectFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell4.select.popText.field.placeholder=@"請選擇頻率";
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Frequency" ofType:@"plist"];
    [cell4.select setDataSourceForArray:[NSArray arrayWithContentsOfFile:path] dataTextName:@"Name" dataValueName:@"ID"];
    [cell4.select setSelectedValue:self.Entity.Rate];
    
    TKLabelCell *cell5=[[TKLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell5.label.text=@"時間";
    
    TKCalendarFieldCell *cell6=[[TKCalendarFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell6.calendar.popText.field.placeholder=@"請選擇時間";
    cell6.calendar.datePicker.datePickerMode=UIDatePickerModeTime;
    [cell6.calendar.dateForFormat setDateFormat:@"HH:mm"];
    cell6.calendar.popText.field.text=self.Entity.TimeSpan;
    
    self.cells=[NSMutableArray arrayWithObjects:cell1,cell2,cell3,cell4,cell5,cell6, nil];
    [_userTable reloadData];

}
//完成
- (void)buttonSubmitClick:(UIButton*)btn{
    TKSelectFieldCell *cell1=self.cells[1];
    if ([cell1.select.value length]==0) {
        [AlertHelper initWithTitle:@"提示" message:@"請選擇名字"];
        return;
    }
    
    TKSelectFieldCell *cell2=self.cells[3];
    if ([cell2.select.value length]==0) {
        [AlertHelper initWithTitle:@"提示" message:@"請選擇頻率"];
        return;
    }
   
    TKCalendarFieldCell *cell5=self.cells[5];
    if ([cell5.calendar.popText.field.text length]==0) {
        [AlertHelper initWithTitle:@"提示" message:@"請選擇時間"];
        return;
    }
   
    self.Entity.UserId=cell1.select.value;
    self.Entity.UserName=cell1.select.key;
    self.Entity.Rate=cell2.select.value;
    self.Entity.TimeSpan=cell5.calendar.popText.field.text;
    
    
    
    
    BloodHelper *_helper=[[BloodHelper alloc] init];
    [_helper addEditDrugWithModel:self.Entity name:cell1.select.key];
    //[_helper addBloodWithModel:self.Entity name:cell1.select.key];
    [self.navigationController popViewControllerAnimated:YES];
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
