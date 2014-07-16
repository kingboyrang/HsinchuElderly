//
//  RecordBloodSugarController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordBloodSugarView.h"
#import "RecordTimeView.h"
#import "RecordBloodSugarHelper.h"
@interface RecordBloodSugarController : BasicViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *bloodTable;
@property (nonatomic,strong) NSMutableArray *cells;
@property (nonatomic,strong) RecordBloodSugarHelper *bloodSugarHelper;
@property (nonatomic,strong) RecordBloodSugar *Entity;
@property (nonatomic,assign) int operType;//1表示新增 2:修改
@property (nonatomic,copy)   NSString *userId;//当前选中用户id
@end
