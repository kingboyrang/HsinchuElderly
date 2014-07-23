//
//  TKCalendarTimeCell.h
//  HsinchuElderly
//
//  Created by aJia on 2014/7/22.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordCalendarView.h"
#import "RecordTimeView.h"
@interface TKCalendarTimeCell : UITableViewCell
@property (nonatomic,strong) RecordCalendarView *calendarView;
@property (nonatomic,strong) RecordTimeView *timeView;
@end
