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
//列表
- (NSMutableArray*)pressureBloods;
//新增與修改
- (void)addEditDrugWithModel:(Blood*)entity;
//儲存
- (void)saveWithSources:(NSArray*)sources;
//載入數據
- (void)loadDataSource;
@end
