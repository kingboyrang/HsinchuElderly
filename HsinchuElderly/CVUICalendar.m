//
//  CVUICalendar.m
//  CalendarDemo
//
//  Created by rang on 13-3-11.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CVUICalendar.h"

@interface CVUICalendar()
-(void)loadControl:(CGRect)frame;
-(void)setCalendarValue;
@end

@implementation CVUICalendar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadControl:frame];
    }
    return self;
}
- (void) layoutSubviews{
    [super layoutSubviews];
    _popText.frame=self.bounds;
}
#pragma mark -
#pragma mark 私有方法
-(void)loadControl:(CGRect)frame{
    _popText=[[CVUIPopoverText alloc] initWithFrame:frame];
    [_popText.button addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_popText];
    //設定日曆格式
    _dateForFormat=[[NSDateFormatter alloc] init];
    [_dateForFormat setDateFormat:@"yyyy-MM-dd"];
    
    CGFloat w=[[UIScreen mainScreen] bounds].size.width;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        w=320;
    }
    //日期控制項
    if (!_datePicker) {
        _datePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, w, 216)];
        _datePicker.datePickerMode=1;
		_datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hant_TW"];//zh_Hant_TW zh_CN
        _datePicker.backgroundColor=[UIColor whiteColor];
    }
    if (!_popView) {
        _popView=[[CVUIPopoverView alloc] initWithFrame:CGRectMake(0, 0, w, 44)];
         UIBarButtonItem *leftButton=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(buttonCancelClick)];
         UIBarButtonItem *midleButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
         UIBarButtonItem *fixButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
         UIBarButtonItem *clearButton=[[UIBarButtonItem alloc] initWithTitle:@"清除" style:UIBarButtonItemStylePlain target:self action:@selector(buttonClearClick)];
         UIBarButtonItem *rightButton=[[UIBarButtonItem alloc] initWithTitle:@"確定" style:UIBarButtonItemStylePlain target:self action:@selector(buttonDoneClick)];
         [_popView.toolBar setItems:[NSArray arrayWithObjects:leftButton,midleButton,fixButton,clearButton,rightButton, nil]];
         [leftButton release];
         [rightButton release];
         [midleButton release];
         [fixButton release];
         [clearButton release];
        [_popView addChildView:_datePicker];
    }
}
- (NSString*)calendarValue{
    return [_dateForFormat stringFromDate:_datePicker.date];
}
-(void)setCalendarValue{
    if ([_popText.field.text length]>0) {
        NSDate *date = [_dateForFormat dateFromString:_popText.field.text];
        [_datePicker setDate:date animated:YES];
    }
}
//顯示事件
- (void)show{
    [self setCalendarValue];
    [_popView show:self];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(showPopoverCalendar:)]) {
        [self.delegate showPopoverCalendar:self];
    }
}

//確定事件
-(void)buttonDoneClick{
    _popText.field.text=[_dateForFormat stringFromDate:_datePicker.date];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(doneCalendarChooseItem:)]) {
        [self.delegate doneCalendarChooseItem:self];
    }
    [self buttonCancelClick];
}
//清除事件
-(void)buttonClearClick{
    _popText.field.text=@"";
    [self buttonCancelClick];
}
//取消事件
-(void)buttonCancelClick{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(closeCalendar:)]) {
        [self.delegate closeCalendar:self];
    }
    [_popView hide];
}
@end
