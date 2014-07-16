//
//  RecordCalendarView.h
//  HsinchuElderly
//
//  Created by aJia on 2014/7/15.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordCalendarView : UIView
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property(nonatomic,retain) NSDateFormatter *dateForFormat;
@property (nonatomic,readonly) NSString *calendarValue;
//设置值选中
- (void)setSelectedValue:(NSString*)val;
@end
