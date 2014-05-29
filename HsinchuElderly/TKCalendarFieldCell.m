//
//  TKCalendarFieldCell.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/29.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TKCalendarFieldCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation TKCalendarFieldCell

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
    CGRect r=CGRectMake(10, (self.frame.size.height-35)/2, self.frame.size.width-10*2, 35);
    _calendar.frame=r;
}

@end
