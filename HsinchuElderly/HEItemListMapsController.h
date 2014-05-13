//
//  HEItemListMapsController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/13.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TPMenuHelper.h"
#import "TopBarView.h"
#import "HEBasicHelper.h"
@interface HEItemListMapsController : BasicViewController<MKMapViewDelegate,TPMenuHelperDelegate>

@property (nonatomic,strong) TPMenuHelper *menuHelper;
@property (nonatomic,strong) TopBarView *topBarView;
@property (nonatomic,strong) HEBasicHelper *dbHelper;
@property (nonatomic, retain) MKMapView *map;
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,strong) NSMutableArray *annotationList;
@property (nonatomic,strong) NSMutableArray *medicalCategorys;
@property (nonatomic,strong) NSMutableArray *medicalAreas;
@property (nonatomic,copy) NSString *categoryGuid;
@property (nonatomic,copy) NSString *areaGuid;
@end
