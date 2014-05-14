//
//  IndexViewController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/7.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "IndexViewController.h"
#import "ClockViewController.h"
#import "MedicalCareController.h"
#import "LeisureTimeController.h"
#import "HEServiceViewController.h"
#import "HEWelfareViewController.h"
#import "HEItemListController.h"
#import "HEConsultationHelper.h"
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
    CGFloat leftX=(self.view.bounds.size.width-medical.size.width*2-20)/2;
    [self addMenuItemWithFrame:CGRectMake(leftX,imgLogoView.frame.origin.y-medical.size.height+10, medical.size.width,medical.size.height) tag:100 image:[UIImage imageNamed:@"clock.png"]];
    //学习咨询
    [self addMenuItemWithFrame:CGRectMake(leftX+medical.size.width+20,imgLogoView.frame.origin.y-medical.size.height+10, medical.size.width,medical.size.height) tag:105 image:[UIImage imageNamed:@"consult.png"]];
    //学习
    CGFloat topY=imgLogoView.frame.origin.y+imgLogoView.frame.size.height-10;
    [self addMenuItemWithFrame:CGRectMake(leftX,topY, medical.size.width,medical.size.height) tag:103 image:[UIImage imageNamed:@"leisure.png"]];
    //福利
    [self addMenuItemWithFrame:CGRectMake(leftX+medical.size.width+20,topY, medical.size.width,medical.size.height) tag:104 image:[UIImage imageNamed:@"welfare.png"]];
    
    //说明
    UIImage *exclamationImg=[UIImage imageNamed:@"exclamation.png"];
    [self addMenuItemWithFrame:CGRectMake(10,self.view.frame.size.height-exclamationImg.size.height, exclamationImg.size.width,exclamationImg.size.height) tag:106 image:exclamationImg];
    //抽奖
    UIImage *lotteryImg=[UIImage imageNamed:@"lottery.png"];
     [self addMenuItemWithFrame:CGRectMake(self.view.bounds.size.width-lotteryImg.size.width-5,self.view.frame.size.height-lotteryImg.size.height, lotteryImg.size.width,lotteryImg.size.height) tag:107 image:lotteryImg];
    
   

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
        MedicalCareController *medicaCare=[[MedicalCareController alloc] init];
        [self.navigationController pushViewController:medicaCare animated:YES];
    }
    if (btn.tag==102) {//服务
        HEServiceViewController *HEService=[[HEServiceViewController alloc] init];
        [self.navigationController pushViewController:HEService animated:YES];
    }
    if (btn.tag==103) {//学习
        LeisureTimeController *LeisureTime=[[LeisureTimeController alloc] init];
        [self.navigationController pushViewController:LeisureTime animated:YES];
    }
    if (btn.tag==104) {//福利
        HEWelfareViewController *HEWelfare=[[HEWelfareViewController alloc] init];
        [self.navigationController pushViewController:HEWelfare animated:YES];
    }
    if (btn.tag==105) {//学习咨询
        HEItemListController *consulation=[[HEItemListController alloc] init];
        consulation.dbHelper=[[HEConsultationHelper alloc] init];
        consulation.title=@"咨詢站";
        [self.navigationController pushViewController:consulation animated:YES];
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
