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
@property (nonatomic,retain) NSArray *allAreas;

+ (void)createTables;

- (NSMutableArray*)searchAreaWithCategory:(NSString*)guid areaGuid:(NSString*)areaGuid source:(NSArray*)source;
//類別
- (NSMutableArray*)categorys;
//區域
- (NSMutableArray*)areas;
//區域
- (NSMutableArray*)areasWithCategory:(NSString*)guid;
//取得所有數據
- (NSMutableArray*)tableDataList;
//分頁查詢
- (NSMutableArray*)searchWithCategory:(NSString*)category
                             aresGuid:(NSString*)areaId
                                 size:(int)size
                                 page:(int)page;
//非分頁查詢
- (NSMutableArray*)searchWithCategory:(NSString*)category
                             aresGuid:(NSString*)areaId;

//註冊mode子類別
-(void) registerBasicModelSubclass:(Class) aClass;
//子類別重寫復值
- (void)setColumnValueWithModel:(BasicModel*)entity resultSet:(FMResultSet*)rs;
@end
