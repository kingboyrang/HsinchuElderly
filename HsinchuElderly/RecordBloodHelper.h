//
//  RecordBloodHelper.h
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordBlood.h"
@interface RecordBloodHelper : NSObject
- (BOOL)addRecord:(RecordBlood*)entity;
- (BOOL)editRecord:(RecordBlood*)entity;
- (BOOL)deleteWithGuid:(NSString*)guid;
- (NSMutableArray*)findByUser:(NSString*)guid;
@end
