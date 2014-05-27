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
@interface HEItemListMapsController (){
    CalloutMapAnnotation *_calloutAnnotation;
	//CalloutMapAnnotation *_previousdAnnotation;
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
    _topBarView=[[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    [_topBarView.categoryButton addTarget:self action:@selector(buttonCategoryClick:) forControlEvents:UIControlEventTouchUpInside];
    [_topBarView.areaButton addTarget:self action:@selector(buttonAreaClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topBarView];
    
    CGRect r=self.view.bounds;
    r.origin.y=44;
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
                self.medicalAreas=[self.dbHelper areas];
            }
        }
        if (i==2) {
            if ([self.list count]==0) {
                self.list=[self.dbHelper tableDataList];
            }
             //載入標註
            if (self.list&&[self.list count]>0) {
                //預設載入10筆資料
                self.annotationList=[NSMutableArray array];
                for (int i=0; i<10; i++) {
                    [self.annotationList addObject:self.list[i]];
                }
                [self loadAnnotationWithSource:self.annotationList];
            }
        }
    });
}
- (void)cleanMap{
    [self.map removeAnnotations:self.map.annotations];
}
- (void)loadAnnotationWithSource:(NSArray*)source{
    // 獲得全域開發queue
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
- (NSArray*)filterSource{
    if ([self.list count]==0) {
        return nil;
    }
    NSMutableString *sql=[NSMutableString stringWithString:@""];
    if (self.categoryGuid&&[self.categoryGuid length]>0) {
        [sql appendFormat:@"SELF.CategoryGuid =='%@'",self.categoryGuid];
    }
    if (self.areaGuid&&[self.areaGuid length]>0) {
        NSString *memo=[sql length]>0?@" and ":@"";
        [sql appendFormat:@"%@SELF.AreaGuid =='%@'",memo,self.areaGuid];
    }
    if ([sql length]>0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:sql];
        return  [self.list filteredArrayUsingPredicate:predicate];
    }
    NSMutableArray *arr=[NSMutableArray array];
    for (int i=0; i<10; i++) {
        [arr addObject:[self.list objectAtIndex:i]];
    }
    return arr;
}
#pragma mark TPMenuHelperDelegate Methods
- (void)chooseMenuItem:(id)item index:(NSInteger)index{
    BOOL boo=NO;
    NSDictionary *dic=(NSDictionary*)item;
    if (index==1) {//類別
        [_topBarView.categoryButton setTitle:[dic objectForKey:@"Name"] forState:UIControlStateNormal];
        if (![self.categoryGuid isEqualToString:[dic objectForKey:@"ID"]]) {
            self.categoryGuid=[dic objectForKey:@"ID"];
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
        //清空
        NSArray *source=[self filterSource];
        if (source&&[source count]>0) {
            [self cleanMap];
            [self.annotationList removeAllObjects];
            [self.annotationList addObjectsFromArray:source];
            [self loadAnnotationWithSource:source];//載入標註
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    // NSString *identifterCell=[NSString createGUID];
    if ([annotation isKindOfClass:[CalloutMapAnnotation class]]) {
         CalloutMapAnnotation *ann=(CalloutMapAnnotation*)annotation;
        CallOutAnnotationVifew *annotationView = (CallOutAnnotationVifew *)[mapView dequeueReusableAnnotationViewWithIdentifier:ann.Entity.ID];
        if (!annotationView) {
            annotationView = [[CallOutAnnotationVifew alloc] initWithAnnotation:annotation reuseIdentifier:ann.Entity.ID];
            //添加自定View
            PaoPaoView *paoView=[[PaoPaoView alloc] initWithFrame:CGRectMake(0, 0, 240, 100)];
            [paoView setViewDataSource:ann.Entity];
            [annotationView addCustomView:paoView];
        }
        return annotationView;
	} else if ([annotation isKindOfClass:[BasicMapAnnotation class]]) {
        MKAnnotationView *annotationView =[self.map dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                           reuseIdentifier:@"CustomAnnotation"];
            annotationView.canShowCallout = NO;
            annotationView.image = [UIImage imageNamed:@"pin_green.png"];
        }
		
		return annotationView;
    }
	return nil;
}
@end
