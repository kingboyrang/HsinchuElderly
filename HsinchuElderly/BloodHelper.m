//
//  BloodHelper.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "BloodHelper.h"
#import "FileHelper.h"
#import "AppHelper.h"
#import "NSDate+TPCategory.h"
@interface BloodHelper ()
@property (nonatomic,strong) NSMutableArray *drugDataSource;
- (BOOL)findById:(NSString*)sysId position:(NSInteger*)index;
@end
@implementation BloodHelper
+ (BOOL)existsBloods{
    NSString *path=[DocumentPath stringByAppendingPathComponent:@"blood.db"];
    NSMutableArray *source=[NSMutableArray array];
    if([FileHelper existsFilePath:path]){ //如果不存在
        [source addObjectsFromArray:[NSKeyedUnarchiver unarchiveObjectWithFile: path]];
    }
    if (source&&[source count]>0) {
        return YES;
    }
    return NO;
}
- (void)loadDataSource{
    NSString *path=[DocumentPath stringByAppendingPathComponent:@"blood.db"];
    NSMutableArray *source=[NSMutableArray array];
    if([FileHelper existsFilePath:path]){ //如果不存在
        [source addObjectsFromArray:[NSKeyedUnarchiver unarchiveObjectWithFile: path]];
    }
    self.drugDataSource=source;
}
- (NSMutableArray*)pressureBloods{
    if (self.drugDataSource&&[self.drugDataSource count]>0) {
        return self.drugDataSource;
    }else{
        [self loadDataSource];
    }
    return self.drugDataSource;
}
- (void)addBloodWithModel:(Blood*)entity name:(NSString*)name{
    NSString *msg=[NSString stringWithFormat:PushBloodMessage,name];
    NSArray *times=[entity.TimeSpan componentsSeparatedByString:@";"];
   NSMutableArray *source=[self pressureBloods];
    for (NSString *item in times) {
        entity.ID=[NSString createGUID];
        entity.CreateDate=[NSDate stringFromDate:[NSDate date] withFormat:@"yyyy/MM/dd HH:mm:ss"];
        entity.TimeSpan=item;
        [entity addLocalNotificeWithMessage:msg];//添加通知
        [source addObject:[entity copy]];
    }
    [self saveWithSources:source];
}
- (void)addEditDrugWithModel:(Blood*)entity name:(NSString*)name{
    NSInteger index;
    BOOL boo=[self findById:entity.ID position:&index];
    NSMutableArray *source=[self pressureBloods];
     NSString *msg=[NSString stringWithFormat:PushBloodMessage,name];
    if (boo) {//存在就修改
        [source replaceObjectAtIndex:index withObject:entity];
        [entity removeNotifices];
    }else{//新增
        [source addObject:entity];
    }
    [entity addLocalNotificeWithMessage:msg];
    [self saveWithSources:source];
}
- (BOOL)findById:(NSString*)sysId position:(NSInteger*)index{
    NSArray *arr=[self pressureBloods];
    if (arr&&[arr count]>0) {
        NSString *match=[NSString stringWithFormat:@"SELF.ID =='%@'",sysId];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:match];
        NSArray *results = [arr filteredArrayUsingPredicate:predicate];
        if (results&&[results count]>0) {
            id item=[results objectAtIndex:0];
            *index=[arr indexOfObject:item];
            return YES;
        }
    }
    return NO;
}
//儲存
-(void)saveWithSources:(NSArray*)sources{
    NSString *path=[DocumentPath stringByAppendingPathComponent:@"blood.db"];
    [NSKeyedArchiver archiveRootObject:sources toFile:path];
}
- (BOOL)existsByUserId:(NSString*)userId{
    NSMutableArray *arr=[self pressureBloods];
    if (arr&&[arr count]>0) {
        NSString *match=[NSString stringWithFormat:@"SELF.UserId =='%@'",userId];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:match];
        NSArray *results = [arr filteredArrayUsingPredicate:predicate];
        if (results&&[results count]>0) {
            return YES;
        }
    }
    return NO;
}
@end
