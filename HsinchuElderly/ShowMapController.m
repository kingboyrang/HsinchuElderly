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
#import "CalloutMapAnnotation.h"
#import "BasicMapAnnotation.h"
#import "CallOutAnnotationVifew.h"
#import "PaoPaoView.h"
@interface ShowMapController (){
    CalloutMapAnnotation *_calloutAnnotation;
	//CalloutMapAnnotation *_previousdAnnotation;
}
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
    
    CLLocationCoordinate2D coordinate=self.Entity.coordinate;
    BasicMapAnnotation *ann=[[BasicMapAnnotation alloc] initWithLatitude:coordinate.latitude andLongitude:coordinate.longitude];
    ann.Entity=self.Entity;
    [self.map addAnnotation:ann];
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=0.1; //zoom level
    span.longitudeDelta=0.1; //zoom level
    region.span=span;
    region.center=coordinate;
    // 設置顯示位置(動畫)
    [self.map setRegion:region animated:YES];
    // 設置地圖顯示的類型及根據範圍進行顯示
    [self.map regionThatFits:region];
    //預設選中
    [self.map selectAnnotation:ann animated:YES];
   
    
    /***
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
     ***/
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
            PaoPaoView *paoView=[[PaoPaoView alloc] initWithFrame:CGRectMake(0, 0, DeviceIsPad?380:280, DeviceIsPad?380*100/280:100)];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
