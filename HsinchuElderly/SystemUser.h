//
//  SystemUser.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/9.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemUser : NSObject<NSCoding>
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *Name;
@property (nonatomic,copy) NSString *PhotoURL;
@property (nonatomic,assign) NSInteger Sex;
@property (nonatomic,copy) NSString *CreateDate;
@end

// static char *sql = "create table if not exists clockTable(ID INTEGER PRIMARY KEY AUTOINCREMENT, clockID int, clockValue text, repeatValue int, labelValue text)";
