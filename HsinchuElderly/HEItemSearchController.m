//
//  HEItemSearchController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/30.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "HEItemSearchController.h"
#import "BasicModel.h"
#import "UIBarButtonItem+TPCategory.h"
#import "HEItemDetailController.h"
#import "HEItemListMapsController.h"
#import "TKHEItemCell.h"
#import "FetchDataManager.h"
#import "NetWorkConnection.h"
#import "AlertHelper.h"
#import "CLLocationManager+blocks.h"
@interface HEItemSearchController ()
@property (nonatomic, strong) CLLocationManager *manager;
@end

@implementation HEItemSearchController

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
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonWithTitle:@"地圖" target:self action:@selector(buttonMapClick:) forControlEvents:UIControlEventTouchUpInside];
    //self.dbHelper=[[MedicalCareHelper alloc] init];
    _topBarView=[[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    [_topBarView.categoryButton addTarget:self action:@selector(buttonCategoryClick:) forControlEvents:UIControlEventTouchUpInside];
    [_topBarView.areaButton addTarget:self action:@selector(buttonAreaClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topBarView];
    
    _toolSearch=[[ToolSearchShow alloc] initWithFrame:CGRectMake(0, _topBarView.frame.size.height, self.view.bounds.size.width, 44)];
    [self.view addSubview:_toolSearch];
    
    CGRect r=self.view.bounds;
    r.origin.y=_toolSearch.frame.size.height+_topBarView.frame.size.height;
    r.size.height-=[self topHeight]+r.origin.y;
    _refreshTable=[[UITableView alloc] initWithFrame:r style:UITableViewStylePlain];
    _refreshTable.dataSource=self;
    _refreshTable.delegate=self;
    _refreshTable.backgroundColor=[UIColor clearColor];
    _refreshTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_refreshTable];
    [self.view insertSubview:_topBarView belowSubview:_refreshTable];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveUpateFinished) name:kNotificeUpdateMetaFinished object:nil];
    
    self.menuHelper=[[TPMenuHelper alloc] init];
    self.manager=[CLLocationManager updateManager];
    self.manager.updateAccuracyFilter = kCLUpdateAccuracyFilterNone;
    self.manager.updateLocationAgeFilter = kCLLocationAgeFilterNone;
   
    
    //載入數據
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if ([self.medicalCategorys count]==0) {
            self.medicalCategorys=[self.dbHelper categorys];
        }
        if ([self.medicalAreas count]==0) {
            self.medicalAreas=[self.dbHelper areasWithCategory:@""];
        }
    });
    //定位並載入數據
    [self loadDataSource];
    
}
//表示数据更新完成
- (void)receiveUpateFinished{
    [self loadDataSource];
}
//定位並加載數據
- (void)loadDataSource{
    if ([CLLocationManager isLocationUpdatesAvailable]) {
        [self.manager startUpdatingLocationWithUpdateBlock:^(CLLocationManager *manager, CLLocation *location, NSError *error, BOOL *stopUpdating) {
            if (error) {
               [self loadData];
            }else{
                self.Latitude=location.coordinate.latitude;
                self.longitude=location.coordinate.longitude;
                [self loadData];
            }
            *stopUpdating = YES;
        }];
    }else{//未开启定位
        [self loadData];
    }
    
}
//載入數據
- (void)loadData{
    if (!self.categoryGuid) {
        self.categoryGuid=@"";
    }
    if (!self.areaGuid) {
        self.areaGuid=@"";
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 處理耗時操作的block...
        NSMutableArray *arr=[self.dbHelper searchWithCategory:self.categoryGuid aresGuid:self.areaGuid];
        if ([arr count]==0) {
            if (![NetWorkConnection IsEnableConnection]) {//表示网络未连接
                [AlertHelper initWithTitle:@"提示" message:@"網絡未連接,請檢查!"];
            }else{
                if (!self.isFirstLoad) {
                    self.isFirstLoad=YES;
                    [[FetchDataManager sharedInstance] updateMetaData];
                }
            }
            return;
        }
        //self.medicalAreas=[self.dbHelper searchAreaWithCategory:self.categoryGuid areaGuid:self.areaGuid source:nil];
            //通知MainThread更新
            dispatch_async(dispatch_get_main_queue(), ^{
               NSArray *sortArray=[arr sortedArrayUsingComparator: ^(id obj1, id obj2) {
                    BasicModel *mod1=(BasicModel*)obj1;
                    BasicModel *mod2=(BasicModel*)obj2;
                    double d1=[mod1 distanceWithLatitude:self.Latitude longitude:self.longitude];
                    double d2=[mod2 distanceWithLatitude:self.Latitude longitude:self.longitude];
                    if (d1> d2) {
                        //return (NSComparisonResult)NSOrderedAscending;
                        return (NSComparisonResult)NSOrderedDescending;
                    }
                    if (d1 < d2) {
                        //return (NSComparisonResult)NSOrderedDescending;
                        return (NSComparisonResult)NSOrderedAscending;
                    }
                    return (NSComparisonResult)NSOrderedSame;
                }];
                if (sortArray&&[sortArray count]>0) {
                    self.list=[NSMutableArray arrayWithArray:sortArray];
                }else{
                    self.list=[NSMutableArray array];
                }
                [_refreshTable reloadData];
            });
    });
}
//地圖
- (void)buttonMapClick:(UIButton*)btn{
    HEItemListMapsController *maps=[[HEItemListMapsController alloc] init];
    maps.title=self.title;
    maps.medicalAreas=self.medicalAreas;
    maps.medicalCategorys=self.medicalCategorys;
    maps.dbHelper=self.dbHelper;
    maps.annotationList=self.list;
    [self.navigationController pushViewController:maps animated:YES];
}
//類別
- (void)buttonCategoryClick:(UIButton*)btn{
    
    CGFloat xWidth = self.view.bounds.size.width - 20.0f;
    CGFloat yHeight = (300.0f/480.0f)*self.view.bounds.size.height;
    CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
    
    //TPMenuHelper *helper=[[TPMenuHelper alloc] init];
    self.menuHelper.operType=1;
    self.menuHelper.bindKey=@"Name";
    self.menuHelper.bindValue=@"ID";
    self.menuHelper.sources=self.medicalCategorys;
    self.menuHelper.delegate=self;
    [self.menuHelper showMenuWithTitle:@"請選擇類別" frame:CGRectMake(10, yOffset, xWidth, yHeight)];
}
//區域
- (void)buttonAreaClick:(UIButton*)btn{
    
    //NSString *path=[[NSBundle mainBundle] pathForResource:@"MedicalCareArea" ofType:@"plist"];
    CGFloat xWidth = self.view.bounds.size.width - 20.0f;
    CGFloat yHeight = (300.0f/480.0f)*self.view.bounds.size.height;
    CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
    
    //TPMenuHelper *helper=[[TPMenuHelper alloc] init];
    self.menuHelper.operType=2;
    self.menuHelper.bindKey=@"Name";
    self.menuHelper.bindValue=@"ID";
    self.menuHelper.sources=self.medicalAreas;
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
    if (index==1) {//類別
        _toolSearch.labShow.text=[dic objectForKey:@"Name"];
        [_topBarView.categoryButton setTitle:[dic objectForKey:@"Name"] forState:UIControlStateNormal];
        if (![self.categoryGuid isEqualToString:[dic objectForKey:@"ID"]]) {
            self.categoryGuid=[dic objectForKey:@"ID"];
            self.areaGuid=@"";
            self.medicalAreas=[self.dbHelper areasWithCategory:self.categoryGuid];
            [_topBarView.areaButton setTitle:@"所有區域" forState:UIControlStateNormal];
            [self loadDataSource];
        }
    }else{//區域
        [_topBarView.areaButton setTitle:[dic objectForKey:@"Name"] forState:UIControlStateNormal];
        if (![self.areaGuid isEqualToString:[dic objectForKey:@"ID"]]) {
            self.areaGuid=[dic objectForKey:@"ID"];
             [self loadDataSource];
        }
    }
}
#pragma mark UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"medicalCareCell";
    TKHEItemCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[TKHEItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        UIImage *img=[UIImage imageNamed:@"cell_bg.png"];
        img=[img stretchableImageWithLeftCapWidth:img.size.width*0.5f topCapHeight:img.size.height*0.5f];
        //[img resizableImageWithCapInsets:UIEdgeInsetsMake(img.size.height*0.5f, img.size.width*0.5f, 0, 15) resizingMode:UIImageResizingModeStretch];
        CGRect r=cell.frame;
        r.size.width=DeviceWidth;
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:r];
        [imageView setImage:img];
        
        cell.backgroundView=imageView;
    }
    BasicModel *entity=self.list[indexPath.row];
    cell.labName.text=entity.Name;
    cell.labDistance.text=[NSString stringWithFormat:@"%.1f公里",[entity distanceWithLatitude:self.Latitude longitude:self.longitude]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BasicModel *entity=self.list[indexPath.row];
    CGFloat leftX=10,topY=10,total=0;
    CGFloat w=self.view.bounds.size.width-leftX-20-5-2;
    CGSize size=[entity.Name textSize:[UIFont fontWithName:defaultDeviceFontName size:DeviceIsPad?18*1.5:18] withWidth:w];
    total+=topY+size.height+5;
    
    NSString *title=[NSString stringWithFormat:@"%.1f公里",[entity distanceWithLatitude:self.Latitude longitude:self.longitude]];
    size=[title textSize:[UIFont fontWithName:defaultDeviceFontName size:DeviceIsPad?14*1.5:14] withWidth:w];
    total+=size.height+topY;
   
    return total>60.0f?total:60.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HEItemDetailController *detail=[[HEItemDetailController alloc] init];
    detail.title=self.title;
    detail.Entity=self.list[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}
@end
