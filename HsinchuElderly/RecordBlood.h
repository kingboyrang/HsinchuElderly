//
//  RecordBlood.h
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordBlood : NSObject
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *Shrink;
@property (nonatomic,copy) NSString *Diastolic;
@property (nonatomic,copy) NSString *Pulse;
@property (nonatomic,copy) NSString *TimeSpan;
@property (nonatomic,copy) NSString *RecordDate;
@property (nonatomic,copy) NSString *UserId;


@property (nonatomic,readonly) NSString *BloodDetail;
@property (nonatomic,readonly) NSString *TimeSpanText;
@end

/**
 @"CREATE TABLE if not exists \"RecordBlood\" (\"ID\" CHAR(36) PRIMARY KEY  NOT NULL  UNIQUE,\"BloodGuid\" CHAR(36), \"Name\" CHAR(100), \"Shrink\" CHAR(50),\"Diastolic\" CHAR(50),\"Pulse\" CHAR(50),\"TimeSpan\" CHAR(50),\"RecordDate\" DATETIME,\"CreateDate\" DATETIME DEFAULT CURRENT_TIMESTAMP);"
 **/
