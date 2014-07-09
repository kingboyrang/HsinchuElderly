//
//  RecordBloodSugarHelper.h
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordBloodSugar.h"
@interface RecordBloodSugarHelper : NSObject
- (BOOL)addRecord:(RecordBloodSugar*)entity;
- (BOOL)editRecord:(RecordBloodSugar*)entity;
- (BOOL)deleteWithGuid:(NSString*)guid;
- (NSMutableArray*)findByUser:(NSString*)guid;
//取得最大与最小的血糖值
- (NSMutableArray*)getMaxMinSugarfindByUser:(NSString*)guid;
//取得饭前资图表资料
- (NSMutableArray*)beforeMealsWithSource:(NSArray*)source;
//取得饭后资图表资料
- (NSMutableArray*)afterMealsWithSource:(NSArray*)source;
@end
