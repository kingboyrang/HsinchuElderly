//
//  RecordBlood.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "RecordBlood.h"
#import "NSDate+TPCategory.h"
@implementation RecordBlood
- (NSString*)BloodDetail{
    return [NSString stringWithFormat:@"%@(舒張)/%@(收縮)/%@(脈搏)",self.Diastolic,self.Shrink,self.Pulse];
}
- (NSString*)TimeSpanText{
    NSDate *date1=[NSDate dateFromString:self.RecordDate withFormat:@"yyyy-MM-dd"];
    TKDateInformation info=[date1 dateInformation];
    NSString *str1=info.month<10?[NSString stringWithFormat:@"0%d",info.month]:[NSString stringWithFormat:@"%d",info.month];
    NSString *str2=info.day<10?[NSString stringWithFormat:@"0%d",info.day]:[NSString stringWithFormat:@"%d",info.day];
    return [NSString stringWithFormat:@"%@/%@ %@",str1,str2,self.TimeSpan];
}
@end
