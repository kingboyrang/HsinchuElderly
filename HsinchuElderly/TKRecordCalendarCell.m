//
//  TKRecordCalendarCell.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/15.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TKRecordCalendarCell.h"

@implementation TKRecordCalendarCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
   
    self.backgroundColor=[UIColor clearColor];
    NSArray *dateNib = [[NSBundle mainBundle] loadNibNamed:@"RecordCalendarView" owner:nil options:nil];
    _calendarView=(RecordCalendarView*)[dateNib objectAtIndex:0];
    [self.contentView addSubview:_calendarView];
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r=self.bounds;
    r.size.height=200;
    _calendarView.frame=r;
}
@end
