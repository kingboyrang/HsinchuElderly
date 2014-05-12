//
//  HEItemListController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPMenuHelper.h"
#import "TopBarView.h"
#import "HEBasicHelper.h"
#import "PullingRefreshTableView.h"
@interface HEItemListController : BasicViewController<TPMenuHelperDelegate,PullingRefreshTableViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    int pageSize;
    int pageNumber;
}
@property (nonatomic,strong) PullingRefreshTableView *refreshTable;
@property (nonatomic) BOOL refreshing;
@property (nonatomic,strong) TPMenuHelper *menuHelper;
@property (nonatomic,strong) TopBarView *topBarView;
@property (nonatomic,strong) HEBasicHelper *dbHelper;
@property (nonatomic,strong) NSMutableArray *medicalCategorys;
@property (nonatomic,strong) NSMutableArray *medicalAreas;
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,copy) NSString *categoryGuid;
@property (nonatomic,copy) NSString *areaGuid;
- (void)defaultPageInit;
@end
