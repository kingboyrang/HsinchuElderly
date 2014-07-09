//
//  TKChartRecordCell.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/4.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TKChartRecordCell.h"

@implementation TKChartRecordCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    _labTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 44)];
    _labTitle.backgroundColor=[UIColor clearColor];
    _labTitle.textColor=[UIColor blackColor];
    _labTitle.font=[UIFont fontWithName:defaultDeviceFontName size:20];
    _labTitle.textAlignment=NSTextAlignmentCenter;
    
    [self.contentView addSubview:_labTitle];
    
    _charScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(10,_labTitle.frame.size.height, self.bounds.size.width-10, 290)];
    _charScrollView.pagingEnabled=YES;
    _charScrollView.showsHorizontalScrollIndicator=YES;
    _charScrollView.showsVerticalScrollIndicator=NO;
    _charScrollView.backgroundColor=[UIColor clearColor];
    _chart=[[ChartView alloc] initWithFrame:CGRectMake(0, 0, _charScrollView.frame.size.width, _charScrollView.frame.size.height)];
    [_charScrollView addSubview:_chart];
    [self.contentView addSubview:_charScrollView];
    
    self.backgroundColor=[UIColor clearColor];
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r=self.chart.frame;
    self.charScrollView.contentSize=CGSizeMake(r.size.width, r.size.height);
    CGRect r1=self.charScrollView.frame;
    r1.size.height=r.size.height;
    self.charScrollView.frame=r1;
}
@end
