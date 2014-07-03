//
//  RecordBloodSugarHelper.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "RecordBloodSugarHelper.h"
#import "NSDate+TPCategory.h"
#import "FMDatabase.h"
@implementation RecordBloodSugarHelper
- (BOOL)addRecord:(RecordBloodSugar*)entity{
    NSString *time=[[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
    entity.ID=[NSString createGUID];
    entity.RecordDate=time;
    
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    BOOL boo=NO;
    if ([db open]) {
        NSString *sql=@"insert into RecordBloodSugar(ID,Measure,BloodSugar,TimeSpan,RecordDate,UserId) values(?,?,?,?,?,?)";
        boo=[db executeUpdate:sql,entity.ID,entity.Measure,entity.BloodSugar,entity.TimeSpan,entity.RecordDate,entity.UserId];
        [db close];
    }
    return boo;
}
- (BOOL)editRecord:(RecordBloodSugar*)entity{
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    BOOL boo=NO;
    if ([db open]) {
        NSString *sql=@"update RecordBloodSugar set Measure=?,BloodSugar=?,TimeSpan=? where ID=?";
        boo=[db executeUpdate:sql,entity.Measure,entity.BloodSugar,entity.TimeSpan,entity.ID];
        [db close];
    }
    return boo;
}
- (BOOL)deleteWithGuid:(NSString*)guid{
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    BOOL boo=NO;
    if ([db open]) {
        NSString *sql=@"delete from RecordBloodSugar  where ID=?";
        boo=[db executeUpdate:sql,guid];
        [db close];
    }
    return boo;
}
- (NSMutableArray*)findByUser:(NSString*)guid{
    NSMutableArray *sources=[NSMutableArray array];
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    if ([db open]) {
        NSString *sql=[NSString stringWithFormat:@"select * from RecordBloodSugar where UserId='%@' order by CreateDate DESC",guid];
        FMResultSet *rs = [db executeQuery:sql];
        while (rs.next) {
            RecordBloodSugar *entity=[[RecordBloodSugar alloc] init];
            entity.ID=[rs stringForColumn:@"ID"];
            entity.Measure=[rs stringForColumn:@"Measure"];
            entity.BloodSugar=[rs stringForColumn:@"BloodSugar"];
            entity.TimeSpan=[rs stringForColumn:@"TimeSpan"];
            entity.RecordDate=[rs stringForColumn:@"RecordDate"];
            entity.UserId=[rs stringForColumn:@"UserId"];
            [sources addObject:entity];
        }
        [db close];
    }
    return sources;
}
@end
