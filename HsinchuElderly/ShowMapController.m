//
//  ShowMapController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "ShowMapController.h"
#import "SVGeocoder.h"
#import "AlertHelper.h"
@interface ShowMapController ()

@end

@implementation ShowMapController

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
    self.title=@"觀看地圖";
    CGRect r=self.view.bounds;
    r.size.height-=[self topHeight];
    self.map = [[MKMapView alloc]initWithFrame:r];
    self.map.mapType = MKMapTypeStandard;
    self.map.delegate=self;
    [self.view addSubview:self.map];
    
    [SVGeocoder geocode:self.Address completion:^(NSArray *placemarks, NSHTTPURLResponse *urlResponse, NSError *error) {
        if (placemarks&&[placemarks count]>0) {
            SVPlacemark *place=[placemarks objectAtIndex:0];
            
            MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
            ann.coordinate = place.coordinate;
            [ann setTitle:self.Address];
            //触发viewForAnnotation
            [self.map addAnnotation:ann];
            
            MKCoordinateRegion region;
            MKCoordinateSpan span;
            span.latitudeDelta=0.1; //zoom level
            span.longitudeDelta=0.1; //zoom level
            region.span=span;
            region.center=place.coordinate;
            // 设置显示位置(动画)
            [self.map setRegion:region animated:YES];
            // 设置地图显示的类型及根据范围进行显示
            [self.map regionThatFits:region];
            //默认选中
            [self.map selectAnnotation:ann animated:YES];
        }
        if (error) {
            [AlertHelper initWithTitle:@"提示" message:@"在地圖上未找到當前位置!"];
        }
    }];
}
#pragma mark -
#pragma mark MKMapView delegate Methods
- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *pinView = nil;
    
    static NSString *defaultPinID = @"com.invasivecode.pin";
    pinView = (MKPinAnnotationView *)[self.map dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if ( pinView == nil ) pinView =[[MKPinAnnotationView alloc]
                                      initWithAnnotation:annotation reuseIdentifier:defaultPinID];
    pinView.pinColor = MKPinAnnotationColorRed;
    pinView.canShowCallout = YES;
    pinView.animatesDrop = YES;
    return pinView;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
