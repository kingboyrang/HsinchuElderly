//
//  ShrinkPickerView.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "ShrinkPickerView.h"

@implementation ShrinkPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pickView.showsSelectionIndicator=YES;
       
        //[self defaultSelectedPicker];
    }
    return self;
}
- (NSString*)diastolicValue{
    NSInteger row=[self.pickView selectedRowInComponent:0];
    return [NSString stringWithFormat:@"%d",row];
}
- (NSString*)shrinkValue{
    NSInteger row=[self.pickView selectedRowInComponent:1];
    return [NSString stringWithFormat:@"%d",row];
}
- (NSString*)pulseValue{
    NSInteger row=[self.pickView selectedRowInComponent:2];
    return [NSString stringWithFormat:@"%d",row];
}
- (void)setSelectedValue:(NSString*)val component:(NSInteger)row{
    NSInteger v=[val integerValue];
    [self.pickView selectRow:v inComponent:row animated:NO];
}
- (void)defaultSelectedPicker{
    if (DeviceIsPad) {
        self.lab1.font=default18DeviceFont;
        self.lab2.font=default18DeviceFont;
        self.lab3.font=default18DeviceFont;
    }
    self.lab1.textColor=defaultDeviceFontColor;
    self.lab2.textColor=defaultDeviceFontColor;
    self.lab3.textColor=defaultDeviceFontColor;
    [self.pickView selectRow:120 inComponent:0 animated:NO];
    [self.pickView selectRow:80 inComponent:1 animated:NO];
    [self.pickView selectRow:70 inComponent:2 animated:NO];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r=self.pickView.frame;
    r.size.width=self.bounds.size.width;
    self.pickView.frame=r;
    
    r=self.lab1.frame;
    r.origin.x=DeviceIsPad?110:20;
    if (DeviceIsPad) {
        CGSize size=[self.lab1.text textSize:self.lab1.font withWidth:self.bounds.size.width];
        r.size=size;
    }
    
    self.lab1.frame=r;
    
    r=self.lab2.frame;
    r.origin.x=(self.bounds.size.width-r.size.width)/2;
    if (DeviceIsPad) {
        CGSize size=[self.lab2.text textSize:self.lab2.font withWidth:self.bounds.size.width];
        r.size=size;
    }
    self.lab2.frame=r;
    
    r=self.lab3.frame;
    r.origin.x=self.bounds.size.width-self.lab1.frame.origin.x-r.size.width;
    if (DeviceIsPad) {
        CGSize size=[self.lab3.text textSize:self.lab3.font withWidth:self.bounds.size.width];
        r.size=size;
    }
    self.lab3.frame=r;
}
#pragma mark -
#pragma mark UIPickerView DataSource Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pv numberOfRowsInComponent:(NSInteger)component
{
    
    if (component==0) {
        return 251;
    }else if(component==1)
    {
        return 251;
    }
    
	return 201;
}
#pragma mark Picker Delegate Methods
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%d",row];
}
@end
