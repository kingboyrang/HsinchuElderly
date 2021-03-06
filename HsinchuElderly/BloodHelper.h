//
//  BloodHelper.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Blood.h"
@interface BloodHelper : NSObject
+ (BOOL)existsBloods;
//列表
- (NSMutableArray*)pressureBloods;
//新增與修改
- (void)addBloodWithModel:(Blood*)entity name:(NSString*)name;
- (void)addEditDrugWithModel:(Blood*)entity name:(NSString*)name;
//儲存
- (void)saveWithSources:(NSArray*)sources;
- (BOOL)existsByUserId:(NSString*)userId;
//載入數據
- (void)loadDataSource;
@end
