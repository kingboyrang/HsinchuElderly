//
//  RecordTimeView.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "RecordTimeView.h"
#import "NSDate+TPCategory.h"
@implementation RecordTimeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (NSString*)timeValue{
   return [self.dateForFormat stringFromDate:self.timePicker.date];
}
- (void)setSelectedValue:(NSString*)val{
    NSString *str1=[[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
    NSString *time=[NSString stringWithFormat:@"%@ %@",str1,val];
    [self.timePicker setDate:[NSDate dateFromString:time withFormat:@"yyyy-MM-dd HH:mm"] animated:YES];
}
- (void)defaultInitParams{
    if (DeviceIsPad) {
        self.labTime.font=default18DeviceFont;
    }
    self.labTime.textColor=defaultDeviceFontColor;
    //設定日曆格式
    self.dateForFormat=[[NSDateFormatter alloc] init];
    [self.dateForFormat setDateFormat:@"HH:mm"];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r=self.timePicker.frame;
    r.size.width=self.bounds.size.width;
    self.timePicker.frame=r;
    
    r=self.labTime.frame;
    if (DeviceIsPad) {
        CGSize size=[self.labTime.text textSize:self.labTime.font withWidth:self.bounds.size.width];
        r.size=size;
    }
    r.origin.x=(self.bounds.size.width-r.size.width)/2;
    self.labTime.frame=r;
}
@end
