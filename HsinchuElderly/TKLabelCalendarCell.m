//
//  TKLabelCalendarCell.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TKLabelCalendarCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation TKLabelCalendarCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    _calendar=[[CVUICalendar alloc] initWithFrame:CGRectZero];
    _calendar.popText.field.layer.borderColor=[UIColor colorFromHexRGB:@"fc8600"].CGColor;
    _calendar.popText.field.layer.borderWidth=2.0;
    _calendar.popText.field.layer.cornerRadius=8.0;
    _calendar.popText.field.layer.masksToBounds=YES;
    [self.contentView addSubview:_calendar];
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r=self.label.frame;
    r.origin.x+=r.size.width+2;
    r.size.height=35;
    r.origin.y=(self.frame.size.height-r.size.height)/2;
    r.size.width=self.frame.size.width-10-r.origin.x;
    
    _calendar.frame=r;
}
@end
