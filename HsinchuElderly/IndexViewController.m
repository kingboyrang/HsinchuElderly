//
//  IndexViewController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/7.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "IndexViewController.h"
#import "ClockViewController.h"
#import "HEWelfareViewController.h"
#import "HEConsultationHelper.h"
#import "LotteryViewController.h"
#import "VersionViewController.h"
#import "HEItemSearchController.h"
#import "MedicalCareHelper.h"
#import "HEStudyHelper.h"
#import "HEServiceHelper.h"
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
    
     UIImage *img=[UIImage imageNamed:[self imageNameWithName:@"login_title" forType:@"png"]];
     UIImageView *imgLogoView=[[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-img.size.width)/2, (self.view.bounds.size.height-img.size.height)/2, img.size.width, img.size.height)];
    [imgLogoView setImage:img];
    [self.view addSubview:imgLogoView];
    
    //162/* 315/292
    
    //醫療
    UIImage *medical=[UIImage imageNamed:[self imageNameWithName:@"medical" forType:@"png"]];
    [self addMenuItemWithFrame:CGRectMake(0, (self.view.bounds.size.height-medical.size.height)/2, medical.size.width,medical.size.height) tag:101 image:medical];
    //服務
    [self addMenuItemWithFrame:CGRectMake(self.view.bounds.size.width-medical.size.width, (self.view.bounds.size.height-medical.size.height)/2, medical.size.width,medical.size.height) tag:102 image:[UIImage imageNamed:[self imageNameWithName:@"service" forType:@"png"]]];
    
    //小鬧鐘
    CGFloat leftX=(self.view.bounds.size.width-medical.size.width*2-20)/2;
    [self addMenuItemWithFrame:CGRectMake(leftX,imgLogoView.frame.origin.y-medical.size.height+10, medical.size.width,medical.size.height) tag:100 image:[UIImage imageNamed:[self imageNameWithName:@"clock" forType:@"png"]]];
    
    
    //諮詢
    [self addMenuItemWithFrame:CGRectMake(leftX+medical.size.width+20,imgLogoView.frame.origin.y-medical.size.height+10, medical.size.width,medical.size.height) tag:105 image:[UIImage imageNamed:[self imageNameWithName:@"consult" forType:@"png"]]];
    //休閒
    
    CGFloat topY=imgLogoView.frame.origin.y+imgLogoView.frame.size.height-10;
    [self addMenuItemWithFrame:CGRectMake(leftX,topY, medical.size.width,medical.size.height) tag:103 image:[UIImage imageNamed:[self imageNameWithName:@"leisure" forType:@"png"]]];
    //福利
    
    [self addMenuItemWithFrame:CGRectMake(leftX+medical.size.width+20,topY, medical.size.width,medical.size.height) tag:104 image:[UIImage imageNamed:[self imageNameWithName:@"welfare" forType:@"png"]]];
    
    //說明
    
    UIImage *exclamationImg=[UIImage imageNamed:[self imageNameWithName:@"exclamation" forType:@"png"]];
    [self addMenuItemWithFrame:CGRectMake(10,self.view.frame.size.height-exclamationImg.size.height, exclamationImg.size.width,exclamationImg.size.height) tag:106 image:exclamationImg];
    //好康抽獎
    UIImage *lotteryImg=[UIImage imageNamed:[self imageNameWithName:@"lottery" forType:@"png"]];
     [self addMenuItemWithFrame:CGRectMake(self.view.bounds.size.width-lotteryImg.size.width-5,self.view.frame.size.height-lotteryImg.size.height, lotteryImg.size.width,lotteryImg.size.height) tag:107 image:lotteryImg];
    
   

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//menu click
- (void)buttonMenuItemClick:(UIButton*)btn{
    if (btn.tag==100) {//小鬧鐘
        ClockViewController *clock=[[ClockViewController alloc] init];
        [self.navigationController pushViewController:clock animated:YES];
    }
    if (btn.tag==101) {//醫療
        HEItemSearchController *medicaCare=[[HEItemSearchController alloc] init];
         medicaCare.title=@"醫療";
        medicaCare.dbHelper=[[MedicalCareHelper alloc] init];
        [self.navigationController pushViewController:medicaCare animated:YES];
    }
    if (btn.tag==102) {//服務
        HEItemSearchController *HEService=[[HEItemSearchController alloc] init];
        HEService.title=@"服務";
        HEService.dbHelper=[[HEServiceHelper alloc] init];
        [self.navigationController pushViewController:HEService animated:YES];
    }
    if (btn.tag==103) {//休閒
        HEItemSearchController *LeisureTime=[[HEItemSearchController alloc] init];
        LeisureTime.title=@"休閒";
        LeisureTime.dbHelper=[[HEStudyHelper alloc] init];
        [self.navigationController pushViewController:LeisureTime animated:YES];
    }
    if (btn.tag==104) {//福利
        HEWelfareViewController *HEWelfare=[[HEWelfareViewController alloc] init];
        [self.navigationController pushViewController:HEWelfare animated:YES];
    }
    if (btn.tag==105) {//諮詢
        HEItemSearchController *consulation=[[HEItemSearchController alloc] init];
        consulation.dbHelper=[[HEConsultationHelper alloc] init];
        consulation.title=@"諮詢";
        [self.navigationController pushViewController:consulation animated:YES];
    }
    if (btn.tag==106) {//版本说明
        VersionViewController *lottery=[[VersionViewController alloc] init];
        [self.navigationController pushViewController:lottery animated:YES];
    }
    if (btn.tag==107) {//好康抽獎
        LotteryViewController *lottery=[[LotteryViewController alloc] init];
        [self.navigationController pushViewController:lottery animated:YES];
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
