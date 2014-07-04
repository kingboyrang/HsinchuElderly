//
//  RecordViewController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/6/13.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordTopView.h"
#import "RecordBloodHelper.h"
#import "RecordBloodSugarHelper.h"
#import "PolygonalScrollView.h"
@interface RecordViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate,RecordTopViewDelegate>
@property (nonatomic,strong) RecordTopView *topView;//顶部view
@property (nonatomic,strong) RecordBloodHelper *bloodHelper;//血压记录操作对象
@property (nonatomic,strong) RecordBloodSugarHelper *bloodSugarHelper;//血糖记录操作对象
@property (nonatomic,strong) NSMutableArray *bloodList;//血压记录
@property (nonatomic,strong) NSMutableArray *sugarList;//血糖记录

@property (nonatomic,strong) UITableView *chartTable;//
@property (nonatomic,strong) NSMutableArray *cells;//
@property (nonatomic,strong) NSMutableArray *cellHeights;//保存表格高度
@property (nonatomic,copy)   NSString *userId;//当前选中用户id
@end
