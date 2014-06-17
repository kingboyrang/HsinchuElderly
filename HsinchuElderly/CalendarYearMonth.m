//
//  CalendarYearMonth.m
//  HsinchuElderly
//
//  Created by aJia on 2014/6/17.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "CalendarYearMonth.h"
#import "NSDate+TPCategory.h"
@implementation CalendarYearMonth

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor colorFromHexRGB:@"fc4112"];
        //左箭头
        NSString *memo=@"<";
        UIFont *font=[UIFont fontWithName:defaultDeviceFontName size:20];
        CGSize size=[memo textSize:font withWidth:frame.size.width];
        _leftArrow=[self addButtonWithTitle:memo frame:CGRectMake(20,0, size.width, frame.size.height)];
        [self addSubview:_leftArrow];
        
        //右箭头
        _rightArrow=[self addButtonWithTitle:@">" frame:CGRectMake(frame.size.width-size.width-20,0, size.width, frame.size.height)];
        [self addSubview:_rightArrow];
        
        //年與月
        NSDate *now=[NSDate date];
        TKDateInformation info=[now dateInformation];
        memo=[NSString stringWithFormat:@"%d 年 %d 月",info.year,info.month];
        size=[memo textSize:font withWidth:frame.size.width];
        
        memo=[NSString stringWithFormat:@"%d",info.year];
        CGSize size1=[memo textSize:font withWidth:frame.size.width];
        _yearButton=[self addButtonWithTitle:memo frame:CGRectMake((frame.size.width-size.width)/2, 0,size1.width, frame.size.height)];
        [self addSubview:_yearButton];
        
         memo=@" 年";
        size1=[memo textSize:font withWidth:frame.size.width];
        [self addLabelWithTitle:memo frame:CGRectMake(_yearButton.frame.origin.x+_yearButton.frame.size.width, (frame.size.height-size1.height)/2, size1.width, size1.height)];
        
        CGFloat leftX=_yearButton.frame.origin.x+_yearButton.frame.size.width+size1.width;
         memo=@"12";
         size1=[memo textSize:font withWidth:frame.size.width];
        _monthButton=[self addButtonWithTitle:[NSString stringWithFormat:@"%d",info.month] frame:CGRectMake(leftX,0, size1.width, frame.size.height)];
        [self addSubview:_monthButton];
        leftX+=size1.width;
        
        memo=@"月";
        size1=[memo textSize:font withWidth:frame.size.width];
        [self addLabelWithTitle:memo frame:CGRectMake(leftX, (frame.size.height-size1.height)/2, size1.width, size1.height)];
        
        
    }
    return self;
}
- (void)addLabelWithTitle:(NSString*)title frame:(CGRect)frame{
    UILabel *lab=[[UILabel alloc] initWithFrame:frame];
    lab.backgroundColor=[UIColor clearColor];
    lab.textColor=[UIColor whiteColor];
    lab.font=[UIFont fontWithName:defaultDeviceFontName size:20];
    lab.text=title;
    lab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:lab];
}
- (UIButton*)addButtonWithTitle:(NSString*)title frame:(CGRect)frame{
   UIFont *font=[UIFont fontWithName:defaultDeviceFontName size:20];
   UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    btn.showsTouchWhenHighlighted=YES;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font=font;
    return btn;
}
@end
