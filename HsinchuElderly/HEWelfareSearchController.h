//
//  HEWelfareSearchController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/30.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolSearchShow.h"
#import "HEWelfareHelper.h"
@interface HEWelfareSearchController : BasicViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *refreshTable;
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,strong) HEWelfareHelper *dbHelper;
@property (nonatomic,strong) ToolSearchShow *toolSearch;
@property (nonatomic,copy) NSString *categoryGuid;
@property (nonatomic,copy) NSString *categoryName;

@property (nonatomic,assign) double Latitude;
@property (nonatomic,assign) double longitude;
@end
