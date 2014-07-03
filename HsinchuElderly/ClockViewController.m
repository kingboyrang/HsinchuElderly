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
#import "RecordViewController.h"
#import "SystemUserHelper.h"
#import "AlertHelper.h"
@interface ClockViewController ()
- (void)addMenuItemWithFrame:(CGRect)frame title:(NSString*)title tag:(NSInteger)tag;
- (void)buttonMenuItemClick:(UIButton*)btn;
- (BOOL)existsUsers;
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
    //初始化
    self.userHelper=[[SystemUserHelper alloc] init];
    //弹出视图
    self.menuHelper=[[TPMenuHelper alloc] init];
    
    self.title=@"小鬧鐘";
    CGFloat maxH=(self.view.bounds.size.height-[self topHeight])/5;
    CGFloat h=maxH-30,leftX=50,topY=(maxH-h)/2;
    CGFloat origY=topY;
    [self addMenuItemWithFrame:CGRectMake(leftX, topY, self.view.bounds.size.width-leftX*2, h) title:@"基本資料" tag:100];
    topY+=h+origY;
    [self addMenuItemWithFrame:CGRectMake(leftX, topY, self.view.bounds.size.width-leftX*2, h) title:@"用藥提醒" tag:101];
    topY+=h+origY;
    [self addMenuItemWithFrame:CGRectMake(leftX, topY, self.view.bounds.size.width-leftX*2, h) title:@"血壓測量" tag:102];
    topY+=h+origY;
    [self addMenuItemWithFrame:CGRectMake(leftX, topY, self.view.bounds.size.width-leftX*2, h) title:@"血糖測量" tag:103];
    topY+=h+origY;
    [self addMenuItemWithFrame:CGRectMake(leftX, topY, self.view.bounds.size.width-leftX*2, h) title:@"記錄" tag:104];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.userHelper loadDataSource];//加载用户资料
}
- (void)addMenuItemWithFrame:(CGRect)frame title:(NSString*)title tag:(NSInteger)tag{
    UIImage *img1=[UIImage imageNamed:@"btn_bg.png"];
    

   CGFloat normalLeftCap = img1.size.width * 0.5f;
   CGFloat normalTopCap = img1.size.height * 0.5f;
    // 13 * 34
    // 指定不需要延伸的區域
    UIEdgeInsets insets = UIEdgeInsetsMake(normalTopCap, normalLeftCap, normalTopCap - 1, normalLeftCap - 1);
    // ios6.0的延伸方式只不過比iOS5.0多了一個延伸模式參數
    img1=[img1 resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];

    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=frame;
    btn.tag=tag;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:defaultDeviceFontColor forState:UIControlStateNormal];
    btn.titleLabel.font=defaultBDeviceFont;//Courier-Bold Helvetica-Bold
    [btn addTarget:self action:@selector(buttonMenuItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:img1 forState:UIControlStateNormal];
    [self.view addSubview:btn];
}
- (void)buttonMenuItemClick:(UIButton*)btn{
    if (btn.tag==100) {//基本資料
        UserManagerController *info=[[UserManagerController alloc] init];
        [self.navigationController pushViewController:info animated:YES];
        return;
    }
    if (![self existsUsers]) {
        [AlertHelper showMessage:@"請先輸入您的基本資料!"];
        return;
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
    if (btn.tag==104) {//記錄
        CGFloat xWidth = self.view.bounds.size.width - 20.0f;
        CGFloat yHeight = (300.0f/480.0f)*self.view.bounds.size.height;
        CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
        
        //TPMenuHelper *helper=[[TPMenuHelper alloc] init];
        self.menuHelper.operType=1;
        self.menuHelper.bindKey=@"Name";
        self.menuHelper.bindValue=@"ID";
        self.menuHelper.sources=[self.userHelper dictonaryUsers];
        self.menuHelper.delegate=self;
        [self.menuHelper showMenuWithTitle:@"選擇對象" frame:CGRectMake(10, yOffset, xWidth, yHeight)];
    }
}
//判断是否有用户
- (BOOL)existsUsers{
    NSMutableArray *arr=[self.userHelper sysUsers];
    if (arr&&[arr count]>0) {
        return YES;
    }
    return NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TPMenuHelperDelegate Methods
- (void)chooseMenuItem:(id)item index:(NSInteger)index{
     NSDictionary *dic=(NSDictionary*)item;
    RecordViewController *record=[[RecordViewController alloc] init];
    record.userId=[dic objectForKey:@"ID"];//获取用户id
    [self.navigationController pushViewController:record animated:YES];
}

@end
