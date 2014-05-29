//
//  TKSelectFieldCell.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/29.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TKSelectFieldCell.h"

@implementation TKSelectFieldCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    _select=[[CVUISelect alloc] initWithFrame:CGRectZero];
    _select.popText.field.layer.borderColor=[UIColor colorFromHexRGB:@"fc8600"].CGColor;
    _select.popText.field.layer.borderWidth=2.0;
    _select.popText.field.layer.cornerRadius=8.0;
    _select.popText.field.layer.masksToBounds=YES;
    [self.contentView addSubview:_select];
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r=CGRectMake(10, (self.frame.size.height-35)/2, self.frame.size.width-10*2, 35);
    _select.frame=r;
}
@end
