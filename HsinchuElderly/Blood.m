//
//  Blood.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "Blood.h"
#import "NSDate+TPCategory.h"
@implementation Blood
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.ID forKey:@"ID"];
    [encoder encodeObject:self.UserId forKey:@"UserId"];
    [encoder encodeObject:self.Rate forKey:@"Rate"];
    [encoder encodeObject:self.TimeSpan forKey:@"TimeSpan"];
    [encoder encodeObject:self.CreateDate forKey:@"CreateDate"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.ID=[aDecoder decodeObjectForKey:@"ID"];
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
    return 0;
}
- (NSDate*)repeatDate{
    
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
            if (hour<=h) {//时间没到十点
                delayTime = (h-1-hour) * 60 * 60 - min * 60 - sec+minute*60;
                figure=YES;
            }
        }
        if (!figure) {
            delayTime=(weekDay-1)*24*60*60+hour*60*60+min*60+sec+minute*60;
        }
        //用一周时间 -已经度过时间+将要发生时间
        delayTime=7*24*60*60-delayTime+10*60*60;
        NSDate *dates = [date dateByAddingTimeInterval:delayTime];
        return dates;
    }
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
