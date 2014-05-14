//
//  HEBasicHelper.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BasicModel.h"
typedef enum{
    HEBasicMedicalCare=0,
    HEBasicStudy=1,
    HEBasicService=2,
    HEBasicWelfare=3,
    HEBasicConsultation=4
}HEBasicTable;

@interface HEBasicHelper : NSObject
@property (nonatomic,assign) HEBasicTable basicTable;
@property (nonatomic,copy) NSString *tableName;
@property (nonatomic,copy) NSString *categoryTableName;
@property (nonatomic,copy) NSString *areaTableName;
//分类
- (NSMutableArray*)categorys;
//区域
- (NSMutableArray*)areas;
//取得所有数据
- (NSMutableArray*)tableDataList;
//分页查询
- (NSMutableArray*)searchWithCategory:(NSString*)category
                             aresGuid:(NSString*)areaId
                                 size:(int)size
                                 page:(int)page;
//注册mode子类
-(void) registerBasicModelSubclass:(Class) aClass;
//子类重写复值
- (void)setColumnValueWithModel:(BasicModel*)entity resultSet:(FMResultSet*)rs;
@end