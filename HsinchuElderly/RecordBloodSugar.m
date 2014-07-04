//
//  RecordBloodSugar.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "RecordBloodSugar.h"
#import "NSDate+TPCategory.h"
@implementation RecordBloodSugar

- (NSString*)SugarDetail{
    NSInteger row=[self.Measure integerValue];
    return [NSString stringWithFormat:@"%@:%@",SugarSource[row],self.BloodSugar];
}
- (NSString*)monthDayText{
    NSDate *date1=[NSDate dateFromString:self.RecordDate withFormat:@"yyyy-MM-dd"];
    TKDateInformation info=[date1 dateInformation];
    NSString *str1=info.month<10?[NSString stringWithFormat:@"0%d",info.month]:[NSString stringWithFormat:@"%d",info.month];
    NSString *str2=info.day<10?[NSString stringWithFormat:@"0%d",info.day]:[NSString stringWithFormat:@"%d",info.day];
    return [NSString stringWithFormat:@"%@/%@",str1,str2];
}
- (NSString*)TimeSpanText{
    return [NSString stringWithFormat:@"時間:%@ %@",[self monthDayText],self.TimeSpan];
}
- (NSString*)chartDateText{
     NSInteger row=[self.Measure integerValue];
     NSString *str1=[SugarSource[row] stringByReplacingOccurrencesOfString:@"血糖" withString:@""];
     return [NSString stringWithFormat:@"%@%@",str1,[self monthDayText]];
}
@end
