//
//  ClockViewController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/8.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "ClockViewController.h"
#import "UserManagerController.h"
#import "UseDrugViewController.h"
#import "BloodViewController.h"
#import "BloodSugarViewController.h"
#import "UIImage+TPCategory.h"
@interface ClockViewController ()
- (void)addMenuItemWithFrame:(CGRect)frame title:(NSString*)title tag:(NSInteger)tag;
- (void)buttonMenuItemClick:(UIButton*)btn;
@end

@implementation ClockViewController

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
    self.title=@"小鬧鐘";
    CGFloat maxH=(self.view.bounds.size.height-[self topHeight])/4;
    CGFloat h=maxH-40,leftX=50,topY=(maxH-h)/2;
    CGFloat origY=topY;
    [self addMenuItemWithFrame:CGRectMake(leftX, topY, self.view.bounds.size.width-leftX*2, h) title:@"基本資料" tag:100];
    topY+=h+origY;
    [self addMenuItemWithFrame:CGRectMake(leftX, topY, self.view.bounds.size.width-leftX*2, h) title:@"用藥提醒" tag:101];
    topY+=h+origY;
    [self addMenuItemWithFrame:CGRectMake(leftX, topY, self.view.bounds.size.width-leftX*2, h) title:@"血壓測量" tag:102];
    topY+=h+origY;
    [self addMenuItemWithFrame:CGRectMake(leftX, topY, self.view.bounds.size.width-leftX*2, h) title:@"血糖測量" tag:103];
    // Do any additional setup after loading the view.
}
- (void)addMenuItemWithFrame:(CGRect)frame title:(NSString*)title tag:(NSInteger)tag{
    UIImage *img1=[UIImage imageNamed:@"btn_bg_cor.png"];
    

   CGFloat normalLeftCap = img1.size.width * 0.5f;
   CGFloat normalTopCap = img1.size.height * 0.5f;
    // 13 * 34
    // 指定不需要延伸的區域
    UIEdgeInsets insets = UIEdgeInsetsMake(normalTopCap, normalLeftCap, normalTopCap - 1, normalLeftCap - 1);
    // ios6.0的延伸方式只不過比iOS5.0多了一個延伸模式參數
    img1=[img1 resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    //UIImage *sliderImgName = [img1     resizableImageWithCapInsets:UIEdgeInsetsMake(img1.size.height/2-2, img1.size.width/2-2, img1.size.height/2-2, img1.size.width/2-2)];

    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=frame;
    btn.tag=tag;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:defaultDeviceFontColor forState:UIControlStateNormal];
    btn.titleLabel.font=defaultBDeviceFont;//Courier-Bold Helvetica-Bold
    //btn.contentMode=UIViewContentModeScaleAspectFill;
    [btn addTarget:self action:@selector(buttonMenuItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:img1 forState:UIControlStateNormal];
    [self.view addSubview:btn];
}
- (void)buttonMenuItemClick:(UIButton*)btn{
    if (btn.tag==100) {//基本資料
        UserManagerController *info=[[UserManagerController alloc] init];
        [self.navigationController pushViewController:info animated:YES];
    }
    if (btn.tag==101) {//用藥提醒
        UseDrugViewController *drug=[[UseDrugViewController alloc] init];
        [self.navigationController pushViewController:drug animated:YES];
    }
    if (btn.tag==102) {//血壓測量
        BloodViewController *blood=[[BloodViewController alloc] init];
        [self.navigationController pushViewController:blood animated:YES];
    }
    if (btn.tag==103) {//血糖測量
        BloodSugarViewController *bloodSugar=[[BloodSugarViewController alloc] init];
        [self.navigationController pushViewController:bloodSugar animated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
