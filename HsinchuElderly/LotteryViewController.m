//
//  LotteryViewController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/14.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "LotteryViewController.h"
#import "ActivityView.h"
@interface LotteryViewController ()

@end

@implementation LotteryViewController

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
    UILabel *labTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    labTitle.backgroundColor=[UIColor clearColor];
    labTitle.textColor=defaultDeviceFontColor;
    labTitle.font=[UIFont fontWithName:defaultDeviceFontName size:20];
    labTitle.textAlignment=NSTextAlignmentCenter;
    labTitle.text=@"家有一老  如有一寶活動";
    [self.view addSubview:labTitle];
    
    ActivityView *activity=[[ActivityView alloc] initWithFrame:CGRectMake(10, 46, self.view.bounds.size.width-10*2, 150)];
    [self.view addSubview:activity];
    
    UIImage *img=[UIImage imageNamed:@"chk.png"];
    self.chkButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.chkButton.frame=CGRectMake(10, 0, img.size.width, img.size.height);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
