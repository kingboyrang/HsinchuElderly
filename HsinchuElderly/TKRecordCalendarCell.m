//
//  TKRecordCalendarCell.m
//  HsinchuElderly
//
//  Created by aJia on 2014/6/17.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TKRecordCalendarCell.h"

@implementation TKRecordCalendarCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    _calendarView = [[VRGCalendarView alloc] init];
	[self.contentView addSubview:_calendarView];
    
    self.cellHeight=296.0f;
    
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}


- (void) layoutSubviews {
    [super layoutSubviews];
    CGRect r=_calendarView.frame;
    r.origin.x=(self.frame.size.width-r.size.width)/2;
    _calendarView.frame=r;
}
@end
