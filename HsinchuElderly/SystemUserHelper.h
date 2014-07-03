//
//  SystemUserHelper.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/9.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SystemUser.h"
@interface SystemUserHelper : NSObject
@property (nonatomic,readonly) NSMutableArray *sysUsers;
//列表
- (NSMutableArray*)systemUsers;
- (NSMutableArray*)dictonaryUsers;
//新增與修改
- (void)addEditUserWithModel:(SystemUser*)entity headImage:(UIImage*)image;
//sqlite的新增與修改
- (BOOL)addWithModel:(SystemUser*)entity headImage:(UIImage*)image;
- (BOOL)editWithModel:(SystemUser*)entity headImage:(UIImage*)image;
- (BOOL)removeWithModel:(SystemUser*)entity;
//删除
- (void)removeUserWithModel:(SystemUser*)entity;
- (void)removeUserPhotoWithId:(NSString*)userId;
- (SystemUser*)findUserWithId:(NSString*)userId;
- (BOOL)existsUserWithId:(NSString*)userId;
//儲存
- (void)saveWithSources:(NSArray*)sources;
//載入數據
- (void)loadDataSource;
@end
