//
//  MedicineDrug.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/9.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "MedicineDrug.h"
#import "NSDate+TPCategory.h"
@implementation MedicineDrug
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.ID forKey:@"ID"];
    [encoder encodeObject:self.UserId forKey:@"UserId"];
    [encoder encodeObject:self.Name forKey:@"Name"];
    [encoder encodeObject:self.Rate forKey:@"Rate"];
    [encoder encodeObject:self.TimeSpan forKey:@"TimeSpan"];
    [encoder encodeObject:self.CreateDate forKey:@"CreateDate"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.ID=[aDecoder decodeObjectForKey:@"ID"];
        self.Name=[aDecoder decodeObjectForKey:@"Name"];
        self.UserId=[aDecoder decodeObjectForKey:@"UserId"];
        self.Rate=[aDecoder decodeObjectForKey:@"Rate"];
        self.TimeSpan=[aDecoder decodeObjectForKey:@"TimeSpan"];
        self.CreateDate=[aDecoder decodeObjectForKey:@"CreateDate"];
    }
    return self;
}
- (NSCalendarUnit)repeatInterval{
    if (_Rate&&[_Rate length]>0) {
        if ([_Rate isEqualToString:@"8"]) {
            return NSCalendarUnitDay;
        }
        return NSCalendarUnitWeekday;
    }
    return NSCalendarUnitWeekday;
}
- (NSDate*)repeatDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    //觸發通知的時間
    //NSDate *now = [formatter dateFromString:@"15:00:00"];
    return [formatter dateFromString:[NSString stringWithFormat:@"%@:00",[self TimeSpan]]];
    
    
    NSDate* now = [NSDate date];
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
	NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	comps = [calendar components:unitFlags fromDate:now];
    int weekDay=[comps weekday];//1表示週日 2:表示週一
	int hour = [comps hour];
	int min = [comps minute];
	int sec = [comps second];
	
     NSArray *arr=[_TimeSpan componentsSeparatedByString:@":"];
    //目前鬧鐘設置的小時
	int htime1=[arr[0] intValue];
    //目前鬧鐘設置的分鐘
	int mtime1=[arr[1] intValue];
    
	int hs=htime1-hour;
	int ms=mtime1-min;
	
	if(ms<0)
	{
		ms=ms+60;
		hs=hs-1;
	}
	if(hs<0)
	{
		hs=hs+24;
		hs=hs-1;
	}
	if (ms<=0&&hs<=0) {
		hs=24;
		ms=0;
	}
    if (self.repeatInterval==NSCalendarUnitDay) {//每天鬧鐘提醒
	    int hm=(hs*3600)+(ms*60)-sec;
        return [now dateByAddingTimeInterval:hm];
    }
    NSString *str=[NSDate stringFromDate:now withFormat:@"yyyy-MM-dd"];
    str=[NSString stringWithFormat:@"%@ %@",str,[self TimeSpan]];
    NSLog(@"str=%@",str);
    return [NSDate dateFromString:str withFormat:@"yyyy-MM-dd HH:mm"];
    /***
    long int delayTime;
    BOOL figure=NO;
    delayTime = (24 -hour+htime1) * 60 * 60 - min * 60 - sec + 24 * 60 * 60;
    
    int wd=weekDay==1?7:weekDay-1;
    if (wd==[self.Rate intValue]) {//表示同一天
        if (hour<=htime1) {//時間沒到十點
            delayTime = (htime1-hour) * 60 * 60 - min * 60 - sec;
            figure=YES;
        }
    }
    if (!figure) {
        delayTime=(weekDay-1)*24*60*60+hour*60*60+min*60+sec;
    }
    //用一周時間 -已經度過時間+將要發生時間
    delayTime=7*24*60*60-delayTime+htime1*60*60+mtime1*60;
    return  [now dateByAddingTimeInterval:delayTime];
     ***/
     
    /***
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:date];
    int hour = [comp hour];
    int min = [comp minute];
    int sec = [comp second];
    if (self.repeatInterval==NSDayCalendarUnit) {//每天鬧鐘提醒
        NSArray *arr=[_TimeSpan componentsSeparatedByString:@":"];
        int minute=[arr[1] integerValue];
        int h=[arr[0] integerValue];
        long int delayTime;
        
        if (hour < h){//時間還沒到
            delayTime = (h-1-hour) * 60 * 60 - min * 60 - sec+minute*60;
        }else {
            delayTime = (24-hour+h) * 60 * 60 - min * 60 - sec + 24 * 60 * 60-minute*60;
        }
        NSDate *dates = [date dateByAddingTimeInterval:delayTime];
        return dates;
    }else{//某一天提醒
        NSArray *arr=[_TimeSpan componentsSeparatedByString:@":"];
        int minute=[arr[1] integerValue];
        int h=[arr[0] integerValue];
        
        int weekDay=[comp weekday];
        long int delayTime;
        BOOL figure=NO;
        delayTime = (24 -hour+10) * 60 * 60 - min * 60 - sec + 24 * 60 * 60;
        if (weekDay==[self.Rate intValue]) {//為相同的天
            if (hour<=h) {//時間沒到十點
                delayTime = (h-1-hour) * 60 * 60 - min * 60 - sec+minute*60;
                figure=YES;
            }
        }
        if (!figure) {
            delayTime=(weekDay-1)*24*60*60+hour*60*60+min*60+sec+minute*60;
        }
        //用一周時間 -已經度過時間+將要發生時間
        delayTime=7*24*60*60-delayTime+10*60*60;
        NSDate *dates = [date dateByAddingTimeInterval:delayTime];
        return dates;
    }
     ***/
     
   /***
    
    NSDate *now=[NSDate date];
    NSString *str=[NSDate stringFromDate:now withFormat:@"yyyy-MM-dd"];
    str=[NSString stringWithFormat:@"%@ %@",str,[self TimeSpan]];
    return [NSDate dateFromString:str withFormat:@"yyyy-MM-dd HH:mm"];
    ***/
}
- (NSString*)TimeSpanText{
    if (_TimeSpan&&[_TimeSpan length]>0) {
        NSArray *arr=[_TimeSpan componentsSeparatedByString:@":"];
        int minute=[arr[0] integerValue];
        NSString *str=@"";
        if (minute<12) {
            str=@"早上";
        }else if(minute>=12&&minute<=18)
        {
            str=@"下午";
        }else{
             str=@"晚上";
        }
        return [NSString stringWithFormat:@"%@ %d點%@分",str,minute,arr[1]];
    }
    return @"";
}
@end
