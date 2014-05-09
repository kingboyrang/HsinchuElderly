//
//  IndexViewController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/7.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "IndexViewController.h"
#import "ClockViewController.h"
@interface IndexViewController ()
- (void)addMenuItemWithFrame:(CGRect)frame tag:(NSInteger)tag image:(UIImage*)img;
@end

@implementation IndexViewController

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
    self.navigationController.delegate=self;
    
    /***
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:self.view.bounds];
    [imageView setImage:[UIImage imageNamed:@"index_bg.png"]];
    [self.view addSubview:imageView];
     ***/
    
     UIImage *img=[UIImage imageNamed:@"login_title.png"];
     UIImageView *imgLogoView=[[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-img.size.width)/2, (self.view.bounds.size.height-img.size.height)/2, img.size.width, img.size.height)];
    [imgLogoView setImage:img];
    [self.view addSubview:imgLogoView];
    
    //162/* 315/292
    
    //医疗
    UIImage *medical=[UIImage imageNamed:@"medical.png"];
    [self addMenuItemWithFrame:CGRectMake(0, (self.view.bounds.size.height-medical.size.height)/2, medical.size.width,medical.size.height) tag:101 image:medical];
    //服务
    [self addMenuItemWithFrame:CGRectMake(self.view.bounds.size.width-medical.size.width, (self.view.bounds.size.height-medical.size.height)/2, medical.size.width,medical.size.height) tag:102 image:[UIImage imageNamed:@"service.png"]];
    //小闹钟
    [self addMenuItemWithFrame:CGRectMake((self.view.bounds.size.width-medical.size.width)/2,imgLogoView.frame.origin.y-medical.size.height+10, medical.size.width,medical.size.height) tag:100 image:[UIImage imageNamed:@"clock.png"]];
    //学习
    [self addMenuItemWithFrame:CGRectMake((self.view.bounds.size.width-medical.size.width*2-20)/2,imgLogoView.frame.origin.y+imgLogoView.frame.size.height, medical.size.width,medical.size.height) tag:103 image:[UIImage imageNamed:@"study.png"]];
    //福利
    [self addMenuItemWithFrame:CGRectMake(self.view.bounds.size.width-medical.size.width-(self.view.bounds.size.width-medical.size.width*2-20)/2,imgLogoView.frame.origin.y+imgLogoView.frame.size.height, medical.size.width,medical.size.height) tag:104 image:[UIImage imageNamed:@"welfare.png"]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//menu click
- (void)buttonMenuItemClick:(UIButton*)btn{
    if (btn.tag==100) {//小闹钟
        ClockViewController *clock=[[ClockViewController alloc] init];
        [self.navigationController pushViewController:clock animated:YES];
    }
    if (btn.tag==101) {//医疗
        
    }
    if (btn.tag==102) {//服务
        
    }
    if (btn.tag==103) {//学习
        
    }
    if (btn.tag==104) {//福利
        
    }

}
- (void)addMenuItemWithFrame:(CGRect)frame tag:(NSInteger)tag image:(UIImage*)img{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    btn.tag=tag;
    [btn setImage:img forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonMenuItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
#pragma mark - UINavigationController delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ( viewController == [navigationController.viewControllers objectAtIndex:0]) {
        [navigationController setNavigationBarHidden:YES animated:animated];
    } else {
        [navigationController setNavigationBarHidden:NO animated:animated];
    }
    
}

@end
