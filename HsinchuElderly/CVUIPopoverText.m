//
//  CVUIPopoverText.m
//  CalendarDemo
//
//  Created by rang on 13-3-12.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CVUIPopoverText.h"
@implementation CVUIPopoverText
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //Text顯示日期
        _field=[[UITextField alloc] initWithFrame:self.bounds];
        _field.borderStyle=UITextBorderStyleRoundedRect;
        _field.placeholder=@"請選擇";
        _field.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//設定垂直置中
        _field.enabled=NO;//設定不可以編輯
        _field.font=[UIFont systemFontOfSize:14];
        //設定按钮
        _button=[UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame=self.bounds;
        
        [self addSubview:_field];
        [self addSubview:_button];
        
        frame.origin.x=0;
        frame.origin.y=0;
        self.frame=frame;
    }
    return self;
}
- (void) layoutSubviews{
    [super layoutSubviews];
    _field.frame=self.bounds;
    _button.frame=self.bounds;
}
@end
