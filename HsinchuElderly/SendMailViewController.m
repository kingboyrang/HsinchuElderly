//
//  SendMailViewController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/30.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "SendMailViewController.h"

@interface SendMailViewController ()

@end

@implementation SendMailViewController

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
    /***
    NSString *title=@"郵件發送";
    CGSize size=[title textSize:[UIFont fontWithName:defaultDeviceFontName size:20] withWidth:320];
    UILabel *labTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    labTitle.backgroundColor=[UIColor clearColor];
    labTitle.text=title;
    labTitle.textColor=[UIColor redColor];
    labTitle.font=[UIFont fontWithName:defaultDeviceFontName size:20];
    self.navigationItem.titleView=labTitle;
     ***/
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
