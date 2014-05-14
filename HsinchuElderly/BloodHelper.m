//
//  BloodHelper.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "BloodHelper.h"
#import "FileHelper.h"

@interface BloodHelper ()
@property (nonatomic,strong) NSMutableArray *drugDataSource;
- (BOOL)findById:(NSString*)sysId position:(NSInteger*)index;
@end
@implementation BloodHelper
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
- (void)addEditDrugWithModel:(Blood*)entity{
    NSInteger index;
    BOOL boo=[self findById:entity.ID position:&index];
    NSMutableArray *source=[self pressureBloods];
    if (boo) {//存在就修改
        [source replaceObjectAtIndex:index withObject:entity];
    }else{//新增
        [source addObject:entity];
    }
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
    if (sources&&[sources count]>0) {
        NSString *path=[DocumentPath stringByAppendingPathComponent:@"blood.db"];
        [NSKeyedArchiver archiveRootObject:sources toFile:path];
    }
}
@end
