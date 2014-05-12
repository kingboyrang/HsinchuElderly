//
//  ShowMapController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface ShowMapController : BasicViewController<MKMapViewDelegate>
@property (nonatomic, retain) MKMapView *map;
@property (nonatomic,copy) NSString *Address;
@end
