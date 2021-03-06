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
#import "ChartRecord.h"
@implementation RecordBloodSugarHelper
- (BOOL)addRecord:(RecordBloodSugar*)entity{
    entity.ID=[NSString createGUID];
    
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
        NSString *sql=@"update RecordBloodSugar set Measure=?,BloodSugar=?,TimeSpan=?,RecordDate=? where ID=?";
        boo=[db executeUpdate:sql,entity.Measure,entity.BloodSugar,entity.TimeSpan,entity.RecordDate,entity.ID];
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
        NSString *sql=[NSString stringWithFormat:@"select * from RecordBloodSugar where UserId='%@' order by RecordDate DESC",guid];
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
//取得最大与最小的血糖值
- (NSMutableArray*)getMaxMinSugarfindByUser:(NSString*)guid{
    //NSString *time=[[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
    NSMutableArray *sources=[NSMutableArray array];
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    if ([db open]) {
        NSString *sql=[NSString stringWithFormat:@"select * from RecordBloodSugar where BloodSugar in (select MAX(BloodSugar) from RecordBloodSugar where UserId='%@')",guid];
        FMResultSet *rs = [db executeQuery:sql];
        NSString *memo=@"";
        while (rs.next) {
            if ([rs stringForColumn:@"RecordDate"]&&[[rs stringForColumn:@"RecordDate"] length]>0) {
                memo=[[rs stringForColumn:@"RecordDate"] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
            }
            if ([rs stringForColumn:@"BloodSugar"]&&[[rs stringForColumn:@"BloodSugar"] length]>0) {
                memo=[NSString stringWithFormat:@"%@ 最高值:%@",memo,[rs stringForColumn:@"BloodSugar"]];
            }
        }
        [sources addObject:memo];
        [db close];
    }
    if ([db open]) {
        NSString *sql=[NSString stringWithFormat:@"select * from RecordBloodSugar where BloodSugar in (select MIN(BloodSugar) from RecordBloodSugar where UserId='%@')",guid];
        FMResultSet *rs = [db executeQuery:sql];
         NSString *memo=@"";
        while (rs.next) {
            if ([rs stringForColumn:@"RecordDate"]&&[[rs stringForColumn:@"RecordDate"] length]>0) {
                memo=[[rs stringForColumn:@"RecordDate"] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
            }
            if ([rs stringForColumn:@"BloodSugar"]&&[[rs stringForColumn:@"BloodSugar"] length]>0) {
                memo=[NSString stringWithFormat:@"%@ 最低值:%@",memo,[rs stringForColumn:@"BloodSugar"]];
            }
        }
        [sources addObject:memo];
        [db close];
    }
    return sources;
}
//取得饭前资图表资料
- (NSMutableArray*)beforeMealsWithSource:(NSArray*)source{
    NSMutableArray *results=[NSMutableArray array];
    if (source&&[source count]>0) {
        for (RecordBloodSugar *item in source) {
            if([item.Measure isEqualToString:@"0"]||[item.Measure isEqualToString:@"2"]||[item.Measure isEqualToString:@"4"])
            {
                ChartRecord *entity=[[ChartRecord alloc] init];
                entity.chartDate=item.chartDateText;
                entity.chartValue=item.BloodSugar;
                [results addObject:entity];
            }
        }
    }
    return results;
}
//取得饭后资图表资料
- (NSMutableArray*)afterMealsWithSource:(NSArray*)source{
    NSMutableArray *results=[NSMutableArray array];
    if (source&&[source count]>0) {
        for (RecordBloodSugar *item in source) {
            if([item.Measure isEqualToString:@"1"]||[item.Measure isEqualToString:@"3"]||[item.Measure isEqualToString:@"5"])
            {
                ChartRecord *entity=[[ChartRecord alloc] init];
                entity.chartDate=item.chartDateText;
                entity.chartValue=item.BloodSugar;
                [results addObject:entity];
            }
        }
    }
    return results;
}
@end
