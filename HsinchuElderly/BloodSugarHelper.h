//
//  BloodSugarHelper.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BloodSugar.h"
@interface BloodSugarHelper : NSObject
//列表
- (NSMutableArray*)pressureBloodSugars;
//新增與修改
- (void)addEditWithModel:(BloodSugar*)entity;
//儲存
- (void)saveWithSources:(NSArray*)sources;
//儲存數據
- (void)loadDataSource;
@end
