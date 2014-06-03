//
//  BasicModel.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@class SVPlacemark;
@interface BasicModel : NSObject
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *Name;
@property (nonatomic,copy) NSString *Address;
@property (nonatomic,copy) NSString *Tel;
@property (nonatomic,copy) NSString *CategoryGuid;
@property (nonatomic,copy) NSString *AreaGuid;
@property (nonatomic,copy) NSString *WebSiteURL;
@property (nonatomic,copy) NSString *Lat;
@property (nonatomic,copy) NSString *Lng;//DISTANCE
@property (nonatomic,copy) NSString *Distance;
@property (nonatomic,copy) NSString *Detial;
@property (nonatomic,copy) NSString *Register;
@property (nonatomic, strong) SVPlacemark *placemark;
@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
-(double)distanceWithLatitude:(double)lat longitude:(double)lng;
@end
