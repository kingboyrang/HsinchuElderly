//
//  BloodSugar.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "BloodSugar.h"
#import "NSDate+TPCategory.h"
#import "AppHelper.h"
@interface BloodSugar()
- (NSDate*)repeatDateWithTime:(NSString*)time;
@end
@implementation BloodSugar
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.ID forKey:@"ID"];
    [encoder encodeObject:self.UserId forKey:@"UserId"];
    [encoder encodeObject:self.UserName forKey:@"UserName"];
    [encoder encodeObject:self.Rate forKey:@"Rate"];
    [encoder encodeInteger:self.RateCount forKey:@"RateCount"];
    [encoder encodeObject:self.TimeSpan forKey:@"TimeSpan"];
    [encoder encodeObject:self.CreateDate forKey:@"CreateDate"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.ID=[aDecoder decodeObjectForKey:@"ID"];
        self.UserId=[aDecoder decodeObjectForKey:@"UserId"];
        self.UserName=[aDecoder decodeObjectForKey:@"UserName"];
        self.Rate=[aDecoder decodeObjectForKey:@"Rate"];
        self.RateCount=[aDecoder decodeIntegerForKey:@"RateCount"];
        self.TimeSpan=[aDecoder decodeObjectForKey:@"TimeSpan"];
        self.CreateDate=[aDecoder decodeObjectForKey:@"CreateDate"];
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone
{
    BloodSugar *result = [[[self class] allocWithZone:zone] init];
    result.ID=self.ID;
    result.UserId=self.UserId;
    result.UserName=self.UserName;
    result.Rate=self.Rate;
    result.RateCount=self.RateCount;
    result.TimeSpan=self.TimeSpan;
    result.CreateDate=self.CreateDate;
    return result;
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
- (NSDate*)repeatDateWithTime:(NSString*)time{
    NSDate *nowT=[NSDate date];
    NSString *str1=[NSDate stringFromDate:nowT withFormat:@"yyyy-MM-dd"];
    str1=[NSString stringWithFormat:@"%@ %@",str1,time];
    return [NSDate dateFromString:str1 withFormat:@"yyyy-MM-dd HH:mm"];
}
- (NSDate*)repeatDate{
    NSDate *nowT=[NSDate date];
    NSString *str=[NSDate stringFromDate:nowT withFormat:@"yyyy-MM-dd"];
    str=[NSString stringWithFormat:@"%@ %@",str,[self TimeSpan]];
    return [NSDate dateFromString:str withFormat:@"yyyy-MM-dd HH:mm"];
    
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
    
    long int delayTime;
    BOOL figure=NO;
    delayTime = (24 -hour+htime1-12) * 60 * 60 - min * 60 - sec + 24 * 60 * 60;
    
    int wd=weekDay==1?7:weekDay-1;
    if (wd==[self.Rate intValue]) {//表示同一天
        if (hour<=htime1-12) {//時間沒到十點
            delayTime = (htime1-hour) * 60 * 60 - min * 60 - sec;
            figure=YES;
        }
    }
    if (!figure) {
        delayTime=(weekDay-1)*24*60*60+hour*60*60+min*60+sec;
    }
    //用一周時間 -已經度過時間+將要發生時間
    delayTime=7*24*60*60-delayTime+(htime1-12)*60*60+mtime1*60;
    return  [now dateByAddingTimeInterval:delayTime];
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
//移除设定闹钟
- (void)removeNotifices{
    [AppHelper removeLocationNoticeWithName:self.ID];
}
//设定闹钟
- (void)addLocalNotificeWithMessage:(NSString*)msg{
    NSDictionary *userInfo=[NSDictionary dictionaryWithObjectsAndKeys:self.ID,@"guid",@"3",@"type",self.UserName,@"UserName",self.TimeSpan,@"TimeSpan", nil];
    [AppHelper sendLocationNotice:userInfo message:msg noticeDate:self.repeatDate repeatInterval:self.repeatInterval];
}
//设定闹钟
- (void)sendLocalNotificeWithMessage:(NSString*)msg{
    NSArray *times=[self.TimeSpan componentsSeparatedByString:@";"];
    for (NSInteger i=0;i<times.count;i++) {
        NSDictionary *userInfo=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@_%d",self.ID,i],@"guid",@"3",@"type",self.UserName,@"UserName",times[i],@"TimeSpan", nil];
        [AppHelper sendLocationNotice:userInfo message:msg noticeDate:[self repeatDateWithTime:times[i]] repeatInterval:self.repeatInterval];
        
    }
}
@end
