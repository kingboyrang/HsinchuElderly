//
//  TKLabelSegmentCell.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/8.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TKLabelSegmentCell.h"

@implementation TKLabelSegmentCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    _segmented=[[HESegmentControl alloc] initWithFrame:CGRectMake(0, 0, 190, 35)];
    [_segmented insertSegmentWithTitle:@"是" withIndex:0];
    [_segmented insertSegmentWithTitle:@"否" withIndex:1];
    [self.contentView addSubview:_segmented];
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
    r.size.width=190;
    
    _segmented.frame=r;
}
@end
