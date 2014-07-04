//
//  RecordBloodHelper.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "RecordBloodHelper.h"
#import "NSDate+TPCategory.h"
#import "FMDatabase.h"
#import "ChartRecord.h"
@implementation RecordBloodHelper
- (BOOL)addRecord:(RecordBlood*)entity{
    NSString *time=[[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
    entity.ID=[NSString createGUID];
    entity.RecordDate=time;
    
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    BOOL boo=NO;
    if ([db open]) {
        NSString *sql=@"insert into RecordBlood(ID,Shrink,Diastolic,Pulse,TimeSpan,RecordDate,UserId) values(?,?,?,?,?,?,?)";
        boo=[db executeUpdate:sql,entity.ID,entity.Shrink,entity.Diastolic,entity.Pulse,entity.TimeSpan,entity.RecordDate,entity.UserId];
        [db close];
    }
    return boo;
}
- (BOOL)editRecord:(RecordBlood*)entity{
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    BOOL boo=NO;
    if ([db open]) {
        NSString *sql=@"update RecordBlood set Shrink=?,Diastolic=?,Pulse=?,TimeSpan=? where ID=?";
        boo=[db executeUpdate:sql,entity.Shrink,entity.Diastolic,entity.Pulse,entity.TimeSpan,entity.ID];
        [db close];
    }
    return boo;
}
- (BOOL)deleteWithGuid:(NSString*)guid{
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    BOOL boo=NO;
    if ([db open]) {
        NSString *sql=@"delete from RecordBlood  where ID=?";
        boo=[db executeUpdate:sql,guid];
        [db close];
    }
    return boo;
}
- (NSMutableArray*)findByUser:(NSString*)guid{
    NSMutableArray *sources=[NSMutableArray array];
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    if ([db open]) {
        NSString *sql=[NSString stringWithFormat:@"select * from RecordBlood where UserId='%@' order by CreateDate DESC",guid];
        FMResultSet *rs = [db executeQuery:sql];
        while (rs.next) {
            RecordBlood *entity=[[RecordBlood alloc] init];
            entity.ID=[rs stringForColumn:@"ID"];
            entity.Shrink=[rs stringForColumn:@"Shrink"];
            entity.Diastolic=[rs stringForColumn:@"Diastolic"];
            entity.Pulse=[rs stringForColumn:@"Pulse"];
            entity.TimeSpan=[rs stringForColumn:@"TimeSpan"];
            entity.RecordDate=[rs stringForColumn:@"RecordDate"];
            entity.UserId=[rs stringForColumn:@"UserId"];
            [sources addObject:entity];
        }
        [db close];
    }
    return sources;
}
//取得脉搏资料
- (NSMutableArray*)charPulsesWithSource:(NSArray*)source{
    NSMutableArray *results=[NSMutableArray array];
    if (source&&[source count]>0) {
        for (RecordBlood *item in source) {
            ChartRecord *entity=[[ChartRecord alloc] init];
            entity.chartDate=item.TimeSpanText;
            entity.chartValue=item.Pulse;
            [results addObject:entity];
        }
    }
    return results;
}
//取得收缩压资料
- (NSMutableArray*)charShrinksWithSource:(NSArray*)source{
    NSMutableArray *results=[NSMutableArray array];
    if (source&&[source count]>0) {
        for (RecordBlood *item in source) {
            ChartRecord *entity=[[ChartRecord alloc] init];
            entity.chartDate=item.TimeSpanText;
            entity.chartValue=item.Shrink;
            [results addObject:entity];
        }
    }
    return results;
}
//取得舒张压资料
- (NSMutableArray*)charDiastolesWithSource:(NSArray*)source{
    NSMutableArray *results=[NSMutableArray array];
    if (source&&[source count]>0) {
        for (RecordBlood *item in source) {
            ChartRecord *entity=[[ChartRecord alloc] init];
            entity.chartDate=item.TimeSpanText;
            entity.chartValue=item.Diastolic;
            [results addObject:entity];
        }
    }
    return results;
}
@end
