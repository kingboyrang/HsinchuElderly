//
//  LocationController.m
//  CaseBulletin
//
//  Created by aJia on 2012/10/26.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationGPS.h"

@interface LocationGPS()//私有方法
//获取当前位置
-(void) loadCurrentLocation:(CLLocationCoordinate2D)coor2D;
-(void) start;
-(void) stop;
@end

@implementation LocationGPS
+ (LocationGPS *)sharedInstance {
    static dispatch_once_t  onceToken;
    static LocationGPS * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[LocationGPS alloc] init];
    });
    return sSharedInstance;
}
- (void)startCurrentLocation:(void(^)(CLLocationCoordinate2D coor2D))completed failed:(void(^)(NSError *error))failed{
    
    self.failedlocationBlock=failed;
    self.currentLocationBlock=completed;
    [self start];
}
-(void)startLocation:(void(^)())progress completed:(void(^)(SVPlacemark *place))finish failed:(void(^)(NSError *error))failed{
    if (progress) {
        progress();
    }
    [self startLocation:finish failed:failed];
}
-(void)startLocation:(void(^)(SVPlacemark *place))finish failed:(void(^)(NSError *error))failed{
    self.finishlocationBlock=finish;
    self.failedlocationBlock=failed;
    [self start];
}
#pragma mark -
#pragma mark CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    [self stop];//停止定位
    if (self.currentLocationBlock) {
        self.currentLocationBlock(newLocation.coordinate);
    }
    
    [self loadCurrentLocation:newLocation.coordinate];
    //CLLocation *currentLocation = [locations lastObject];
   
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (self.failedlocationBlock) {
        self.failedlocationBlock(error);
    }
    
    [self stop];//停止定位
}
#pragma mark -
#pragma mark 私有方法
-(void) start {
    [self stop];//先停止
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    }
    [self.locationManager startUpdatingLocation];
}
-(void) stop {
    if (self.locationManager) {
        [self.locationManager stopUpdatingLocation];
        //self.locationManager.delegate=nil;
       //self.locationManager=nil;
    }
}
-(void) loadCurrentLocation:(CLLocationCoordinate2D)coor2D{
    if (self.finishlocationBlock) {
        [SVGeocoder reverseGeocode:coor2D
                        completion:^(NSArray *placemarks, NSHTTPURLResponse *urlResponse, NSError *error) {
                            // do something with placemarks, handle errors
                            
                            if ([placemarks count]>0) {
                                SVPlacemark *place=(SVPlacemark*)[placemarks objectAtIndex:0];
                                if (self.finishlocationBlock) {
                                    self.finishlocationBlock(place);
                                }
                            }
                            
                            if (error) {
                                if (self.failedlocationBlock) {
                                    self.failedlocationBlock(error);
                                }
                            }
                            
                            
                        }];
    }
}
@end
