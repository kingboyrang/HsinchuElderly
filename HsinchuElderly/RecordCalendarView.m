//
//  RecordCalendarView.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/15.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "RecordCalendarView.h"
#import "NSDate+TPCategory.h"
@implementation RecordCalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}
- (NSString*)calendarValue{
    if (!self.dateForFormat) {
        //設定日曆格式
        self.dateForFormat=[[NSDateFormatter alloc] init];
        [self.dateForFormat setDateFormat:@"yyyy-MM-dd"];
    }
    return [self.dateForFormat stringFromDate:self.datePicker.date];
}
- (void)setSelectedValue:(NSString*)val{
    if (!self.dateForFormat) {
        //設定日曆格式
        self.dateForFormat=[[NSDateFormatter alloc] init];
        [self.dateForFormat setDateFormat:@"yyyy-MM-dd"];
    }
    [self.datePicker setDate:[NSDate dateFromString:val withFormat:@"yyyy-MM-dd"] animated:YES];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (DeviceIsPad) {
        self.labTitle.font=default18DeviceFont;
    }
     self.labTitle.textColor=defaultDeviceFontColor;
    CGRect r=self.labTitle.frame;
    if (DeviceIsPad) {
        CGSize size=[self.labTitle.text textSize:self.labTitle.font withWidth:self.bounds.size.width];
        r.size=size;
    }
    r.origin.x=(self.frame.size.width-r.size.width)/2;
    self.labTitle.frame=r;
    
    r=self.datePicker.frame;
    r.origin.x=(self.frame.size.width-r.size.width)/2;
    self.datePicker.frame=r;
}
@end
