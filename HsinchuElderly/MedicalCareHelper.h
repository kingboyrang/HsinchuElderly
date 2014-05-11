//
//  MedicalCareHelper.h
//  HsinchuElderly
//
//  Created by rang on 14-5-10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MedicalCareHelper : NSObject
//分类
- (NSMutableArray*)categorys;
//区域
- (NSMutableArray*)areas;
//分页查询
- (NSMutableArray*)searchWithCategory:(NSString*)category
                             aresGuid:(NSString*)areaId
                                 size:(int)size
                                 page:(int)page;
@end
