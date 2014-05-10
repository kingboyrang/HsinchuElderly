//
//  MedicalCareController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "MedicalCareController.h"

#import "UIBarButtonItem+TPCategory.h"
@interface MedicalCareController ()
- (void)buttonMapClick:(UIButton*)btn;
@end

@implementation MedicalCareController

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
    self.title=@"醫療";
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonWithTitle:@"地圖" target:self action:@selector(buttonMapClick:) forControlEvents:UIControlEventTouchUpInside];
    _topBarView=[[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    [_topBarView.categoryButton addTarget:self action:@selector(buttonCategoryClick:) forControlEvents:UIControlEventTouchUpInside];
    [_topBarView.areaButton addTarget:self action:@selector(buttonAreaClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topBarView];
    
    self.menuHelper=[[TPMenuHelper alloc] init];
}
//地图
- (void)buttonMapClick:(UIButton*)btn{
    
}
//类别
- (void)buttonCategoryClick:(UIButton*)btn{
    /***
    NSMutableArray *sources=[NSMutableArray array];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"所有區域",@"Name",@"00",@"ID", nil]];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"竹北市",@"Name",@"01",@"ID", nil]];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"竹東鎮",@"Name",@"02",@"ID", nil]];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"新埔鎮",@"Name",@"03",@"ID", nil]];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"關西鎮",@"Name",@"04",@"ID", nil]];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"新豐鄉",@"Name",@"04",@"ID", nil]];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"峨眉鄉",@"Name",@"05",@"ID", nil]];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"寶山鄉",@"Name",@"06",@"ID", nil]];
    NSString *path1=[DocumentPath stringByAppendingPathComponent:@"MedicalCareArea.plist"];
    [sources writeToFile:path1 atomically:YES];
    NSLog(@"path=%@",path1);
     ***/
   
    NSString *path=[[NSBundle mainBundle] pathForResource:@"MedicalCareCategory" ofType:@"plist"];
    CGFloat xWidth = self.view.bounds.size.width - 20.0f;
    CGFloat yHeight = 300.0f;
    CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
    
    //TPMenuHelper *helper=[[TPMenuHelper alloc] init];
    self.menuHelper.operType=1;
    self.menuHelper.bindKey=@"Name";
    self.menuHelper.bindValue=@"ID";
    self.menuHelper.sources=[NSMutableArray arrayWithContentsOfFile:path];
    self.menuHelper.delegate=self;
    [self.menuHelper showMenuWithTitle:@"請選擇類別" frame:CGRectMake(10, yOffset, xWidth, yHeight)];
}
//区域
- (void)buttonAreaClick:(UIButton*)btn{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"MedicalCareArea" ofType:@"plist"];
    CGFloat xWidth = self.view.bounds.size.width - 20.0f;
    CGFloat yHeight = 300.0f;
    CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
    
    //TPMenuHelper *helper=[[TPMenuHelper alloc] init];
    self.menuHelper.operType=2;
    self.menuHelper.bindKey=@"Name";
    self.menuHelper.bindValue=@"ID";
    self.menuHelper.sources=[NSMutableArray arrayWithContentsOfFile:path];
    self.menuHelper.delegate=self;
    [self.menuHelper showMenuWithTitle:@"請選擇區域" frame:CGRectMake(10, yOffset, xWidth, yHeight)];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TPMenuHelperDelegate Methods
- (void)chooseMenuItem:(id)item index:(NSInteger)index{
    NSDictionary *dic=(NSDictionary*)item;
    if (index==1) {//类别
        [_topBarView.categoryButton setTitle:[dic objectForKey:@"Name"] forState:UIControlStateNormal];
    }else{//区域
        [_topBarView.areaButton setTitle:[dic objectForKey:@"Name"] forState:UIControlStateNormal];
    }
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
