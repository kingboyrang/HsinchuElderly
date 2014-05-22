//
//  VersionViewController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/22.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "VersionViewController.h"
#import "VersionView.h"
@interface VersionViewController ()

@end

@implementation VersionViewController

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
     self.title=@"竹縣長青樂";
    
    VersionView *version=[[VersionView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
    CGRect r=version.frame;
    r.origin.x=(self.view.bounds.size.width-r.size.width)/2;
    r.origin.y=(self.view.bounds.size.height-[self topHeight]-r.size.height)/2;
    version.frame=r;
    [self.view addSubview:version];
   
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
