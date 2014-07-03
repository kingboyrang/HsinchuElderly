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
@end
