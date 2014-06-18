//
//  RecordViewController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/6/13.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordRemindHelper.h"
#import "VRGCalendarView.h"
@interface RecordViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate,VRGCalendarViewDelegate>
@property (nonatomic,strong) UITableView *userTable;
@property (nonatomic,strong) NSMutableArray *cells;
@property (nonatomic,strong) RecordRemindHelper *recordHelper;
@property (nonatomic,strong) VRGCalendarView *recordCalendarView;
@property (nonatomic,copy)   NSString *recordType;
@end
