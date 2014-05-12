//
//  BloodSugar.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "BloodSugar.h"

@implementation BloodSugar
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
