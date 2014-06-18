//
//  RecordRemind.m
//  HsinchuElderly
//
//  Created by aJia on 2014/6/18.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "RecordRemind.h"

@implementation RecordRemind
- (NSString*)Description{
    if ([self.Type isEqualToString:@"1"]) {
        return [NSString stringWithFormat:@"吃  %@",self.DetailValue1];
    }
    if ([self.Type isEqualToString:@"3"]) {
        return [NSString stringWithFormat:@"血糖值 %@ mg/dl",self.DetailValue1];
    }
    return @"";
}
@end
