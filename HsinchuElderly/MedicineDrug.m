//
//  MedicineDrug.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/9.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "MedicineDrug.h"
#import "NSDate+TPCategory.h"
#import "AppHelper.h"

@interface MedicineDrug()
- (NSDate*)repeatDateWithTime:(NSString*)time;
@end

@implementation MedicineDrug
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.ID forKey:@"ID"];
    [encoder encodeObject:self.UserId forKey:@"UserId"];
    [encoder encodeObject:self.UserName forKey:@"UserName"];
    [encoder encodeObject:self.Name forKey:@"Name"];
    [encoder encodeObject:self.Rate forKey:@"Rate"];
    [encoder encodeInteger:self.RateCount forKey:@"RateCount"];
    [encoder encodeObject:self.TimeSpan forKey:@"TimeSpan"];
    [encoder encodeObject:self.CreateDate forKey:@"CreateDate"];
    [encoder encodeInteger:self.myHash forKey:@"myHash"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.ID=[aDecoder decodeObjectForKey:@"ID"];
        self.Name=[aDecoder decodeObjectForKey:@"Name"];
        self.UserId=[aDecoder decodeObjectForKey:@"UserId"];
        self.UserName=[aDecoder decodeObjectForKey:@"UserName"];
        self.Rate=[aDecoder decodeObjectForKey:@"Rate"];
        self.RateCount=[aDecoder decodeIntegerForKey:@"RateCount"];
        self.TimeSpan=[aDecoder decodeObjectForKey:@"TimeSpan"];
        self.CreateDate=[aDecoder decodeObjectForKey:@"CreateDate"];
        self.myHash=[aDecoder decodeIntegerForKey:@"myHash"];
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone
{
    MedicineDrug *result = [[[self class] allocWithZone:zone] init];
    result.ID=self.ID;
    result.UserId=self.UserId;
    result.UserName=self.UserName;
    result.Name=self.Name;
    result.Rate=self.Rate;
    result.RateCount=self.RateCount;
    result.TimeSpan=self.TimeSpan;
    result.CreateDate=self.CreateDate;
    [result setMyHash:self.myHash];
    return result;
}
- (id)init
{
    if (self = [super init]) {
        _myHash = (NSUInteger)self;
    }
    return self;
}
- (NSUInteger)hash
{
    return _myHash;
}
- (BOOL)isEqual:(id)object
{
    return self.myHash == ((MedicineDrug *)object).myHash;
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
- (NSDate*)repeatDateWithTime:(NSString*)time{
    NSDate *nowT=[NSDate date];
    NSString *str1=[NSDate stringFromDate:nowT withFormat:@"yyyy-MM-dd"];
    str1=[NSString stringWithFormat:@"%@ %@",str1,time];
    return [NSDate dateFromString:str1 withFormat:@"yyyy-MM-dd HH:mm"];
}
- (NSDate*)repeatDate{
    NSDate *nowT=[NSDate date];
    NSString *str1=[NSDate stringFromDate:nowT withFormat:@"yyyy-MM-dd"];
    str1=[NSString stringWithFormat:@"%@ %@",str1,[self TimeSpan]];
    return [NSDate dateFromString:str1 withFormat:@"yyyy-MM-dd HH:mm"];
   
   // NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
   // [formatter setDateFormat:@"HH:mm:ss"];
    //觸發通知的時間
    //NSDate *now = [formatter dateFromString:@"15:00:00"];
    //return [formatter dateFromString:[NSString stringWithFormat:@"%@:00",[self TimeSpan]]];
    
    
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
    NSDictionary *userInfo=[NSDictionary dictionaryWithObjectsAndKeys:self.ID,@"guid",@"1",@"type",self.UserName,@"UserName",
                            self.Name,@"Name",self.TimeSpan,@"TimeSpan",nil];
    [AppHelper sendLocationNotice:userInfo message:msg noticeDate:self.repeatDate repeatInterval:self.repeatInterval];
}
//设定闹钟
- (void)sendLocalNotificeWithMessage:(NSString*)msg{
    NSArray *times=[self.TimeSpan componentsSeparatedByString:@";"];
    for (NSInteger i=0;i<times.count;i++) {
        NSDictionary *userInfo=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@_%d",self.ID,i],@"guid",@"1",@"type",self.UserName,@"UserName",
                                self.Name,@"Name",times[i],@"TimeSpan",nil];
        [AppHelper sendLocationNotice:userInfo message:msg noticeDate:[self repeatDateWithTime:times[i]] repeatInterval:self.repeatInterval];
    }
}
@end
