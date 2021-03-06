//
//  HEItemSearchController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/30.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPMenuHelper.h"
#import "TopBarView.h"
#import "HEBasicHelper.h"
#import "ToolSearchShow.h"
@interface HEItemSearchController : BasicViewController<TPMenuHelperDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *refreshTable;
@property (nonatomic,strong) TPMenuHelper *menuHelper;
@property (nonatomic,strong) TopBarView *topBarView;
@property (nonatomic,strong) ToolSearchShow *toolSearch;
@property (nonatomic,strong) HEBasicHelper *dbHelper;
@property (nonatomic,strong) NSMutableArray *medicalCategorys;
@property (nonatomic,strong) NSMutableArray *medicalAreas;
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,copy) NSString *categoryGuid;
@property (nonatomic,copy) NSString *areaGuid;
@property (nonatomic,assign) BOOL isFirstLoad;

@property (nonatomic,assign) double Latitude;
@property (nonatomic,assign) double longitude;
@end
