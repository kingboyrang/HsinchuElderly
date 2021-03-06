//
//  UseDrugEditController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/11.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "UseDrugEditController.h"
#import "TKLabelFieldCell.h"
#import "UIBarButtonItem+TPCategory.h"
#import "AlertHelper.h"
#import "NSDate+TPCategory.h"
#import "MedicineDrugHelper.h"
#import "TKLabelCell.h"
#import "TKTextFieldCell.h"
@interface UseDrugEditController ()

@end

@implementation UseDrugEditController

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
    
    self.title=@"用藥提醒";
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
    cell2.select.delegate=self;
    cell2.select.popText.field.placeholder=@"請選擇名字";
    if (self.systemUsers&&[self.systemUsers count]>0) {
        [cell2.select setDataSourceForArray:self.systemUsers dataTextName:@"Name" dataValueName:@"ID"];
    }
    [cell2.select setSelectedValue:self.Entity.UserId];
    
    TKLabelCell *cell3=[[TKLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell3.label.text=@"藥名";
    
    TKTextFieldCell *cell4=[[TKTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell4.field.placeholder=@"請輸入藥名";
    cell4.field.delegate=self;
    cell4.field.text=self.Entity.Name;
    
    
    TKLabelCell *cell5=[[TKLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell5.label.text=@"頻率";
    
    TKSelectFieldCell *cell6=[[TKSelectFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell6.select.delegate=self;
    cell6.select.popText.field.placeholder=@"請選擇頻率";
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Frequency" ofType:@"plist"];
    [cell6.select setDataSourceForArray:[NSArray arrayWithContentsOfFile:path] dataTextName:@"Name" dataValueName:@"ID"];
    [cell6.select setSelectedValue:self.Entity.Rate];
    
    TKLabelCell *cell7=[[TKLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell7.label.text=@"時間";
    
    
    TKCalendarFieldCell *cell8=[[TKCalendarFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell8.calendar.delegate=self;
    cell8.calendar.popText.field.placeholder=@"請選擇時間";
    cell8.calendar.datePicker.datePickerMode=UIDatePickerModeTime;
    [cell8.calendar.dateForFormat setDateFormat:@"HH:mm"];
    cell8.calendar.popText.field.text=self.Entity.TimeSpan;
    
   self.cells=[NSMutableArray arrayWithObjects:cell1,cell2,cell3,cell4,cell5,cell6,cell7,cell8, nil];
    
    [_userTable reloadData];
}
//完成
- (void)buttonSubmitClick:(UIButton*)btn{
    TKSelectFieldCell *cell1=self.cells[1];
    if ([cell1.select.value length]==0) {
        [AlertHelper initWithTitle:@"提示" message:@"請選擇名字"];
        return;
    }
    TKTextFieldCell *cell2=self.cells[3];
    if (!cell2.hasValue) {
        [AlertHelper initWithTitle:@"提示" message:@"請輸入藥名"];
        return;
    }
    TKSelectFieldCell *cell3=self.cells[5];
    if ([cell3.select.value length]==0) {
        [AlertHelper initWithTitle:@"提示" message:@"請選擇頻率"];
        return;
    }
    TKCalendarFieldCell *cell4=self.cells[7];
    if ([cell4.calendar.popText.field.text length]==0) {
        [AlertHelper initWithTitle:@"提示" message:@"請選擇時間"];
        return;
    }
   
    self.Entity.UserId=cell1.select.value;
    self.Entity.UserName=cell1.select.key;
    self.Entity.Name=cell2.field.text;
    self.Entity.Rate=cell3.select.value;

    
   
    self.Entity.TimeSpan=cell4.calendar.popText.field.text;
    
    MedicineDrugHelper *_helper=[[MedicineDrugHelper alloc] init];
    [_helper addEditDrugWithModel:self.Entity name:cell1.select.key];
    //[_helper addDrugWithModel:self.Entity name:cell1.select.key];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark CVUICalendarDelegate Methods
-(void)showPopoverCalendar:(id)sender{
    TKTextFieldCell *cell=self.cells[3];
    [cell.field resignFirstResponder];
}
#pragma mark CVUISelectDelegate Methods
-(void)showPopoverSelect:(id)sender{
    TKTextFieldCell *cell=self.cells[3];
    [cell.field resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    /**
     if ([self.cells[indexPath.row] isKindOfClass:[TKSelectFieldCell class]]) {
     return 40.0f;
     }
     **/
    return 40.0f;
}

@end
