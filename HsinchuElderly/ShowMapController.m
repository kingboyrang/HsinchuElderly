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
            //[ann setSubtitle:self.Address];
            //觸發viewForAnnotation
            [self.map addAnnotation:ann];
            
            MKCoordinateRegion region;
            MKCoordinateSpan span;
            span.latitudeDelta=0.1; //zoom level
            span.longitudeDelta=0.1; //zoom level
            region.span=span;
            region.center=place.coordinate;
            // 設置顯示位置(動畫)
            [self.map setRegion:region animated:YES];
            // 設置地圖顯示的類型及根據範圍進行顯示
            [self.map regionThatFits:region];
            //預設選中
            [self.map selectAnnotation:ann animated:YES];
        }
        if (error) {
            [AlertHelper initWithTitle:@"提示" message:@"無法找到目前位置！"];
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
    //pinView.centerOffset= CGPointMake(0,-5);
    //pinView.calloutOffset = CGPointMake(-8,0);
    return pinView;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
