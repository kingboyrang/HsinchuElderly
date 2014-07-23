//
//  TKCalendarTimeCell.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/22.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TKCalendarTimeCell.h"

@implementation TKCalendarTimeCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    self.backgroundColor=[UIColor clearColor];
    NSArray *dateNib = [[NSBundle mainBundle] loadNibNamed:@"RecordCalendarView" owner:nil options:nil];
    _calendarView=(RecordCalendarView*)[dateNib objectAtIndex:0];
    [self.contentView addSubview:_calendarView];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RecordTimeView" owner:nil options:nil];
    self.timeView=(RecordTimeView*)[nib objectAtIndex:0];
    [self.contentView addSubview:_timeView];
    [self.timeView defaultInitParams];
    
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r=self.bounds;
    r.size.width=r.size.width/2+10;
    r.size.height=200;
    _calendarView.frame=r;
    
    
    r=self.bounds;
    r.size.width=r.size.width/2-10;
    r.origin.x=_calendarView.frame.size.width+10;
    r.size.height=195;
    _timeView.frame=r;
}

@end
