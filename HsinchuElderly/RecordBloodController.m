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
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"ShrinkPickerView" owner:nil options:nil];
    self.shrinkView=(ShrinkPickerView*)[nibContents objectAtIndex:0];
    self.shrinkView.frame=CGRectMake(0, 0, self.view.bounds.size.width, 202);
    [self.view addSubview:self.shrinkView];
    [self.shrinkView defaultSelectedPicker];
    
    
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RecordTimeView" owner:nil options:nil];
    self.timeView=(RecordTimeView*)[nib objectAtIndex:0];
    self.timeView.frame=CGRectMake(0,212, self.view.bounds.size.width, 195);
    [self.view addSubview:self.timeView];
    [self.timeView defaultInitParams];
    
    if (self.operType==2) {//修改
        [self.shrinkView setSelectedValue:self.Entity.Shrink component:0];
        [self.shrinkView setSelectedValue:self.Entity.Diastolic component:1];
        [self.shrinkView setSelectedValue:self.Entity.Pulse component:2];
        [self.timeView setSelectedValue:self.Entity.TimeSpan];
    }else{
        self.Entity=[[RecordBlood alloc] init];
    }
}
//完成
- (void)buttonFinishedClick:(UIButton*)btn{
    self.Entity.UserId=self.userId;
    self.Entity.Shrink=self.shrinkView.shrinkValue;
    self.Entity.Diastolic=self.shrinkView.diastolicValue;
    self.Entity.Pulse=self.shrinkView.pulseValue;
    self.Entity.TimeSpan=self.timeView.timeValue;
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
@end
