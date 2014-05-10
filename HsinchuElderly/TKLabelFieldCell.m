//
//  TKLabelFieldCell.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/8.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TKLabelFieldCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation TKLabelFieldCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    _field=[[UITextField alloc] initWithFrame:CGRectZero];
    _field.borderStyle=UITextBorderStyleRoundedRect;
    _field.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    _field.layer.borderColor=[UIColor colorFromHexRGB:@"fc8600"].CGColor;
    _field.layer.borderWidth=2.0;
    _field.layer.cornerRadius=8.0;
    _field.layer.masksToBounds=YES;
    _field.font=defaultSDeviceFont;
    _field.delegate=self;
    [self.contentView addSubview:_field];
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (BOOL)hasValue{
    if ([[_field.text Trim] length]>0) {
        return YES;
    }
    return NO;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r=self.label.frame;
    r.origin.x+=r.size.width+2;
    r.size.height=35;
    r.origin.y=(self.frame.size.height-r.size.height)/2;
    r.size.width=self.frame.size.width-10-r.origin.x;
    
    _field.frame=r;
}
@end
