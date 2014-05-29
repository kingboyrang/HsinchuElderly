//
//  TKTextFieldCell.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/29.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TKTextFieldCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation TKTextFieldCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    _field=[[UITextField alloc] initWithFrame:CGRectZero];
    _field.borderStyle=UITextBorderStyleRoundedRect;
    _field.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    _field.layer.borderColor=[UIColor colorFromHexRGB:@"fc8600"].CGColor;
    _field.layer.borderWidth=2.0;
    _field.layer.cornerRadius=8.0;
    _field.layer.masksToBounds=YES;
    _field.font=defaultBDeviceFont;
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
    CGRect r=CGRectMake(10, (self.frame.size.height-35)/2, self.frame.size.width-10*2, 35);
    _field.frame=r;
}
@end
