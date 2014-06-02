//
//  LocationController.h
//  CaseBulletin
//
//  Created by aJia on 2012/10/26.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "SVGeocoder.h"

typedef void (^finishLocationBlock)(SVPlacemark *place);
typedef void (^failedLocationBlock)(NSError *error);
typedef void (^finishCurrentLoactionBlock)(CLLocationCoordinate2D coor2D);

@interface LocationGPS : NSObject<CLLocationManagerDelegate>
@property (nonatomic,retain) CLLocationManager *locationManager;
@property (readwrite, nonatomic, copy) finishCurrentLoactionBlock currentLocationBlock;
@property (readwrite, nonatomic, copy) finishLocationBlock finishlocationBlock;
@property (readwrite, nonatomic, copy) failedLocationBlock failedlocationBlock;
//單一實例
+ (LocationGPS*)sharedInstance;
//目前定位
- (void)startCurrentLocation:(void(^)(CLLocationCoordinate2D coor2D))completed failed:(void(^)(NSError *error))failed;
//開始定位
-(void)startLocation:(void(^)(SVPlacemark *place))finish failed:(void(^)(NSError *error))failed;
-(void)startLocation:(void(^)())progress completed:(void(^)(SVPlacemark *place))finish failed:(void(^)(NSError *error))failed;

@end
