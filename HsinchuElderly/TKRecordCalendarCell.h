//
//  TKRecordCalendarCell.h
//  HsinchuElderly
//
//  Created by aJia on 2014/6/17.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRGCalendarView.h"
@interface TKRecordCalendarCell : UITableViewCell
@property (nonatomic,strong) VRGCalendarView *calendarView;
@property (nonatomic,assign) CGFloat cellHeight;
@end
