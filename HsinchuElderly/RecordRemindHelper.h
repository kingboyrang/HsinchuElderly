//
//  RecordRemindHelper.h
//  HsinchuElderly
//
//  Created by aJia on 2014/6/18.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordRemind.h"
@interface RecordRemindHelper : NSObject
- (NSArray*)searchRecordWithType:(NSString*)type startDate:(NSString*)bdate endDate:(NSString*)edate;
- (NSArray*)searchRecordWithType:(NSString*)type searchDate:(NSString*)bdate;
- (NSString*)searchMaxDateWithType:(NSString*)type startDate:(NSString*)bdate endDate:(NSString*)edate;
//插入记录
+ (BOOL)insertRecordDrug:(NSDictionary*)entity;
+ (BOOL)insertRecordBlood:(NSDictionary*)entity shrink:(NSString*)value1 diastolic:(NSString*)value2;
+ (BOOL)insertRecordBloodSugar:(NSDictionary*)entity sugar:(NSString*)value;
@end
