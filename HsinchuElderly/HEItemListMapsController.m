//
//  HEItemListMapsController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/13.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "HEItemListMapsController.h"
#import "SVGeocoder.h"
#import "BasicModel.h"
#import "CalloutMapAnnotation.h"
#import "CallOutAnnotationVifew.h"
#import "PaoPaoView.h"
#import "BasicMapAnnotation.h"
#import "LocationGPS.h"
#import <QuartzCore/QuartzCore.h>
@interface HEItemListMapsController (){
    CalloutMapAnnotation *_calloutAnnotation;
	//CalloutMapAnnotation *_previousdAnnotation;
    BOOL isFirstCurrentLocation;
}
- (void)buttonCategoryClick:(UIButton*)btn;
- (void)buttonAreaClick:(UIButton*)btn;
- (void)cleanMap;
- (void)loadAnnotationWithSource:(NSArray*)source;
@end

@implementation HEItemListMapsController

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
    isFirstCurrentLocation=YES;
    _topBarView=[[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    [_topBarView.categoryButton addTarget:self action:@selector(buttonCategoryClick:) forControlEvents:UIControlEventTouchUpInside];
    [_topBarView.areaButton addTarget:self action:@selector(buttonAreaClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topBarView];
    
    CGRect r=self.view.bounds;
    r.origin.y=_topBarView.frame.size.height;
    r.size.height-=[self topHeight]+r.origin.y;
    self.map = [[MKMapView alloc]initWithFrame:r];
    self.map.mapType = MKMapTypeStandard;
    self.map.delegate=self;
    [self.view addSubview:self.map];
    
    self.menuHelper=[[TPMenuHelper alloc] init];
    
    //[self defaultInitParams];//數據初始化
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    size_t count = 3;
    dispatch_apply(count, queue, ^(size_t i) {
        if (i==0) {
            if ([self.medicalCategorys count]==0) {
                self.medicalCategorys=[self.dbHelper categorys];
            }
           
        }
        if (i==1) {
            if ([self.medicalAreas count]==0) {
                self.medicalAreas=[self.dbHelper areasWithCategory:@""];
            }
        }
        if (i==2) {
            //載入標註
            [self loadData];
            /***
            if ([self.annotationList count]>0) {
                [self cleanMap];
                [self loadAnnotationWithSource:self.annotationList];
            }else{
               [self loadData];
            }
             ***/
        }
    });
}
- (void)cleanMap{
     NSArray* array=[NSArray arrayWithArray:self.map.annotations];
    [self.map removeAnnotations:array];
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
        if (arr&&[arr count]>0) {
            //通知MainThread更新
            dispatch_async(dispatch_get_main_queue(), ^{
                self.annotationList=arr;
                [self cleanMap];
                [self loadAnnotationWithSource:self.annotationList];
            });
        }else{
            //通知MainThread更新
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.annotationList removeAllObjects];
                [self cleanMap];
            });
        }
    });
}
- (UIView*)loadMessageView{
    CGRect r=self.view.bounds;
    UIView *bg=[[UIView alloc] initWithFrame:r];
    bg.backgroundColor=[UIColor grayColor];
    bg.tag=300;
    bg.alpha=0.3;
    
    /***
    UIView *showView=[[UIView alloc] initWithFrame:CGRectZero];
    showView.backgroundColor=[UIColor whiteColor];
    showView.layer.cornerRadius=5.0;
    showView.layer.masksToBounds=YES;
    showView.layer.borderWidth=2.0;
    showView.layer.borderColor=[UIColor whiteColor].CGColor;
    
    UIActivityIndicatorView *indircatorView=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(10, 10, 37, 37)];
    indircatorView.activityIndicatorViewStyle=
     ***/
    
   
    
    return bg;
}
//開始當前定位
- (void)startCurrentLocation{
    LocationGPS *gps=[LocationGPS sharedInstance];
    [gps startCurrentLocation:^(CLLocationCoordinate2D coor2D) {
        
        MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
        ann.coordinate = coor2D;
        //[ann setTitle:@"當前位置"];
        //[ann setSubtitle:self.Address];
        //觸發viewForAnnotation
        [self.map addAnnotation:ann];
        
        if (isFirstCurrentLocation) {
            isFirstCurrentLocation=NO;
            MKCoordinateRegion region;
            MKCoordinateSpan span;
            span.latitudeDelta=0.1; //zoom level
            span.longitudeDelta=0.1; //zoom level
            region.span=span;
            region.center=coor2D;
            // 設置顯示位置(動畫)
            [self.map setRegion:region animated:YES];
            // 設置地圖顯示的類型及根據範圍進行顯示
            [self.map regionThatFits:region];
        }
       
        //預設選中
        //[self.map selectAnnotation:ann animated:YES];
       
        
    } failed:^(NSError *error) {
        
    }];
}
- (void)loadAnnotationWithSource:(NSArray*)source{
    
    if ([source count]==0) {
        return;
    }
    __block  UIView *bg=nil;
    if (!bg) {
        bg=[self loadMessageView];
        [self.view addSubview:bg];
    }
    __block AnimateLoadView *load=nil;
    if (!load) {
        CGFloat topY=(self.view.bounds.size.height-[self topHeight]-40)/2;
        load=[[AnimateLoadView alloc] initWithFrame:CGRectMake((bg.frame.size.width-200)/2,topY,200, 40)];
        load.tag=301;
        load.backgroundColor=[UIColor colorFromHexRGB:@"fc9a08"];
        [load.activityIndicatorView startAnimating];
        [self.view addSubview:load];
    }
    // 風騷寫法三
     dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        dispatch_apply([source count], queue, ^(size_t index){
            BasicModel *entity=source[index];
            dispatch_async(dispatch_get_main_queue(), ^{
               
                static int total=0;
                CLLocationCoordinate2D coor=entity.coordinate;
                MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(coor,40000 ,40000);
                MKCoordinateRegion adjustedRegion = [self.map regionThatFits:region];
                [self.map setRegion:adjustedRegion animated:YES];
                BasicMapAnnotation *ann=[[BasicMapAnnotation alloc] initWithLatitude:coor.latitude andLongitude:coor.longitude];
                ann.Entity=entity;
                [self.map addAnnotation:ann];
                if (total==[source count]-1||[source count]==1) {
                    [load removeFromSuperview];
                    [bg removeFromSuperview];
                    if ([self.view viewWithTag:300]) {
                        [[self.view viewWithTag:300] removeFromSuperview];
                    }
                    if ([self.view viewWithTag:301]) {
                        [[self.view viewWithTag:301] removeFromSuperview];
                    }
                    total=0;
                    [self startCurrentLocation];
                    return;
                }
                total++;
            });
        });
        
    });
    
    /***
    // 風騷寫法一
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    size_t count = [source count];
    dispatch_apply(count, queue, ^(size_t i) {
        BasicModel *entity=source[i];
        dispatch_async(dispatch_get_main_queue(), ^{
            CLLocationCoordinate2D coor=entity.coordinate;
            MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(coor,40000 ,40000);
            MKCoordinateRegion adjustedRegion = [self.map regionThatFits:region];
            [self.map setRegion:adjustedRegion animated:YES];
            
            BasicMapAnnotation *ann=[[BasicMapAnnotation alloc] initWithLatitude:coor.latitude andLongitude:coor.longitude];
            ann.Entity=entity;
            [self.map addAnnotation:ann];
        });
    });
     ***/
     
    /***
    // 風騷寫法二
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    size_t count = [source count];
    dispatch_apply(count, queue, ^(size_t i) {
        BasicModel *entity=source[i];
        if (!entity.placemark) {//表示没有經緯度
            [SVGeocoder geocode:entity.Address completion:^(NSArray *placemarks, NSHTTPURLResponse *urlResponse, NSError *error) {
                if (placemarks&&[placemarks count]>0) {
                    SVPlacemark *place=[placemarks objectAtIndex:0];
                    entity.placemark=place;
                    //MainThread載入標註
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(place.coordinate,40000 ,40000);
                        MKCoordinateRegion adjustedRegion = [self.map regionThatFits:region];
                        [self.map setRegion:adjustedRegion animated:YES];
                        
                        BasicMapAnnotation *ann=[[BasicMapAnnotation alloc] initWithLatitude:place.coordinate.latitude andLongitude:place.coordinate.longitude];
                        ann.Entity=entity;
                        [self.map addAnnotation:ann];
                        
                    });
                }
            }];
        }else{
            //MainThread載入標註
            dispatch_async(dispatch_get_main_queue(), ^{
                
                MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(entity.placemark.coordinate,40000 ,40000);
                MKCoordinateRegion adjustedRegion = [self.map regionThatFits:region];
                [self.map setRegion:adjustedRegion animated:YES];
                
                BasicMapAnnotation *ann=[[BasicMapAnnotation alloc] initWithLatitude:entity.placemark.coordinate.latitude andLongitude:entity.placemark.coordinate.longitude];
                ann.Entity=entity;
                [self.map addAnnotation:ann];
                
            });
        
        }
        
    });
    // 銷毀隊列
    //dispatch_release(queue);
     ***/
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
#pragma mark TPMenuHelperDelegate Methods
- (void)chooseMenuItem:(id)item index:(NSInteger)index{
    BOOL boo=NO;
    NSDictionary *dic=(NSDictionary*)item;
    if (index==1) {//類別
        [_topBarView.categoryButton setTitle:[dic objectForKey:@"Name"] forState:UIControlStateNormal];
        if (![self.categoryGuid isEqualToString:[dic objectForKey:@"ID"]]) {
            self.categoryGuid=[dic objectForKey:@"ID"];
            self.areaGuid=@"";
            self.medicalAreas=[self.dbHelper areasWithCategory:self.categoryGuid];
            [_topBarView.areaButton setTitle:@"所有區域" forState:UIControlStateNormal];
            boo=YES;
        }
    }else{//區域
        [_topBarView.areaButton setTitle:[dic objectForKey:@"Name"] forState:UIControlStateNormal];
        if (![self.areaGuid isEqualToString:[dic objectForKey:@"ID"]]) {
            self.areaGuid=[dic objectForKey:@"ID"];
             boo=YES;
        }
    }
    if (boo) {
        [self loadData];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString*)getAnnotationImageName:(BasicModel*)entity{
    if ([entity.AreaGuid isEqualToString:@"1"]) {//咨詢
        return [NSString stringWithFormat:@"d%@",entity.CategoryGuid];
        
    }else  if ([entity.AreaGuid isEqualToString:@"2"]) {//醫療
       return [NSString stringWithFormat:@"a%@",entity.CategoryGuid];
    }
    else  if ([entity.AreaGuid isEqualToString:@"3"]) {//服務
        return [NSString stringWithFormat:@"b%@",entity.CategoryGuid];
    }
    else  if ([entity.AreaGuid isEqualToString:@"4"]) {//休閒
        return [NSString stringWithFormat:@"c%@",entity.CategoryGuid];
    }else{//福利
    
    }
   return @"pin_green.png";
}
#pragma mark -MKMapViewDelegate Methods
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
	if ([view.annotation isKindOfClass:[BasicMapAnnotation class]]) {
        if (_calloutAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _calloutAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            return;
        }
        if (_calloutAnnotation) {
            [mapView removeAnnotation:_calloutAnnotation];
            _calloutAnnotation = nil;
        }
        _calloutAnnotation = [[CalloutMapAnnotation alloc]
                               initWithLatitude:view.annotation.coordinate.latitude
                               andLongitude:view.annotation.coordinate.longitude];
        BasicMapAnnotation *basic=(BasicMapAnnotation*)view.annotation;
        _calloutAnnotation.Entity=basic.Entity;
        [mapView addAnnotation:_calloutAnnotation];
        
        [mapView setCenterCoordinate:_calloutAnnotation.coordinate animated:YES];
	}
}
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if (_calloutAnnotation&& ![view isKindOfClass:[CallOutAnnotationVifew class]]) {
        if (_calloutAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _calloutAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            [mapView removeAnnotation:_calloutAnnotation];
            _calloutAnnotation = nil;
        }
    }
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[CalloutMapAnnotation class]]) {
         CalloutMapAnnotation *ann=(CalloutMapAnnotation*)annotation;
        CallOutAnnotationVifew *annotationView = (CallOutAnnotationVifew *)[mapView dequeueReusableAnnotationViewWithIdentifier:ann.Entity.ID];
        if (!annotationView) {
            annotationView = [[CallOutAnnotationVifew alloc] initWithAnnotation:annotation reuseIdentifier:ann.Entity.ID];
            //添加自定View
             PaoPaoView *paoView=[[PaoPaoView alloc] initWithFrame:CGRectMake(0, 0, DeviceIsPad?380:280, DeviceIsPad?380*100/280:100)];
            [paoView setViewDataSource:ann.Entity];
            [annotationView addCustomView:paoView];
        }
        return annotationView;
	} else if ([annotation isKindOfClass:[BasicMapAnnotation class]]) {
         BasicMapAnnotation *basicMap=(BasicMapAnnotation*)annotation;
        MKAnnotationView *annotationView =[self.map dequeueReusableAnnotationViewWithIdentifier:basicMap.Entity.ID];
        if (!annotationView) {
           
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                           reuseIdentifier:basicMap.Entity.ID];
            annotationView.canShowCallout = NO;
            annotationView.image = [UIImage imageNamed:[self getAnnotationImageName:basicMap.Entity]];
        }
		
		return annotationView;
    }else if([annotation isKindOfClass:[MKPointAnnotation class]]){//MKPointAnnotation
        MKAnnotationView *annotationView =[self.map dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:@"CustomAnnotation"];
            annotationView.canShowCallout =NO;
            annotationView.image = [UIImage imageNamed:@"pin_green.png"];
        }
		
		return annotationView;
    }
	return nil;
}
@end
