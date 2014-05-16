//
//  LotteryViewController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/14.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "LotteryViewController.h"
#import "ActivityView.h"
#import "ChoosePhotoController.h"
#import "AlertHelper.h"
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
    self.title=@"分享照片";
    UILabel *labTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    labTitle.backgroundColor=[UIColor clearColor];
    labTitle.textColor=defaultDeviceFontColor;
    labTitle.font=[UIFont fontWithName:defaultDeviceFontName size:20];
    labTitle.textAlignment=NSTextAlignmentCenter;
    labTitle.text=@"家有一老  如有一寶活動";
    [self.view addSubview:labTitle];
    
    ActivityView *activity=[[ActivityView alloc] initWithFrame:CGRectMake(10, 46, self.view.bounds.size.width-10*2, 150)];
    [self.view addSubview:activity];
    
    CGFloat topY=46+150+10;
    UIImage *img=[UIImage imageNamed:@"chk.png"];
    self.chkButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.chkButton.frame=CGRectMake(10, topY, img.size.width, img.size.height);
    [self.chkButton setImage:img forState:UIControlStateNormal];
    [self.chkButton setImage:[UIImage imageNamed:@"chk-chk.png"] forState:UIControlStateSelected];
    [self.chkButton addTarget:self action:@selector(buttonChkClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.chkButton];
    
    NSString *title=@"本人同意將照片資料供作新竹縣政府宣導";
    CGSize size=[title textSize:[UIFont fontWithName:defaultDeviceFontName size:15] withWidth:320];
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(10+img.size.width+2,topY+4, size.width, size.height)];
    lab.backgroundColor=[UIColor clearColor];
    lab.textColor=[UIColor blackColor];
    lab.font=[UIFont fontWithName:defaultDeviceFontName size:15];
    lab.text=title;
    [self.view addSubview:lab];
    
    title=@"獲獎禮品由新竹縣政府提供，與蘋果官方無任何關係";
    size=[title textSize:[UIFont fontWithName:defaultDeviceFontName size:17] withWidth:self.view.frame.size.width-10*2];
    
    UILabel *lab1=[[UILabel alloc] initWithFrame:CGRectMake(10,self.chkButton.frame.size.height+self.chkButton.frame.origin.y+10, size.width, size.height)];
    lab1.backgroundColor=[UIColor clearColor];
    lab1.textColor=[UIColor blackColor];
    lab1.font=[UIFont fontWithName:defaultDeviceFontName size:17];
    lab1.text=title;
    lab1.numberOfLines=0;
    lab1.lineBreakMode=NSLineBreakByWordWrapping;
    [self.view addSubview:lab1];
    
    topY=lab1.frame.origin.y+lab1.frame.size.height+5;
    UIImage *img1=[UIImage imageNamed:@"btn_bg.png"];
    img1=[img1 stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    //UIEdgeInsets edginset=UIEdgeInsetsMake(10, 10, 10, 10);
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake((self.view.bounds.size.width-150)/2, topY, 150, 40);
    [btn setBackgroundImage:img1 forState:UIControlStateNormal];
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    [btn setTitleColor:defaultDeviceFontColor forState:UIControlStateNormal];
    btn.titleLabel.font=defaultBDeviceFont;
    [btn addTarget:self action:@selector(buttonNextClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
//下一步
- (void)buttonNextClick:(UIButton*)btn{
    if (!self.chkButton.selected) {
        [AlertHelper initWithTitle:@"提示" message:@"請選擇是否同意分享照片!"];
        return;
    }
    ChoosePhotoController *photo=[[ChoosePhotoController alloc] init];
    [self.navigationController pushViewController:photo animated:YES];
}
- (void)buttonChkClick:(UIButton*)btn{
    btn.selected=!btn.selected;
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
