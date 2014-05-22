//
//  HEItemListController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "HEItemListController.h"
#import "BasicModel.h"
#import "UIBarButtonItem+TPCategory.h"
#import "HEItemDetailController.h"
#import "HEItemListMapsController.h"
@interface HEItemListController ()
- (void)buttonMapClick:(UIButton*)btn;
@end

@implementation HEItemListController

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
    [self defaultPageInit];
    _topBarView=[[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    [_topBarView.categoryButton addTarget:self action:@selector(buttonCategoryClick:) forControlEvents:UIControlEventTouchUpInside];
    [_topBarView.areaButton addTarget:self action:@selector(buttonAreaClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topBarView];
    
    CGRect r=self.view.bounds;
    r.origin.y=44;
    r.size.height-=[self topHeight]+r.origin.y;
    _refreshTable=[[PullingRefreshTableView alloc] initWithFrame:r pullingDelegate:self];
    _refreshTable.dataSource=self;
    _refreshTable.delegate=self;
    _refreshTable.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_refreshTable];
    [self.view insertSubview:_topBarView belowSubview:_refreshTable];
    
    self.menuHelper=[[TPMenuHelper alloc] init];
    
    [self defaultInitParams];
    [_refreshTable launchRefreshing];//載入數據
    
    //載入數據
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if ([self.medicalCategorys count]==0) {
            self.medicalCategorys=[self.dbHelper categorys];
        }
        if ([self.medicalAreas count]==0) {
            self.medicalAreas=[self.dbHelper areas];
        }
    });
}
- (void)defaultPageInit{

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)defaultInitParams{
    pageSize=DeviceIsPad?20:10;
    pageNumber=0;
}
//地圖
- (void)buttonMapClick:(UIButton*)btn{
    HEItemListMapsController *maps=[[HEItemListMapsController alloc] init];
    maps.title=self.title;
    maps.medicalAreas=self.medicalAreas;
    maps.medicalCategorys=self.medicalCategorys;
    maps.dbHelper=self.dbHelper;
    [self.navigationController pushViewController:maps animated:YES];
}
//類別
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
    
    //NSString *path=[[NSBundle mainBundle] pathForResource:@"MedicalCareCategory" ofType:@"plist"];
    
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
#pragma mark TPMenuHelperDelegate Methods
- (void)chooseMenuItem:(id)item index:(NSInteger)index{
    NSDictionary *dic=(NSDictionary*)item;
    if (index==1) {//類別
        [_topBarView.categoryButton setTitle:[dic objectForKey:@"Name"] forState:UIControlStateNormal];
        if (![self.categoryGuid isEqualToString:[dic objectForKey:@"ID"]]) {
            self.categoryGuid=[dic objectForKey:@"ID"];
            [self defaultInitParams];
            [_refreshTable launchRefreshing];
        }
    }else{//區域
        [_topBarView.areaButton setTitle:[dic objectForKey:@"Name"] forState:UIControlStateNormal];
        if (![self.areaGuid isEqualToString:[dic objectForKey:@"ID"]]) {
            self.areaGuid=[dic objectForKey:@"ID"];
            [self defaultInitParams];
            [_refreshTable launchRefreshing];
        }
    }
}
//載入數據
- (void)loadData{
    pageNumber++;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 處理耗時操作的block...
        NSMutableArray *arr=[self.dbHelper searchWithCategory:self.categoryGuid aresGuid:self.areaGuid size:pageSize page:pageNumber];
        if (arr&&[arr count]>0) {
            //通知MainThread更新
            dispatch_async(dispatch_get_main_queue(), ^{
                [_refreshTable tableViewDidFinishedLoading];
                _refreshTable.reachedTheEnd = NO;
                if (self.refreshing) {
                    self.refreshing = NO;
                }
                //Callback或者說是通知MainThread更新，
                if (pageNumber==1) {
                    self.list=arr;
                    [_refreshTable reloadData];
                }else{
                    NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:arr.count];
                    int total=self.list.count;
                    for (int i=0; i<[arr count]; i++) {
                        [self.list addObject:[arr objectAtIndex:i]];
                        NSIndexPath *newPath=[NSIndexPath indexPathForRow:i+total inSection:0];
                        [insertIndexPaths addObject:newPath];
                    }
                    //重新呼叫UITableView的方法, 來生成行.
                    [_refreshTable beginUpdates];
                    [_refreshTable insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
                    [_refreshTable endUpdates];
                    [self showSuccessViewWithHide:^(AnimateErrorView *successView) {
                        successView.labelTitle.text=[NSString stringWithFormat:@"更新%d筆資料!",insertIndexPaths.count];
                    } completed:nil];
                }
                
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [_refreshTable tableViewDidFinishedLoading];
                _refreshTable.reachedTheEnd = NO;
                if (self.refreshing) {
                    self.refreshing = NO;
                }
                pageNumber--;
                [self showErrorViewWithHide:^(AnimateErrorView *errorView) {
                    errorView.labelTitle.text=@"沒有了哦!";
                    errorView.backgroundColor=[UIColor colorFromHexRGB:@"0e4880"];
                } completed:nil];
            });
        }
        
    });
}
#pragma mark UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"medicalCareCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        UIImage *img=[UIImage imageNamed:@"cell_bg.png"];
        img=[img stretchableImageWithLeftCapWidth:10 topCapHeight:0];
        CGRect r=cell.frame;
        r.size.width=self.view.bounds.size.width;
        UIView *bgView=[[UIView alloc] initWithFrame:r];
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:bgView.bounds];
        [imageView setImage:img];
        [bgView addSubview:imageView];
        
        cell.backgroundView=bgView;
        
        UIImage *rightImg=[UIImage imageNamed:@"arrow_right.png"];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, 0, rightImg.size.width, rightImg.size.height);
        [btn setBackgroundImage:rightImg forState:UIControlStateNormal];
        cell.accessoryView=btn;
    }
    BasicModel *entity=self.list[indexPath.row];
    cell.textLabel.text=entity.Name;
    cell.textLabel.textColor=defaultDeviceFontColor;
    cell.textLabel.font=defaultSDeviceFont;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HEItemDetailController *detail=[[HEItemDetailController alloc] init];
    detail.title=self.title;
    detail.Entity=self.list[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark - PullingRefreshTableViewDelegate
//下拉載入
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    self.refreshing = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}
//上拉載入
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}
#pragma mark - Scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshTable tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshTable tableViewDidEndDragging:scrollView];
}

@end
