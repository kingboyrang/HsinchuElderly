//
//  BloodPopoverView.m
//  HsinchuElderly
//
//  Created by aJia on 2014/6/16.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "BloodPopoverView.h"
#import <QuartzCore/QuartzCore.h>
#import "AlertHelper.h"
@implementation BloodPopoverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleKeyboardWillShowHideNotification:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleKeyboardWillShowHideNotification:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    return self;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - Notifications
- (void)handleKeyboardWillShowHideNotification:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    //取得鍵盤的大小
    CGRect kbFrame = [[info valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) {//顯示鍵盤
        
        if (!DeviceIsPad) {
            CGRect r=self.frame;
            r.origin.y=DeviceRect.size.height-kbFrame.size.height-r.size.height;
            
            NSNumber *curve = [info objectForKey:UIKeyboardAnimationCurveUserInfoKey];
            NSNumber *duration = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
            // 增加移動動畫，使View跟隨鍵盤移動
            [UIView animateWithDuration:duration.doubleValue animations:^{
                [UIView setAnimationBeginsFromCurrentState:YES];
                [UIView setAnimationCurve:[curve intValue]];
                self.frame=r;
            }];
        }
    }
    else  {//隱藏鍵盤
        CGRect r=self.frame;
        r.origin.y=(DeviceRect.size.height-r.size.height)/2;
        [UIView animateWithDuration:[[info valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
            self.frame=r;
        }];
    }
}
//重寫取消事件
- (void)buttonHideClick:(UIButton *)btn{
    [self showWithUploadHide:nil];
    _field1.text=@"";
    _field2.text=@"";
    [_field1 resignFirstResponder];
    [_field2 resignFirstResponder];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(canclePopoverWithTarget:)]) {
        [self.delegate canclePopoverWithTarget:self];
    }
}
//重寫確認事件
- (void)buttonConfirmClick:(UIButton*)btn{
    if ([[_field1.text Trim] length]==0) {
        [AlertHelper initWithTitle:@"提示" message:@"舒張壓不為空!"];
        return;
    }
    if ([[_field2.text Trim] length]==0) {
        [AlertHelper initWithTitle:@"提示" message:@"收縮壓不為空!"];
        return;
    }
    [self showWithUploadHide:^{
        if (self.delegate&&[self.delegate respondsToSelector:@selector(confirmPopoverWithTarget:)]) {
            [self.delegate confirmPopoverWithTarget:self];
        }
        _field1.text=@"";
        _field2.text=@"";
    }];
}
- (void)setMessage:(NSString *)message{
    [super setMessage:message];
    //自定義view
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 80)];
    view.backgroundColor=[UIColor clearColor];
    [self addRowWithTitle:@"舒張壓" top:0 withInnerView:view];
    [self addRowWithTitle:@"收縮壓" top:45 withInnerView:view];
    [self addCustomView:view];
    
    CGRect r=self.frame;
    r.origin.y=-r.size.height;
    self.frame=r;
}
//添加輸入
- (void)addRowWithTitle:(NSString*)title top:(CGFloat)topY withInnerView:(UIView*)view{
    CGSize size=[title textSize:default18DeviceFont withWidth:self.bounds.size.width-20];
    UILabel *lab1=[[UILabel alloc] initWithFrame:CGRectMake(10,(35-size.height)/2+topY, size.width,size.height)];
    lab1.backgroundColor=[UIColor clearColor];
    lab1.text=title;
    lab1.font=default18DeviceFont;
    [view addSubview:lab1];
    
    NSString *memo=@"mmHg";
    CGSize size1=[memo textSize:default18DeviceFont withWidth:self.bounds.size.width-20];
    CGFloat w=self.bounds.size.width-lab1.frame.size.width-lab1.frame.origin.x*2-size1.width-4;
    
   UITextField *_field=[[UITextField alloc] initWithFrame:CGRectMake(lab1.frame.size.width+lab1.frame.origin.x+2, topY, w, 35)];
    _field.borderStyle=UITextBorderStyleRoundedRect;
    _field.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    _field.layer.borderColor=[UIColor colorFromHexRGB:@"fc8600"].CGColor;
    _field.layer.borderWidth=2.0;
    _field.layer.cornerRadius=8.0;
    _field.layer.masksToBounds=YES;
    _field.font=default18DeviceFont;
    _field.delegate=self;
   // _field.keyboardType=UIKeyboardTypeNumberPad;
    [view addSubview:_field];
    if (topY==0) {
        _field.placeholder=@"請輸入舒張壓";
        _field1=_field;
    }else{
         _field.placeholder=@"請輸入收縮壓";
        _field2=_field;
    }
    
    UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(_field1.frame.origin.x+_field1.frame.size.width+2,(35-size1.height)/2+topY, size1.width, size1.height)];
    lab2.backgroundColor=[UIColor clearColor];
    lab2.text=memo;
     lab2.font=default18DeviceFont;
    [view addSubview:lab2];
}
#pragma mark -UITextFieldDelegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    BOOL boo=YES;
    if (_field1==textField||_field2==textField) {
        if(strlen([textField.text UTF8String]) >= 20 && range.length != 1)
            boo=NO;
    }
    return boo;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
