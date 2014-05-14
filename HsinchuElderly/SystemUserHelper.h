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
//列表
- (NSMutableArray*)systemUsers;
- (NSMutableArray*)dictonaryUsers;
//新增與修改
- (void)addEditUserWithModel:(SystemUser*)entity headImage:(UIImage*)image;
//删除
- (void)removeUserWithModel:(SystemUser*)entity;
- (void)removeUserPhotoWithId:(NSString*)userId;
- (SystemUser*)findUserWithId:(NSString*)userId;
//儲存
- (void)saveWithSources:(NSArray*)sources;
//載入數據
- (void)loadDataSource;
@end
