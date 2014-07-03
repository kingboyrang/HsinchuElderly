//
//  RecordBloodSugarView.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "RecordBloodSugarView.h"

@implementation RecordBloodSugarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /***
         3.	”早餐前血糖”、”早餐後血糖” 、”午餐前血糖” 、”午餐後血糖” 、”晚餐前血糖” 、”晚餐後血糖”
         **/
    }
    return self;
}
- (NSString*)bloodValue{
    NSInteger row=[self.timePicker selectedRowInComponent:0];
    return [NSString stringWithFormat:@"%d",row];
}
- (BOOL)hasValue{
    if ([[self.sugarField.text Trim] length]>0) {
        return YES;
    }
    return NO;
}
- (void)defaultInitControl{
    self.labTime.textColor=defaultDeviceFontColor;
    self.labSugar.textColor=defaultDeviceFontColor;
}
- (void)setSelectedValue:(NSString*)val{
    NSInteger v=[val integerValue];
    [self.timePicker selectRow:v inComponent:0 animated:NO];
}
#pragma mark - UITextFieldDelegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // return NO to not change text
    if(strlen([textField.text UTF8String]) >= 3 && range.length != 1)
        return NO;
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark -
#pragma mark UIPickerView DataSource Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pv numberOfRowsInComponent:(NSInteger)component
{
	return [SugarSource count];
}
#pragma mark Picker Delegate Methods
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return SugarSource[row];
}
@end
