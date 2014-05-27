//
//  SystemUserHelper.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/9.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "SystemUserHelper.h"
#import "FileHelper.h"
#import "UIImage+TPCategory.h"
#import "MedicineDrugHelper.h"
#import "BloodHelper.h"
#import "BloodSugarHelper.h"
#define saveImageFilePath [DocumentPath stringByAppendingPathComponent:@"SystemUserImage"]

@interface SystemUserHelper ()
@property (nonatomic,strong) NSMutableArray *userDataSource;
@property (nonatomic,strong) MedicineDrugHelper *drugHelper;
@property (nonatomic,strong) BloodHelper *bloodHelper;
@property (nonatomic,strong) BloodSugarHelper *bloodsugarHelper;
- (BOOL)findById:(NSString*)sysId position:(NSInteger*)index;
@end

@implementation SystemUserHelper

-(id)init{
    if (self=[super init]) {
        self.drugHelper=[[MedicineDrugHelper alloc] init];
        self.bloodHelper=[[BloodHelper alloc] init];
        self.bloodsugarHelper=[[BloodSugarHelper alloc] init];
    }
    return self;
}

- (void)loadDataSource{
    NSString *path=[DocumentPath stringByAppendingPathComponent:@"systemUser.db"];
    NSMutableArray *source=[NSMutableArray array];

    if([FileHelper existsFilePath:path]){ //如果不存在
        [source addObjectsFromArray:[NSKeyedUnarchiver unarchiveObjectWithFile: path]];
    }
    self.userDataSource=source;
}

- (NSMutableArray*)systemUsers{
    if (self.userDataSource&&[self.userDataSource count]>0) {
       return self.userDataSource;
    }else{
        [self loadDataSource];
    }
    return self.userDataSource;
}
- (NSMutableArray*)dictonaryUsers{
    NSMutableArray *source=[NSMutableArray array];
    [source addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"無特定對象",@"Name",@"A001",@"ID", nil]];
    if (self.userDataSource&&[self.userDataSource count]>0) {
    for (SystemUser *item in self.userDataSource) {
        [source addObject:[NSDictionary dictionaryWithObjectsAndKeys:item.Name,@"Name",item.ID,@"ID", nil]];
    }
    }
    return source;
}
- (void)addEditUserWithModel:(SystemUser*)entity headImage:(UIImage*)image{
    [FileHelper createDirectoryWithPath:saveImageFilePath];
    if (image) {//儲存圖片
        NSString *path=[saveImageFilePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",entity.ID]];
        [image saveImage:path];
        entity.PhotoURL=path;
    }
    NSInteger index;
    BOOL boo=[self findById:entity.ID position:&index];
    NSMutableArray *source=[self systemUsers];
    if (boo) {//存在就修改
        [source replaceObjectAtIndex:index withObject:entity];
    }else{//新增
        [source addObject:entity];
    }
    [self saveWithSources:source];
}
- (void)removeUserWithModel:(SystemUser*)entity{
    NSMutableArray *arr=[self systemUsers];
    if (arr&&[arr count]>0) {
        NSString *match=[NSString stringWithFormat:@"SELF.ID =='%@'",entity.ID];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:match];
        NSArray *results = [arr filteredArrayUsingPredicate:predicate];
        if (results&&[results count]>0) {
            id item=[results objectAtIndex:0];
            NSInteger index=[arr indexOfObject:item];
            if (index!=NSNotFound) {
                [arr removeObjectAtIndex:index];
                [self saveWithSources:arr];
            }
        }
    }
}
- (SystemUser*)findUserWithId:(NSString*)userId{
    NSMutableArray *arr=[self systemUsers];
    if (arr&&[arr count]>0) {
        NSString *match=[NSString stringWithFormat:@"SELF.ID =='%@'",userId];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:match];
        NSArray *results = [arr filteredArrayUsingPredicate:predicate];
        if (results&&[results count]>0) {
            return (SystemUser*)[results objectAtIndex:0];
        }
    }
    return nil;
}
- (BOOL)existsUserWithId:(NSString*)userId{
    if ([self.drugHelper existsByUserId:userId]) {
        return NO;
    }
    if ([self.bloodHelper existsByUserId:userId]) {
        return NO;
    }
    if ([self.bloodsugarHelper existsByUserId:userId]) {
        return NO;
    }
    return YES;
}
- (void)removeUserPhotoWithId:(NSString*)userId{
    NSString *path=[saveImageFilePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",userId]];
    [FileHelper deleteFileWithPath:path];
}
- (BOOL)findById:(NSString*)sysId position:(NSInteger*)index{
    NSArray *arr=[self systemUsers];
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
        NSString *path=[DocumentPath stringByAppendingPathComponent:@"systemUser.db"];
        [NSKeyedArchiver archiveRootObject:sources toFile:path];
    }
}
@end
