//
//  BloodSugaModifyController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "BloodSugaModifyController.h"
#import "UIBarButtonItem+TPCategory.h"
#import "AlertHelper.h"
#import "NSDate+TPCategory.h"
#import "BloodSugarHelper.h"
#import "TKLabelSelectCell.h"
#import "TKLabelCalendarCell.h"
@interface BloodSugaModifyController ()

@end

@implementation BloodSugaModifyController

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
    
    self.title=@"血糖測量";
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonWithTitle:@"完成" target:self action:@selector(buttonSubmitClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect r=self.view.bounds;
    r.size.height-=[self topHeight];
    _userTable=[[UITableView alloc] initWithFrame:r style:UITableViewStylePlain];
    _userTable.dataSource=self;
    _userTable.delegate=self;
    _userTable.backgroundColor=[UIColor clearColor];
    _userTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    _userTable.bounces=NO;
    [self.view addSubview:_userTable];
    
    TKLabelSelectCell *cell1=[[TKLabelSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell1.label.text=@"名字:";
    cell1.select.popText.field.placeholder=@"請選擇名字";
    if (self.systemUsers&&[self.systemUsers count]>0) {
        [cell1.select setDataSourceForArray:self.systemUsers dataTextName:@"Name" dataValueName:@"ID"];
    }
    
    
    TKLabelSelectCell *cell2=[[TKLabelSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell2.label.text=@"頻率:";
    cell2.select.popText.field.placeholder=@"請選擇頻率";
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Frequency" ofType:@"plist"];
    [cell2.select setDataSourceForArray:[NSArray arrayWithContentsOfFile:path] dataTextName:@"Name" dataValueName:@"ID"];
    
    TKLabelCalendarCell *cell3=[[TKLabelCalendarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell3.label.text=@"時間:";
    cell3.calendar.popText.field.placeholder=@"請選擇時間";
    cell3.calendar.datePicker.datePickerMode=UIDatePickerModeTime;
    [cell3.calendar.dateForFormat setDateFormat:@"HH:mm"];
    
    if (self.operType==2) {
        [cell1.select setSelectedValue:self.Entity.UserId];
        [cell2.select setSelectedValue:self.Entity.Rate];
        cell3.calendar.popText.field.text=self.Entity.TimeSpan;
    }
    
    self.cells=[NSMutableArray arrayWithObjects:cell1,cell2,cell3, nil];
    [_userTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//完成
- (void)buttonSubmitClick:(UIButton*)btn{
    TKLabelSelectCell *cell1=self.cells[0];
    if ([cell1.select.value length]==0) {
        [AlertHelper initWithTitle:@"提示" message:@"請選擇名字"];
        return;
    }
    
    TKLabelSelectCell *cell2=self.cells[1];
    if ([cell2.select.value length]==0) {
        [AlertHelper initWithTitle:@"提示" message:@"請選擇頻率"];
        return;
    }
    TKLabelCalendarCell *cell3=self.cells[2];
    if ([cell3.calendar.popText.field.text length]==0) {
        [AlertHelper initWithTitle:@"提示" message:@"請選擇時間"];
        return;
    }
    if (self.operType==1) {
        self.Entity=[[BloodSugar alloc] init];
        self.Entity.ID=[NSString createGUID];
        self.Entity.CreateDate=[NSDate stringFromDate:[NSDate date] withFormat:@"yyyy/MM/dd HH:mm:ss"];
    }
    self.Entity.UserId=cell1.select.value;
    self.Entity.Rate=cell2.select.value;
    self.Entity.TimeSpan=cell3.calendar.popText.field.text;
    
    BloodSugarHelper *_helper=[[BloodSugarHelper alloc] init];
    NSString *memo=self.operType==1?@"新增":@"修改";
    [self showLoadingAnimatedWithTitle:[NSString stringWithFormat:@"正在%@...",memo]];
    [_helper addEditWithModel:self.Entity];
    [self hideLoadingSuccessWithTitle:[NSString stringWithFormat:@"%@成功!",memo] completed:^(AnimateErrorView *successView) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
#pragma mark UITextFieldDelegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(strlen([textField.text UTF8String]) >= 20 && range.length != 1)
        return NO;
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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


@end
