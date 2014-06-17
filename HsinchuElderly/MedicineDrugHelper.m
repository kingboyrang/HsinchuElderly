//
//  MedicineDrugHelper.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "MedicineDrugHelper.h"
#import "FileHelper.h"
#import "AppHelper.h"
@interface MedicineDrugHelper ()
@property (nonatomic,strong) NSMutableArray *drugDataSource;
- (BOOL)findById:(NSString*)sysId position:(NSInteger*)index;
@end

@implementation MedicineDrugHelper

+ (BOOL)existsDrugs{
    NSString *path=[DocumentPath stringByAppendingPathComponent:@"medicineDrug.db"];
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
    NSString *path=[DocumentPath stringByAppendingPathComponent:@"medicineDrug.db"];
    NSMutableArray *source=[NSMutableArray array];
    if([FileHelper existsFilePath:path]){ //如果不存在
        [source addObjectsFromArray:[NSKeyedUnarchiver unarchiveObjectWithFile: path]];
    }
    self.drugDataSource=source;
}
- (NSMutableArray*)medicineDrugs{
    if (self.drugDataSource&&[self.drugDataSource count]>0) {
        return self.drugDataSource;
    }else{
        [self loadDataSource];
    }
    return self.drugDataSource;
}
- (void)addEditDrugWithModel:(MedicineDrug*)entity name:(NSString*)name{
    NSInteger index;
    BOOL boo=[self findById:entity.ID position:&index];
    NSMutableArray *source=[self medicineDrugs];
     NSString *msg=[NSString stringWithFormat:PushDrugMessage,name];
    if (boo) {//存在就修改
        [source replaceObjectAtIndex:index withObject:entity];
         [AppHelper removeLocationNoticeWithName:entity.ID];
    }else{//新增
        [source addObject:entity];
    }
    [AppHelper sendLocationNotice:entity.ID sendType:@"1" message:msg noticeDate:entity.repeatDate repeatInterval:entity.repeatInterval];
    [self saveWithSources:source];
}
- (BOOL)findById:(NSString*)sysId position:(NSInteger*)index{
    NSArray *arr=[self medicineDrugs];
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
    if (sources&&[sources count]>0) {
        NSString *path=[DocumentPath stringByAppendingPathComponent:@"medicineDrug.db"];
        [NSKeyedArchiver archiveRootObject:sources toFile:path];
    }
}
- (BOOL)existsByUserId:(NSString*)userId{
    NSMutableArray *arr=[self medicineDrugs];
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
