//
//  HEBasicHelper.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "HEBasicHelper.h"

@interface HEBasicHelper ()
@property (assign, nonatomic) Class customSubclass;
@end

@implementation HEBasicHelper
- (NSMutableArray*)categorys{
    NSMutableArray *sources=[NSMutableArray array];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"所有類別",@"Name",@"",@"ID", nil]];
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    if ([db open]) {
        NSString *sql=[NSString stringWithFormat:@"SELECT * FROM %@ order by Sort ASC",[self categoryTableName]];
        FMResultSet *rs = [db executeQuery:sql];
        while (rs.next) {
            [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:[rs stringForColumn:@"Name"],@"Name",[rs stringForColumn:@"ID"],@"ID", nil]];
        }
        [db close];
    }
    return sources;
}
- (NSMutableArray*)areas{
    NSMutableArray *sources=[NSMutableArray array];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"所有區域",@"Name",@"",@"ID", nil]];
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    if ([db open]) {
        NSString *sql=[NSString stringWithFormat:@"SELECT * FROM %@ order by Sort ASC",[self areaTableName]];
        FMResultSet *rs = [db executeQuery:sql];
        while (rs.next) {
            [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:[rs stringForColumn:@"Name"],@"Name",[rs stringForColumn:@"ID"],@"ID", nil]];
        }
        [db close];
    }
    return sources;
}
//取得所有数据
- (NSMutableArray*)tableDataList{
   NSMutableString *sql=[NSMutableString stringWithFormat:@"SELECT * FROM %@",[self tableName]];
    NSMutableArray *sources=[NSMutableArray array];
    NSString *categoryColumnName=[NSString stringWithFormat:@"%@Guid",[self categoryTableName]];
    NSString *areaColumnName=[NSString stringWithFormat:@"%@Guid",[self areaTableName]];
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    if ([db open]) {//表示打开
        FMResultSet *rs = [db executeQuery:sql];
        while (rs.next) {
            BasicModel *entity=(BasicModel*)[[self.customSubclass alloc] init];
            entity.ID=[rs stringForColumn:@"ID"];
            entity.Name=[rs stringForColumn:@"Name"];
            entity.Address=[rs stringForColumn:@"Address"];
            entity.Tel=[rs stringForColumn:@"Tel"];
            entity.CategoryGuid=[rs stringForColumn:categoryColumnName];
            entity.AreaGuid=[rs stringForColumn:areaColumnName];
            entity.WebSiteURL=[rs stringForColumn:@"WebSiteURL"];
            [self setColumnValueWithModel:entity resultSet:rs];
            [sources addObject:entity];
        }
        [db close];
    }
    return sources;
}
//注册mode子类
-(void) registerBasicModelSubclass:(Class) aClass{
    self.customSubclass = aClass;
}
- (NSMutableArray*)searchWithCategory:(NSString*)category
                             aresGuid:(NSString*)areaId
                                 size:(int)size
                                 page:(int)page{
    //防止出错
    if (![self.customSubclass isSubclassOfClass:[BasicModel class]]) {
        [self registerBasicModelSubclass:[BasicModel class]];
    }
    
    NSString *categoryColumnName=[NSString stringWithFormat:@"%@Guid",[self categoryTableName]];
    NSString *areaColumnName=[NSString stringWithFormat:@"%@Guid",[self areaTableName]];
    NSMutableString *sql=[NSMutableString stringWithFormat:@"SELECT * FROM %@ where 1=1",[self tableName]];
    if (category&&[category length]>0) {
        [sql appendFormat:@" and %@='%@'",categoryColumnName,category];
    }
    if (areaId&&[areaId length]>0) {
        [sql appendFormat:@" and %@='%@'",areaColumnName,areaId];
    }
    [sql appendString:@" order by Name"];
    [sql appendFormat:@" limit %d offset %d",size,size*(page-1)];
    NSMutableArray *sources=[NSMutableArray array];
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    if ([db open]) {//表示打开
        FMResultSet *rs = [db executeQuery:sql];
        while (rs.next) {
            BasicModel *entity=(BasicModel*)[[self.customSubclass alloc] init];
            entity.ID=[rs stringForColumn:@"ID"];
            entity.Name=[rs stringForColumn:@"Name"];
            entity.Address=[rs stringForColumn:@"Address"];
            entity.Tel=[rs stringForColumn:@"Tel"];
            entity.CategoryGuid=[rs stringForColumn:categoryColumnName];
            entity.AreaGuid=[rs stringForColumn:areaColumnName];
            entity.WebSiteURL=[rs stringForColumn:@"WebSiteURL"];
            [self setColumnValueWithModel:entity resultSet:rs];
            [sources addObject:entity];
        }
        [db close];
    }
    return sources;
}
- (void)setColumnValueWithModel:(BasicModel*)entity resultSet:(FMResultSet*)rs{
}
@end
