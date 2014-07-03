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
- (id)init{
    if (self=[super init]) {
        self.allAreas=[self areas];
    }
    return self;
}
//創建表
+ (void)createTables{
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    if ([db open]) {
        [db beginTransaction];
        //帳號
        [db executeUpdate:@"CREATE TABLE if not exists \"SystemUser\" (\"ID\" CHAR(36) PRIMARY KEY  NOT NULL  UNIQUE , \"Name\" CHAR(100), \"PhotoURL\" TEXT, \"Sex\" INTEGER, \"CreateDate\" DATETIME DEFAULT CURRENT_TIMESTAMP);"];
        //藥物提醒
        [db executeUpdate:@"CREATE TABLE if not exists \"MedicineDrug\" (\"ID\" CHAR(36) PRIMARY KEY  NOT NULL  UNIQUE , \"UserId\" CHAR(36), \"Name\" TEXT, \"Rate\" CHAR(50), \"TimeSpan\" CHAR(50), \"CreateDate\" DATETIME DEFAULT CURRENT_TIMESTAMP);"];
        //血壓測量
         [db executeUpdate:@"CREATE TABLE if not exists \"Blood\" (\"ID\" CHAR(36) PRIMARY KEY  NOT NULL  UNIQUE , \"UserId\" CHAR(36), \"Rate\" CHAR(50), \"TimeSpan\" CHAR(50), \"CreateDate\" DATETIME DEFAULT CURRENT_TIMESTAMP);"];
        //血糖測量
        [db executeUpdate:@"CREATE TABLE if not exists \"BloodSugar\" (\"ID\" CHAR(36) PRIMARY KEY  NOT NULL  UNIQUE , \"UserId\" CHAR(36), \"Rate\" CHAR(50), \"TimeSpan\" CHAR(50), \"CreateDate\" DATETIME DEFAULT CURRENT_TIMESTAMP);"];
        //藥物記錄
        [db executeUpdate:@"CREATE TABLE if not exists \"RecordDrug\" (\"ID\" CHAR(36) PRIMARY KEY  NOT NULL  UNIQUE,\"DrugGuid\" CHAR(36),\"Name\" CHAR(100), \"DrugName\" CHAR(200),\"TimeSpan\" CHAR(50), \"RecordDate\" DATETIME, \"CreateDate\" DATETIME DEFAULT CURRENT_TIMESTAMP);"];
        //血壓記錄
        [db executeUpdate:@"CREATE TABLE if not exists \"RecordBlood\" (\"ID\" CHAR(36) PRIMARY KEY  NOT NULL  UNIQUE,\"BloodGuid\" CHAR(36), \"Name\" CHAR(100), \"Shrink\" CHAR(50),\"Diastolic\" CHAR(50),\"Pulse\" CHAR(50),\"TimeSpan\" CHAR(50),\"UserId\" CHAR(50),\"RecordDate\" DATETIME,\"CreateDate\" DATETIME DEFAULT CURRENT_TIMESTAMP);"];
        //血糖記錄
        [db executeUpdate:@"CREATE TABLE if not exists \"RecordBloodSugar\" (\"ID\" CHAR(36) PRIMARY KEY  NOT NULL  UNIQUE,\"BloodSugarGuid\" CHAR(36),\"Name\" CHAR(100),\"Measure\" CHAR(50),\"BloodSugar\" CHAR(50),\"TimeSpan\" CHAR(50),\"UserId\" CHAR(50),\"RecordDate\" DATETIME, \"CreateDate\" DATETIME DEFAULT CURRENT_TIMESTAMP);"];
        [db commit];
        [db close];
    }

}
- (NSMutableArray*)searchAreaWithCategory:(NSString*)guid areaGuid:(NSString*)areaGuid source:(NSArray*)source{
    if (source==nil) {
        source=[self searchWithCategory:guid aresGuid:@""];
    }
    NSLog(@"len=%d",[source count]);
    NSMutableArray *result=[NSMutableArray array];
    [result addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"所有區域",@"Name",@"",@"ID", nil]];
    if (source&&[source count]>0&&self.allAreas&&[self.allAreas count]>0) {
       
        for (NSDictionary *item in self.allAreas) {
            if ([[item objectForKey:@"Name"] isEqualToString:@"所有區域"]) {
                continue;
            }
            NSString *memo=areaGuid&&[areaGuid length]>0?[NSString stringWithFormat:@" AND self.CategoryGuid=='%@'",guid]:@"";
            NSString *match=[NSString stringWithFormat:@"SELF.Address CONTAINS[cd] '%@'%@",[item objectForKey:@"Name"],memo];
            NSLog(@"match=%@",match);
            NSPredicate *predicate = [NSPredicate predicateWithFormat:match];
            NSArray *arr=[source filteredArrayUsingPredicate:predicate];
            if (arr&&[arr count]>0) {
                
                 NSString *match1=[NSString stringWithFormat:@"SELF.Name=='%@'",[item objectForKey:@"Name"]];
                 NSPredicate *predicate1 = [NSPredicate predicateWithFormat:match1];
                 NSArray *arr1=[result filteredArrayUsingPredicate:predicate1];
                if ([arr1 count]==0) {
                    [result addObject:item];
                }
                
            }
        }
    }
    return result;
}
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
        NSString *sql=[NSString stringWithFormat:@"SELECT * FROM InformationArea where exists(select 1 from  Information where  TYPE='%@' and ADDRESS like '%%' || InformationArea.Name || '%%') order by Sort ASC",[self tableName]];
        //NSString *sql=@"SELECT * FROM InformationArea";

        //NSLog(@"sql=%@",sql);
        FMResultSet *rs = [db executeQuery:sql];
        while (rs.next) {
            [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:[rs stringForColumn:@"Name"],@"Name",[rs stringForColumn:@"Name"],@"ID", nil]];
        }
        [db close];
    }
    return sources;
}
- (NSMutableArray*)areasWithCategory:(NSString*)guid{
    NSMutableArray *sources=[NSMutableArray array];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"所有區域",@"Name",@"",@"ID", nil]];
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    if ([db open]) {
        /***
         select * from InformationArea,Information
         where Information.TYPE='1';
         ***/
        NSMutableString *cmdText=[NSMutableString stringWithFormat:@"SELECT * FROM InformationArea where exists"];
        [cmdText appendFormat:@"(select 1 from  Information where  TYPE='%@' and ADDRESS like '%%' || InformationArea.Name || '%%'",[self tableName]];
        if (guid&&[guid length]>0) {
            [cmdText appendFormat:@" and CATEGORY='%@')",guid];
        }else{
            [cmdText appendString:@")"];
        }
        [cmdText appendString:@" order by Sort ASC"];
        FMResultSet *rs = [db executeQuery:cmdText];
        while (rs.next) {
            [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:[rs stringForColumn:@"Name"],@"Name",[rs stringForColumn:@"Name"],@"ID", nil]];
        }
        [db close];
    }
    return sources;
}
//取得所有數據
- (NSMutableArray*)tableDataList{
    //Information
   NSMutableString *sql=[NSMutableString stringWithFormat:@"SELECT * FROM Information where TYPE='%@'",[self tableName]];
    NSMutableArray *sources=[NSMutableArray array];
    //NSString *categoryColumnName=[NSString stringWithFormat:@"%@Guid",[self categoryTableName]];
    //NSString *areaColumnName=[NSString stringWithFormat:@"%@Guid",[self areaTableName]];
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    if ([db open]) {//表示打開
        FMResultSet *rs = [db executeQuery:sql];
        while (rs.next) {
            BasicModel *entity=(BasicModel*)[[self.customSubclass alloc] init];
            entity.ID=[rs stringForColumn:@"_id"];
            entity.Name=[rs stringForColumn:@"NAME"];
            entity.Address=[rs stringForColumn:@"ADDRESS"];
            entity.Tel=[rs stringForColumn:@"PHONE"];
            entity.CategoryGuid=[rs stringForColumn:@"CATEGORY"];
            entity.AreaGuid=[rs stringForColumn:@"TYPE"];
            entity.WebSiteURL=[rs stringForColumn:@"SITE"];
            entity.Lat=[rs stringForColumn:@"LAT"];
            entity.Lng=[rs stringForColumn:@"LNG"];
            entity.Distance=[rs stringForColumn:@"DISTANCE"];
            entity.Detial=[rs stringForColumn:@"DETIAL"];
            entity.Register=[rs stringForColumn:@"REGISTER"];
            [self setColumnValueWithModel:entity resultSet:rs];
            [sources addObject:entity];
        }
        [db close];
    }
    return sources;
}
//註冊mode子類別
-(void) registerBasicModelSubclass:(Class) aClass{
    self.customSubclass = aClass;
}
- (NSMutableArray*)searchWithCategory:(NSString*)category
                             aresGuid:(NSString*)areaId
                                 size:(int)size
                                 page:(int)page{
    //防止出錯
    if (![self.customSubclass isSubclassOfClass:[BasicModel class]]) {
        [self registerBasicModelSubclass:[BasicModel class]];
    }
    
    //NSString *categoryColumnName=[NSString stringWithFormat:@"%@Guid",[self categoryTableName]];
   // NSString *areaColumnName=[NSString stringWithFormat:@"%@Guid",[self areaTableName]];
    NSMutableString *sql=[NSMutableString stringWithFormat:@"SELECT * FROM Information where TYPE='%@'",[self tableName]];
    if (category&&[category length]>0) {
        [sql appendFormat:@" and CATEGORY='%@'",category];
    }
    if (areaId&&[areaId length]>0) {
        [sql appendFormat:@" and ADDRESS like '%%%@%%'",areaId];
    }
    [sql appendString:@" order by Name"];
    [sql appendFormat:@" limit %d offset %d",size,size*(page-1)];
    NSMutableArray *sources=[NSMutableArray array];
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    if ([db open]) {//表示打開
        FMResultSet *rs = [db executeQuery:sql];
        while (rs.next) {
            BasicModel *entity=(BasicModel*)[[self.customSubclass alloc] init];
            entity.ID=[rs stringForColumn:@"_id"];
            entity.Name=[rs stringForColumn:@"NAME"];
            entity.Address=[rs stringForColumn:@"ADDRESS"];
            entity.Tel=[rs stringForColumn:@"PHONE"];
            entity.CategoryGuid=[rs stringForColumn:@"CATEGORY"];
            entity.AreaGuid=[rs stringForColumn:@"TYPE"];
            entity.WebSiteURL=[rs stringForColumn:@"SITE"];
            entity.Lat=[rs stringForColumn:@"LAT"];
            entity.Lng=[rs stringForColumn:@"LNG"];
            entity.Distance=[rs stringForColumn:@"DISTANCE"];
            entity.Detial=[rs stringForColumn:@"DETIAL"];
            entity.Register=[rs stringForColumn:@"REGISTER"];
            [self setColumnValueWithModel:entity resultSet:rs];
            [sources addObject:entity];
        }
        [db close];
    }
    return sources;
}
- (NSMutableArray*)searchWithCategory:(NSString*)category
                             aresGuid:(NSString*)areaId{
    //防止出錯
    if (![self.customSubclass isSubclassOfClass:[BasicModel class]]) {
        [self registerBasicModelSubclass:[BasicModel class]];
    }
    NSMutableString *sql=[NSMutableString stringWithFormat:@"SELECT * FROM Information where TYPE='%@'",[self tableName]];
    if (category&&[category length]>0) {
        [sql appendFormat:@" and CATEGORY='%@'",category];
    }
    if (areaId&&[areaId length]>0) {
        [sql appendFormat:@" and ADDRESS like '%%%@%%'",areaId];
    }
    [sql appendString:@" order by Name"];
    //NSLog(@"sql=%@",sql);
    NSMutableArray *sources=[NSMutableArray array];
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    if ([db open]) {//表示打開
        FMResultSet *rs = [db executeQuery:sql];
        while (rs.next) {
            BasicModel *entity=(BasicModel*)[[self.customSubclass alloc] init];
            entity.ID=[rs stringForColumn:@"_id"];
            entity.Name=[rs stringForColumn:@"NAME"];
            entity.Address=[rs stringForColumn:@"ADDRESS"];
            entity.Tel=[rs stringForColumn:@"PHONE"];
            entity.CategoryGuid=[rs stringForColumn:@"CATEGORY"];
            entity.AreaGuid=[rs stringForColumn:@"TYPE"];
            entity.WebSiteURL=[rs stringForColumn:@"SITE"];
            entity.Lat=[rs stringForColumn:@"LAT"];
            entity.Lng=[rs stringForColumn:@"LNG"];
            entity.Distance=[rs stringForColumn:@"DISTANCE"];
            entity.Detial=[rs stringForColumn:@"DETIAL"];
            entity.Register=[rs stringForColumn:@"REGISTER"];
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
