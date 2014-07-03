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
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"RecordBloodSugarView" owner:nil options:nil];
    self.sugarView=(RecordBloodSugarView*)[nibContents objectAtIndex:0];
    self.sugarView.frame=CGRectMake((self.view.bounds.size.width-320)/2, 0, 320, 202);
    [self.view addSubview:self.sugarView];
    [self.sugarView defaultInitControl];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RecordTimeView" owner:nil options:nil];
    self.timeView=(RecordTimeView*)[nib objectAtIndex:0];
    self.timeView.frame=CGRectMake((self.view.bounds.size.width-320)/2,212, 320, 195);
    [self.view addSubview:self.timeView];
    [self.timeView defaultInitParams];
    
    if (self.operType==2) {//修改
        [self.sugarView setSelectedValue:self.Entity.Measure];
        self.sugarView.sugarField.text=self.Entity.BloodSugar;
        [self.timeView setSelectedValue:self.Entity.TimeSpan];
    }else{
        self.Entity=[[RecordBloodSugar alloc] init];
        
    }
}
//完成
- (void)buttonFinishedClick:(UIButton*)btn{
    if (!self.sugarView.hasValue) {
        [AlertHelper showMessage:@"請輸入血糖值!"];
        return;
    }
    if (![self.sugarView.sugarField.text isNumberString]) {
        [AlertHelper showMessage:@"血糖值只能為0～999之間的數字!"];
        return;
    }
    self.Entity.UserId=self.userId;
    self.Entity.Measure=self.sugarView.bloodValue;
    self.Entity.BloodSugar=self.sugarView.sugarField.text;
    self.Entity.TimeSpan=self.timeView.timeValue;
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
@end
