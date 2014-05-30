//
//  TKHEItemCell.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/30.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TKHEItemCell.h"

@interface TKHEItemCell ()
@property (nonatomic,strong) UIButton *arrowButton;
@end

@implementation TKHEItemCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
   
    
    UIImage *rightImg=[UIImage imageNamed:@"arrow_right.png"];
    _arrowButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _arrowButton.frame=CGRectMake(0, 0, rightImg.size.width, rightImg.size.height);
    [_arrowButton setBackgroundImage:rightImg forState:UIControlStateNormal];
    [self.contentView addSubview:_arrowButton];
    
    
    _labName = [[UILabel alloc] initWithFrame:CGRectZero];
	_labName.backgroundColor = [UIColor clearColor];
    _labName.textColor = defaultDeviceFontColor;
    _labName.font = [UIFont fontWithName:defaultDeviceFontName size:18];
    _labName.numberOfLines = 0;
    _labName.lineBreakMode=NSLineBreakByWordWrapping;
	
	[self.contentView addSubview:_labName];
    
    _labDistance = [[UILabel alloc] initWithFrame:CGRectZero];
	_labDistance.backgroundColor = [UIColor clearColor];
    _labDistance.textColor = defaultDeviceFontColor;
    _labDistance.font = [UIFont fontWithName:defaultDeviceFontName size:14];
    _labDistance.numberOfLines = 0;
    _labDistance.lineBreakMode=NSLineBreakByWordWrapping;
	
	[self.contentView addSubview:_labDistance];
    
    
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat leftX=10,topY=10;
    CGFloat w=self.frame.size.width-leftX-_arrowButton.frame.size.width-5-2;
    CGSize size=[_labName.text textSize:_labName.font withWidth:w];
    _labName.frame=CGRectMake(leftX, topY, size.width, size.height);
    
    topY=_labName.frame.origin.y+size.height+5;
    size=[_labDistance.text textSize:_labDistance.font withWidth:w];
    _labDistance.frame=CGRectMake(leftX, topY, size.width, size.height);
    
    CGRect r=_arrowButton.frame;
    r.origin.y=(self.frame.size.height-r.size.height)/2;
    r.origin.x=self.frame.size.width-r.size.width-5;
    _arrowButton.frame=r;
    
}

@end
