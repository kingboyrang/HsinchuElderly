//
//  BasicModel.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "BasicModel.h"
#import <MapKit/MapKit.h>
@implementation BasicModel
- (CLLocationCoordinate2D)coordinate{
    CLLocationCoordinate2D coor;
    coor.latitude=[self.Lat doubleValue];
    coor.longitude=[self.Lng doubleValue];
    return coor;
}
-(double)distanceWithLatitude:(double)lat longitude:(double)lng{
    CLLocation *orig=[[CLLocation alloc] initWithLatitude:[self.Lat doubleValue]  longitude:[self.Lng doubleValue]];
    CLLocation* dist=[[CLLocation alloc] initWithLatitude:lat longitude:lng];
    
    return [orig distanceFromLocation:dist]/1000;
    //CLLocationDistance kilometers=[orig distanceFromLocation:dist]/1000;
   // NSLog(@"距离:",kilometers);
}
@end
