//
//  UploadAlertView.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/31.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "UploadAlertView.h"
#import <QuartzCore/QuartzCore.h>
#import "AlertHelper.h"

@interface UploadAlertView ()
- (void)showWithUploadHide:(void(^)())completed;
@end

@implementation UploadAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.layer.borderWidth=2.0;
        self.layer.borderColor=[UIColor whiteColor].CGColor;
        self.layer.cornerRadius=5.0;
        self.layer.masksToBounds=YES;
        self.alpha=1.0;
        
        UILabel *labTitle=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, frame.size.width-10, 30)];
        labTitle.backgroundColor=[UIColor clearColor];
        labTitle.textColor=[UIColor colorFromHexRGB:@"2da6de"];
        labTitle.font=default18DeviceFont;
        labTitle.text=@"填寫抽獎資料";
        [self addSubview:labTitle];
        
        UILabel *labLine=[[UILabel alloc] initWithFrame:CGRectMake(0, 40, frame.size.width, 2)];
        labLine.backgroundColor=[UIColor colorFromHexRGB:@"2da6de"];
        [self addSubview:labLine];
        
        CGFloat topY=labLine.frame.origin.y+labLine.frame.size.height+5;
        NSString *memo=@"請填寫照片標題及電子郵件，以便得獎時聯絡您。";
        CGSize size=[memo textSize:default18DeviceFont withWidth:self.bounds.size.width-10*2];
        UILabel *labMemo=[[UILabel alloc] initWithFrame:CGRectMake(10, topY, frame.size.width-10*2, size.height)];
        labMemo.backgroundColor=[UIColor clearColor];
        labMemo.textColor=[UIColor blackColor];
        labMemo.font=default18DeviceFont;
        labMemo.text=memo;
        labMemo.numberOfLines=0;
        labMemo.lineBreakMode=NSLineBreakByWordWrapping;
        [self addSubview:labMemo];
        
        topY=labMemo.frame.origin.y+size.height+10;
        _fieldTitle=[[UITextField alloc] initWithFrame:CGRectMake(10, topY, frame.size.width-10*2, 35)];
        _fieldTitle.placeholder=@"請輸入圖片標題";
        _fieldTitle.borderStyle=UITextBorderStyleNone;
        _fieldTitle.delegate=self;
        [self addSubview:_fieldTitle];
        
        topY+=_fieldTitle.frame.size.height+1;
        UILabel *labLine1=[[UILabel alloc] initWithFrame:CGRectMake(10, topY, _fieldTitle.frame.size.width, 1)];
        labLine1.backgroundColor=[UIColor colorFromHexRGB:@"2da6de"];
        [self addSubview:labLine1];
        
        
        topY+=labLine1.frame.size.height+10;
        _fieldEmail=[[UITextField alloc] initWithFrame:CGRectMake(10, topY, frame.size.width-10*2, 35)];
        _fieldEmail.placeholder=@"請輸入您的電子郵件";
        _fieldEmail.borderStyle=UITextBorderStyleNone;
         _fieldEmail.delegate=self;
        [self addSubview:_fieldEmail];
        
        topY+=_fieldEmail.frame.size.height+1;
        UILabel *labLine2=[[UILabel alloc] initWithFrame:CGRectMake(10, topY, _fieldEmail.frame.size.width, 1)];
        labLine2.backgroundColor=[UIColor colorFromHexRGB:@"2da6de"];
        [self addSubview:labLine2];
        
        topY+=labLine2.frame.size.height+10;
        _cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame=CGRectMake(0, topY, frame.size.width/2, 40);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font=default18DeviceFont;
        [_cancelButton addTarget:self action:@selector(buttonHideClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelButton];
        
        _confirmButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.frame=CGRectMake(frame.size.width/2, topY, frame.size.width/2, 40);
        [_confirmButton setTitle:@"上傳" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _confirmButton.titleLabel.font=default18DeviceFont;
        [_confirmButton addTarget:self action:@selector(buttonUploadClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_confirmButton];
        
        CGRect r=self.frame;
        r.size.height=_confirmButton.frame.origin.y+_confirmButton.frame.size.height;
        self.frame=r;
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleKeyboardWillShowHideNotification:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleKeyboardWillShowHideNotification:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
        _winBgView=[[UIView alloc] initWithFrame:DeviceRect];
        _winBgView.backgroundColor=[UIColor grayColor];
        _winBgView.alpha=0.5;
    }
    return self;
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
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark -UITextFieldDelegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    BOOL boo=YES;
    if (_fieldTitle==textField) {
        if(strlen([textField.text UTF8String]) >= 50 && range.length != 1)
            boo=NO;
    }
    if (_fieldEmail==textField) {
        if(strlen([textField.text UTF8String]) >= 100 && range.length != 1)
            boo=NO;
    }
    return boo;
}
- (void)buttonHideClick:(UIButton*)btn{
    [self hide];
}
//上傳
- (void)buttonUploadClick:(UIButton*)btn{
    if ([[_fieldTitle.text Trim] length]==0) {
        [AlertHelper initWithTitle:@"提示" message:@"請輸入圖片標題！"];
        return;
    }
    if ([[_fieldEmail.text Trim] length]==0) {
        [AlertHelper initWithTitle:@"提示" message:@"請輸入電子郵件！"];
        return;
    }
    if (![_fieldEmail.text isEmail]) {
        [AlertHelper initWithTitle:@"提示" message:@"電子郵件格式錯誤，請重新輸入！"];
        return;
    }
    [self showWithUploadHide:^{
        if (self.delegate&&[self.delegate respondsToSelector:@selector(startUploadImage)]) {
            [self.delegate startUploadImage];
        }
    }];
    
}
- (void)showWithUploadHide:(void(^)())completed{
    CGRect r=self.frame;
    r.origin.y=-r.size.height;
    [UIView animateWithDuration:0.5f animations:^{
        self.frame=r;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
            [_winBgView removeFromSuperview];
            if (completed) {
                completed();
            }
        }
    }];
}
- (void)show{
    CGRect r=self.frame;
    r.origin.y=-r.size.height;
    r.origin.x=(_winBgView.frame.size.width-r.size.width)/2;
    
    
    UIApplication *app=[UIApplication sharedApplication];
    UIWindow *window=[app keyWindow];
    [window addSubview:_winBgView];
    [window addSubview:self];
    
    r.origin.y=(_winBgView.frame.size.height-r.size.height)/2;
    [UIView animateWithDuration:0.5f animations:^{
        self.frame=r;
    }];
}
- (void)hide{
    [self showWithUploadHide:nil];
    _fieldTitle.text=@"";
    _fieldEmail.text=@"";
    /***
    CGRect r=self.frame;
    r.origin.y=-r.size.height;
    [UIView animateWithDuration:0.5f animations:^{
        self.frame=r;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
            [_winBgView removeFromSuperview];
        }
    }];
     ***/
}
- (void)drawRect:(CGRect)rect{
    UIColor *lineColor=[UIColor colorFromHexRGB:@"b6b6b6"];
    CGContextRef ctx =UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, lineColor.CGColor);
    CGContextSetLineWidth(ctx,0.55);
    CGContextBeginPath(ctx);
    //畫橫線
    CGContextMoveToPoint(ctx, 0,rect.size.height-40);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height-40);
    
    //畫書線
    CGContextMoveToPoint(ctx, rect.size.width/2,rect.size.height-40);
    CGContextAddLineToPoint(ctx, rect.size.width/2, rect.size.height);

   
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
}
@end
