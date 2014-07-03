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
    self.labTime.textColor=defaultDeviceFontColor;
    //設定日曆格式
    self.dateForFormat=[[NSDateFormatter alloc] init];
    [self.dateForFormat setDateFormat:@"HH:mm"];
}
@end
