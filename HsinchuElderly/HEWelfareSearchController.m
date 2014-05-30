//
//  HEWelfareSearchController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/30.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "HEWelfareSearchController.h"
#import "UIBarButtonItem+TPCategory.h"
#import "HEItemListMapsController.h"
#import "TKHEItemCell.h"
#import "HEItemDetailController.h"
#import "BasicModel.h"
#import "LocationGPS.h"
@interface HEWelfareSearchController ()

@end

@implementation HEWelfareSearchController

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
    self.dbHelper=[[HEWelfareHelper alloc] init];
    
    _toolSearch=[[ToolSearchShow alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    [_toolSearch setLabText:self.categoryName];
    [self.view addSubview:_toolSearch];
    
    CGRect r=self.view.bounds;
    r.origin.y=_toolSearch.frame.size.height;
    r.size.height-=[self topHeight]+r.origin.y;
    _refreshTable=[[UITableView alloc] initWithFrame:r style:UITableViewStylePlain];
    _refreshTable.dataSource=self;
    _refreshTable.delegate=self;
    _refreshTable.backgroundColor=[UIColor clearColor];
    _refreshTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_refreshTable];
    
    //加載數據
    [self loadDataSource];
    
}
//地圖
- (void)buttonMapClick:(UIButton*)btn{
    HEItemListMapsController *maps=[[HEItemListMapsController alloc] init];
    maps.title=self.title;
    maps.dbHelper=self.dbHelper;
    [self.navigationController pushViewController:maps animated:YES];
}
//定位並加載數據
- (void)loadDataSource{
    //取得当前位置
    LocationGPS *gps=[LocationGPS sharedInstance];
    [gps startCurrentLocation:^(CLLocationCoordinate2D coor2D) {
        self.Latitude=coor2D.latitude;
        self.longitude=coor2D.longitude;
        [self loadData];
    } failed:^(NSError *error) {
        [self loadData];
    }];
}
//載入數據
- (void)loadData{
    if (!self.categoryGuid) {
        self.categoryGuid=@"";
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 處理耗時操作的block...
        NSMutableArray *arr=[self.dbHelper searchWithCategory:self.categoryGuid aresGuid:@""];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"welfCell";
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
    CGSize size=[entity.Name textSize:[UIFont fontWithName:defaultDeviceFontName size:18] withWidth:w];
    total+=topY+size.height+5;
    
    NSString *title=[NSString stringWithFormat:@"%.1f公里",[entity distanceWithLatitude:self.Latitude longitude:self.longitude]];
    size=[title textSize:[UIFont fontWithName:defaultDeviceFontName size:14] withWidth:w];
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
