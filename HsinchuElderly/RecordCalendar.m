//
//  RecordCalendar.m
//  HsinchuElderly
//
//  Created by aJia on 2014/6/17.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "RecordCalendar.h"
#import "NSDate+TPCategory.h"
#import "UIImage+TPCategory.h"
#define weekSource [NSDictionary dictionaryWithObjectsAndKeys:@"日",@"0",@"一",@"1",@"二",@"2",@"三",@"3",@"四",@"4",@"五",@"5",@"六",@"6", nil]

@implementation RecordCalendar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        _calendarTop=[[CalendarYearMonth alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 35)];
        [self addSubview:_calendarTop];
        
        self.currentDate=[NSDate date];
        
        
        CGFloat w=frame.size.width/7,h=w;
        NSInteger row=[self rowCount];
        CGRect r=self.frame;
        r.size.height=70+row*h;
        self.frame=r;
    }
    return self;
}
- (NSInteger)rowCount{
    //畫表格
    NSDate *now=self.currentDate;
    NSInteger week1=[[now monthFirstDay] dayOfWeek];
    NSInteger totalDay=[now monthOfDay];//总共天数
    NSInteger spareDay=totalDay-(week1==7?7:7-week1);
    NSInteger row=1+spareDay/7;//取得總共有多少行
    if (spareDay%7!=0) {
        row+=1;
    }
    return row;
}
#pragma mark - private Methods
//取得今天是星期几
- (NSInteger)getWeekDay:(NSInteger)day{
    NSDate *now=[self.currentDate monthFirstDay];
    NSInteger week=0;
    if (day==1) {
        week=[now dayOfWeek];
    }
    now=[now dateByAddingDays:day-1];
    week=[now dayOfWeek];
    if (week==7) {
        week=0;
    }
    return week;
}
//判断是否为今天
- (BOOL)isDateToday:(NSInteger)day{
    NSDate *now=[self.currentDate monthFirstDay];
    if (day>1) {
        now=[now dateByAddingDays:day-1];
    }
    NSString *time1=[now stringWithFormat:@"yyyy-MM-dd"];
    NSString *time2=[[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
    if ([time1 isEqualToString:time2]) {
        return YES;
    }
    return NO;
}
//画表头
- (void)drawDateHeader:(CGContextRef)ctx frame:(CGRect)rect{
    UIColor *lineColor=[UIColor colorFromHexRGB:@"fda787"];
    //畫矩形
    CGContextSetFillColorWithColor(ctx, lineColor.CGColor);
    CGContextFillRect(ctx, CGRectMake(0, 35, rect.size.width, 35));
    
    /*NO.2写文字*/
    CGContextSetLineWidth(ctx, 1.0);
    CGContextSetRGBFillColor (ctx, 0.5, 0.5, 0.5, 0.5);
    UIFont  *font = [UIFont fontWithName:defaultDeviceFontName size:20];
    NSString *key=@"日";
    CGSize size=[key textSize:font withWidth:rect.size.width];
    CGFloat w=rect.size.width/7;
    NSDictionary *attrs=[NSDictionary dictionaryWithObjectsAndKeys:
                         [UIColor whiteColor], NSForegroundColorAttributeName,
                         font, NSFontAttributeName, nil];
    for (int i=0; i<7; i++) {
        key=[NSString stringWithFormat:@"%d",i];
        [[weekSource objectForKey:key] drawInRect:CGRectMake(i*w+(w-size.width)/2,(35-size.height)/2+35, size.width, size.height) withAttributes:attrs];
    }
}
//画表格
- (void)drawTableRow:(CGContextRef)ctx frame:(CGRect)rect{
    CGFloat w=rect.size.width/7,h=w;
    NSInteger row=[self rowCount];//取得總共有多少行
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorFromHexRGB:@"b6b6b6"].CGColor);
    CGContextSetLineWidth(ctx,1.0);
    CGContextBeginPath(ctx);
    for (NSInteger a=0;a<row;a++) {
        //畫橫線
        CGContextMoveToPoint(ctx, 0,70+(a+1)*h);
        CGContextAddLineToPoint(ctx, rect.size.width, 70+(a+1)*h);
    }
    for (NSInteger b=1; b<7; b++) {
        //畫書線
        CGContextMoveToPoint(ctx, w*b,70);
        CGContextAddLineToPoint(ctx, w*b, 70+row*h);
    }
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
}
//画前一個月
- (void)drawPrevMonth:(CGContextRef)ctx frame:(CGRect)rect row:(NSInteger)row endIndex:(NSInteger)index{
    NSDate *date1=[self.currentDate dateByAddingMonths:-1];//前一个月
    NSInteger startDay=[date1 monthOfDay]-index;//起始天
    NSDictionary *textAttrs=[NSDictionary dictionaryWithObjectsAndKeys:
                             [UIColor blackColor], NSForegroundColorAttributeName,
                             default18DeviceFont, NSFontAttributeName, nil];
    CGFloat w=rect.size.width/7,h=w;
    NSString *dayMemo=@"";
    for (NSInteger i=0; i<index; i++) {
        dayMemo=[NSString stringWithFormat:@"%d",startDay];
        //画矩形
        CGRect r1=CGRectMake(i*w, 70+row*h, (i==6?w:w-1), h-1);
        CGContextSetFillColorWithColor(ctx, [UIColor colorFromHexRGB:@"feb397"].CGColor);
        CGContextFillRect(ctx, r1);
        //画文字
        CGSize size=[dayMemo textSize:default18DeviceFont withWidth:w-1];
        [dayMemo drawInRect:CGRectMake(r1.origin.x+1,r1.origin.y+1, size.width, size.height) withAttributes:textAttrs];
        
        startDay+=1;
    }
}
//画下个月
- (void)drawNextMonth:(CGContextRef)ctx frame:(CGRect)rect row:(NSInteger)row startIndex:(NSInteger)index{
    if (index>=7) {
        return;
    }
    NSDictionary *textAttrs=[NSDictionary dictionaryWithObjectsAndKeys:
                             [UIColor blackColor], NSForegroundColorAttributeName,
                             default18DeviceFont, NSFontAttributeName, nil];
    CGFloat w=rect.size.width/7,h=w;
    NSInteger startDay=0;//开始天数
    NSString *dayMemo=@"";
    for (NSInteger i=index; i<7; i++) {
        startDay+=1;
        dayMemo=[NSString stringWithFormat:@"%d",startDay];
        //画矩形
        CGRect r1=CGRectMake(i*w, 70+row*h, (i==6?w:w-1), h-1);
        CGContextSetFillColorWithColor(ctx, [UIColor colorFromHexRGB:@"feb397"].CGColor);
        CGContextFillRect(ctx, r1);
        //画文字
        CGSize size=[dayMemo textSize:default18DeviceFont withWidth:w-1];
        [dayMemo drawInRect:CGRectMake(r1.origin.x+1,r1.origin.y+1, size.width, size.height) withAttributes:textAttrs];
    }
}
- (void)drawRect:(CGRect)rect{
   
    CGContextRef ctx =UIGraphicsGetCurrentContext();
    //画表头
    [self drawDateHeader:ctx frame:rect];
    //畫表格
    [self drawTableRow:ctx frame:rect];
    //画当前月日期
    NSInteger row=[self rowCount];//取得總共有多少行
    CGFloat w=rect.size.width/7,h=w;
    NSDictionary *textAttrs=[NSDictionary dictionaryWithObjectsAndKeys:
                         [UIColor blackColor], NSForegroundColorAttributeName,
                         default18DeviceFont, NSFontAttributeName, nil];
    
    NSInteger startIndex=0;//开始天数
    NSInteger maxDay=[self.currentDate monthOfDay];//总共天数
    NSString *dayMemo=@"";
    for (NSInteger r=0; r<row; r++) {
        for (NSInteger k=0; k<7; k++) {
            startIndex+=1;
            dayMemo=[NSString stringWithFormat:@"%d",startIndex];
            //画矩形
            NSInteger weekDay=[self getWeekDay:startIndex];//星期几
            if (r==0&&weekDay!=0) {
                //画上个月
                [self drawPrevMonth:ctx frame:rect row:r endIndex:k];
            }
            CGRect r1=CGRectMake(weekDay*w, 70+r*h, (weekDay==6?w:w-1), h-1);
            UIColor *rectColor=[self isDateToday:startIndex]?[UIColor colorFromHexRGB:@"fb3306"]:[UIColor colorFromHexRGB:@"fee5da"];
            CGContextSetFillColorWithColor(ctx, rectColor.CGColor);
            CGContextFillRect(ctx, r1);
            //画文字
            CGSize size=[dayMemo textSize:default18DeviceFont withWidth:w-1];
            [dayMemo drawInRect:CGRectMake(r1.origin.x+1,r1.origin.y+1, size.width, size.height) withAttributes:textAttrs];
            if (startIndex==maxDay) {
                 //画下个月
                [self drawNextMonth:ctx frame:rect row:r startIndex:k+1];
                break;
            }
        }
    }
}
@end
