//
//  RecordViewController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/6/13.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "RecordViewController.h"
#import "RecordTopView.h"
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
    self.title=@"記錄";
    RecordTopView *topView=[[RecordTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    topView.delegate=self;
    [self.view addSubview:topView];
}
#pragma mark - RecordTopViewDelegate Methods
- (void)selectedButton:(UIButton*)btn type:(NSInteger)type{
    if (type==1) {//用藥
        
    }else if(type==2)//血壓
    {
        
    }else{//血糖
    
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
