//
//  MedicineDrugHelper.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MedicineDrug.h"
@interface MedicineDrugHelper : NSObject
+ (BOOL)existsDrugs;
//列表
- (NSMutableArray*)medicineDrugs;
//新增與修改
- (void)addEditDrugWithModel:(MedicineDrug*)entity name:(NSString*)name;
//儲存
- (void)saveWithSources:(NSArray*)sources;
- (BOOL)existsByUserId:(NSString*)userId;
//載入數據
- (void)loadDataSource;
@end
