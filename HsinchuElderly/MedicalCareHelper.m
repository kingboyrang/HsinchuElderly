//
//  MedicalCareHelper.m
//  HsinchuElderly
//
//  Created by rang on 14-5-10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "MedicalCareHelper.h"
#import "FMDatabase.h"
#import "MedicalCare.h"
@implementation MedicalCareHelper
- (NSMutableArray*)categorys{
    NSMutableArray *sources=[NSMutableArray array];
    [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"所有類別",@"Name",@"",@"ID", nil]];
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    if ([db open]) {
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM MedicalCareCategory"];
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
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM MedicalCareArea"];
        while (rs.next) {
            [sources addObject:[NSDictionary dictionaryWithObjectsAndKeys:[rs stringForColumn:@"Name"],@"Name",[rs stringForColumn:@"ID"],@"ID", nil]];
        }
        [db close];
    }
    return sources;
}
- (NSMutableArray*)searchWithCategory:(NSString*)category
                             aresGuid:(NSString*)areaId
                                 size:(int)size
                                 page:(int)page{
    NSMutableString *sql=[NSMutableString stringWithString:@"SELECT * FROM MedicalCare where 1=1"];
    if (category&&[category length]>0) {
        [sql appendFormat:@" and MedicalCareCategoryGuid='%@'",category];
    }
    if (areaId&&[areaId length]>0) {
        [sql appendFormat:@" and MedicalCareAreaGuid='%@'",areaId];
    }
    [sql appendString:@" order by Name"];
    [sql appendFormat:@" limit %d offset %d",size,size*(page-1)];
    
    NSMutableArray *sources=[NSMutableArray array];
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    if ([db open]) {//表示打开
        FMResultSet *rs = [db executeQuery:sql];
        while (rs.next) {
            MedicalCare *entity=[[MedicalCare alloc] init];
            entity.ID=[rs stringForColumn:@"ID"];
            entity.Name=[rs stringForColumn:@"Name"];
            entity.Address=[rs stringForColumn:@"Address"];
            entity.Tel=[rs stringForColumn:@"Tel"];
            entity.MedicalCareCategoryGuid=[rs stringForColumn:@"MedicalCareCategoryGuid"];
            entity.MedicalCareAreaGuid=[rs stringForColumn:@"MedicalCareAreaGuid"];
            entity.WebSiteURL=[rs stringForColumn:@"WebSiteURL"];
            [sources addObject:entity];
        }
        [db close];
    }
    return sources;
}
@end
