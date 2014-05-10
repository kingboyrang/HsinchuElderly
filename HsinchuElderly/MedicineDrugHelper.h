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
//列表
- (NSMutableArray*)medicineDrugs;
//新增与修改
- (void)addEditDrugWithModel:(MedicineDrug*)entity;
//保存
- (void)saveWithSources:(NSArray*)sources;
//加载数据源
- (void)loadDataSource;
@end
