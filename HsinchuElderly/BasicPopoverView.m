//
//  BasicPopoverView.m
//  HsinchuElderly
//
//  Created by aJia on 2014/6/16.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "BasicPopoverView.h"
#import <QuartzCore/QuartzCore.h>

@interface BasicPopoverView ()
@property (nonatomic,strong) UIView *winBgView;
@end

@implementation BasicPopoverView

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
        labTitle.textColor=defaultDeviceFontColor;
        labTitle.font=default18DeviceFont;
        labTitle.text=@"提醒";
        [self addSubview:labTitle];
        
        UILabel *labLine=[[UILabel alloc] initWithFrame:CGRectMake(0, 40, frame.size.width, 2)];
        labLine.backgroundColor=defaultDeviceFontColor;
        [self addSubview:labLine];
        
        CGFloat topY=labLine.frame.origin.y+labLine.frame.size.height+10;
        NSString *memo=@"親愛的王大明,吃腸胃藥了嗎?";
        CGSize size=[memo textSize:default18DeviceFont withWidth:frame.size.width-10*2];
        _labMessage=[[UILabel alloc] initWithFrame:CGRectMake(10, topY, frame.size.width-10*2, size.height)];
        _labMessage.backgroundColor=[UIColor clearColor];
        _labMessage.textColor=[UIColor blackColor];
        _labMessage.font=default18DeviceFont;
        _labMessage.text=memo;
        _labMessage.numberOfLines=0;
        _labMessage.lineBreakMode=NSLineBreakByWordWrapping;
        [self addSubview:_labMessage];
        
        topY+=size.height+10;
        _cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame=CGRectMake(0, topY, frame.size.width/2, 40);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:defaultDeviceFontColor forState:UIControlStateNormal];
        _cancelButton.titleLabel.font=default18DeviceFont;
        [_cancelButton addTarget:self action:@selector(buttonHideClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelButton];
        
        _confirmButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.frame=CGRectMake(frame.size.width/2, topY, frame.size.width/2, 40);
        [_confirmButton setTitle:@"確認" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:defaultDeviceFontColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font=default18DeviceFont;
        [_confirmButton addTarget:self action:@selector(buttonConfirmClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_confirmButton];
        
        CGRect r=self.frame;
        r.size.height=_confirmButton.frame.origin.y+_confirmButton.frame.size.height;
        self.frame=r;
        
        _winBgView=[[UIView alloc] initWithFrame:DeviceRect];
        _winBgView.backgroundColor=[UIColor grayColor];
        _winBgView.alpha=0.5;
    }
    return self;
}
- (void)setMessage:(NSString*)message{
    CGSize size=[message textSize:default18DeviceFont withWidth:self.bounds.size.width-10*2];
    CGRect r=_labMessage.frame;
    r.size.height=size.height;
    _labMessage.text=message;
    _labMessage.frame=r;
    
    CGFloat topY=_labMessage.frame.size.height+10+_labMessage.frame.origin.y;
    r=_cancelButton.frame;
    r.origin.y=topY;
    _cancelButton.frame=r;
    
    r=_confirmButton.frame;
    r.origin.y=topY;
    _confirmButton.frame=r;
    
    r=self.frame;
    r.size.height=_confirmButton.frame.origin.y+_confirmButton.frame.size.height;
    self.frame=r;
    //setNeedsDisplay方便绘图，而layoutSubViews方便出来数据。
    [self setNeedsDisplay];
}
- (void)addCustomView:(UIView*)view{
    CGFloat topY=_labMessage.frame.size.height+10+_labMessage.frame.origin.y;
    CGRect r=view.frame;
    r.origin.y=topY;
    r.origin.x=0;
    
    view.frame=r;
    [self addSubview:view];
    
    topY=r.size.height+10+r.origin.y;
    r=_cancelButton.frame;
    r.origin.y=topY;
    _cancelButton.frame=r;
    
    r=_confirmButton.frame;
    r.origin.y=topY;
    _confirmButton.frame=r;
    
    r=self.frame;
    r.size.height=_confirmButton.frame.origin.y+_confirmButton.frame.size.height;
    self.frame=r;
    //setNeedsDisplay方便绘图，而layoutSubViews方便出来数据。
    [self setNeedsDisplay];
}

//取消
- (void)buttonHideClick:(UIButton*)btn{
    [self hide];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(canclePopoverWithTarget:)]) {
        [self.delegate canclePopoverWithTarget:self];
    }
}
//確認
- (void)buttonConfirmClick:(UIButton*)btn{
    [self hide];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(confirmPopoverWithTarget:)]) {
        [self.delegate confirmPopoverWithTarget:self];
    }
}
#pragma mark - show/hide
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
