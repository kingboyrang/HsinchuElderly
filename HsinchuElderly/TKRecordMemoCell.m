//
//  TKRecordMemoCell.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/9.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TKRecordMemoCell.h"

@implementation TKRecordMemoCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    _labMemo1=[[UILabel alloc] initWithFrame:CGRectZero];
    _labMemo1.backgroundColor=[UIColor clearColor];
    _labMemo1.textColor=[UIColor blackColor];
    _labMemo1.font=[UIFont fontWithName:defaultDeviceFontName size:18];
    _labMemo1.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_labMemo1];
    
    _labMemo2=[[UILabel alloc] initWithFrame:CGRectZero];
    _labMemo2.backgroundColor=[UIColor clearColor];
    _labMemo2.textColor=[UIColor blackColor];
    _labMemo2.font=[UIFont fontWithName:defaultDeviceFontName size:18];
    _labMemo2.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_labMemo2];

    self.backgroundColor=[UIColor clearColor];
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w=self.bounds.size.width-20;
    CGSize size=[_labMemo1.text textSize:_labMemo1.font withWidth:w];
    _labMemo1.frame=CGRectMake(10, 5, size.width, size.height);
    size=[_labMemo2.text textSize:_labMemo2.font withWidth:w];
    _labMemo2.frame=CGRectMake(10, _labMemo1.frame.origin.y+_labMemo1.frame.size.height+2, size.width, size.height);
    
}
@end
