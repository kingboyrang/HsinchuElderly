//
//  RecordBloodListController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordBloodHelper.h"
#import "RecordBloodSugarHelper.h"
#import "RecordTopView.h"
@interface RecordBloodListController : BasicViewController<UITableViewDataSource,UITableViewDelegate,RecordTopViewDelegate>
@property (nonatomic,strong) UITableView *userTable;
@property (nonatomic,strong) UITableView *recordTable;
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,strong) NSMutableArray *recordlist;
@property (nonatomic,strong) RecordTopView *topView;
@property (nonatomic,strong) RecordBloodHelper *bloodHelper;
@property (nonatomic,strong) RecordBloodSugarHelper *bloodSugarHelper;
@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,copy)   NSString *userId;//当前选中用户id
@end
