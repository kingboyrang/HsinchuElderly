//
//  RecordRemindHelper.m
//  HsinchuElderly
//
//  Created by aJia on 2014/6/18.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "RecordRemindHelper.h"
#import "FMDatabase.h"
#import "NSDate+TPCategory.h"
@implementation RecordRemindHelper
- (NSArray*)searchRecordWithType:(NSString*)type startDate:(NSString*)bdate endDate:(NSString*)edate{
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    NSMutableArray *sources=[NSMutableArray array];
    if ([db open]) {
        NSString *tableName=[type isEqualToString:@"1"]?@"RecordDrug":([type isEqualToString:@"2"]?@"RecordBlood":@"RecordBloodSugar");
        NSString *sql=[NSString stringWithFormat:@"SELECT strftime('%%d',CreateDate) FROM %@ where RecordDate>='%@' and RecordDate<='%@'",tableName,bdate,edate];
        FMResultSet *rs = [db executeQuery:sql];
        NSString *val=@"";
        while (rs.next) {
            val=[rs stringForColumnIndex:0];
            [sources addObject:[NSNumber numberWithInt:[val intValue]]];
        }
        [db close];
    }
    return sources;
}
- (NSArray*)searchRecordWithType:(NSString*)type searchDate:(NSString*)bdate{
   NSString *tableName=[type isEqualToString:@"1"]?@"RecordDrug":([type isEqualToString:@"2"]?@"RecordBlood":@"RecordBloodSugar");
   FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
   NSMutableArray *sources=[NSMutableArray array];
   if ([db open]) {
       NSString *sql=[NSString stringWithFormat:@"SELECT * FROM %@ where RecordDate='%@' order by CreateDate desc",tableName,bdate];
       FMResultSet *rs = [db executeQuery:sql];
       while (rs.next) {
           RecordRemind *mod=[[RecordRemind alloc] init];
           mod.ID=[rs stringForColumn:@"ID"];
           mod.Name=[rs stringForColumn:@"Name"];
           mod.TimeSpan=[rs stringForColumn:@"TimeSpan"];
           mod.RecordDate=[rs stringForColumn:@"RecordDate"];
           mod.Type=type;
           if ([type isEqualToString:@"1"]) {
               mod.DetailValue1=[rs stringForColumn:@"DrugName"];
           }
           if ([type isEqualToString:@"2"]) {
               mod.DetailValue1=[rs stringForColumn:@"Shrink"];
               mod.DetailValue2=[rs stringForColumn:@"Diastolic"];
           }
           if ([type isEqualToString:@"3"]) {
               mod.DetailValue1=[rs stringForColumn:@"BloodSugar"];
           }
           [sources addObject:mod];
       }
       [db close];
   }
   return sources;
}
- (NSString*)searchMaxDateWithType:(NSString*)type startDate:(NSString*)bdate endDate:(NSString*)edate{
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    if ([db open]) {
        NSString *tableName=[type isEqualToString:@"1"]?@"RecordDrug":([type isEqualToString:@"2"]?@"RecordBlood":@"RecordBloodSugar");
        NSString *sql=[NSString stringWithFormat:@"SELECT max(RecordDate) FROM %@ where RecordDate>='%@' and RecordDate<='%@'",tableName,bdate,edate];
        FMResultSet *rs = [db executeQuery:sql];
        NSString *val=@"";
        while (rs.next) {
            val=[[rs stringForColumnIndex:0] Trim];
        }
        [db close];
        return val;
    }
    return nil;
}
+ (BOOL)insertRecordDrug:(NSDictionary*)dic{
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    BOOL boo=NO;
    if ([db open]) {
        NSString *time=[[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
        NSString *sql=@"insert into RecordDrug(ID,DrugGuid,Name,DrugName,TimeSpan,RecordDate) values(?,?,?,?,?,?)";
        boo=[db executeUpdate:sql,[NSString createGUID],[dic objectForKey:@"guid"],[dic objectForKey:@"UserName"],[dic objectForKey:@"Name"],[dic objectForKey:@"TimeSpan"],time];
        [db close];
    }
    return boo;
}
//血壓記錄
+ (BOOL)insertRecordBlood:(NSDictionary*)dic shrink:(NSString*)value1 diastolic:(NSString*)value2{
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    BOOL boo=NO;
    if ([db open]) {
        NSString *time=[[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
        NSString *sql=@"insert into RecordBlood(ID,BloodGuid,Name,Shrink,Diastolic,TimeSpan,RecordDate,Pulse) values(?,?,?,?,?,?,?,?)";
        boo=[db executeUpdate:sql,[NSString createGUID],[dic objectForKey:@"guid"],[dic objectForKey:@"UserName"],value1,value2,[dic objectForKey:@"TimeSpan"],time];
        [db close];
    }
    return boo;
}
+ (BOOL)insertRecordBloodSugar:(NSDictionary*)dic sugar:(NSString*)value{
    FMDatabase *db=[FMDatabase databaseWithPath:HEDBPath];
    BOOL boo=NO;
    if ([db open]) {
        NSString *time=[[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
        NSString *sql=@"insert into RecordBloodSugar(ID,BloodSugarGuid,Name,BloodSugar,TimeSpan,RecordDate) values(?,?,?,?,?,?)";
        boo=[db executeUpdate:sql,[NSString createGUID],[dic objectForKey:@"guid"],[dic objectForKey:@"UserName"],value,[dic objectForKey:@"TimeSpan"],time];
        [db close];
    }
    return boo;
}
@end
