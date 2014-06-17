//
//  RecordCalendar.h
//  HsinchuElderly
//
//  Created by aJia on 2014/6/17.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarYearMonth.h"
@interface RecordCalendar : UIView
@property (nonatomic,strong) CalendarYearMonth *calendarTop;
@property (nonatomic,retain) NSDate *currentDate;
@property (nonatomic,assign) NSInteger rowCount;//表格行总数
@end
