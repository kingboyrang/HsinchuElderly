//
//  RecordBloodSugar.h
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordBloodSugar : NSObject
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *Measure;
@property (nonatomic,copy) NSString *BloodSugar;
@property (nonatomic,copy) NSString *TimeSpan;
@property (nonatomic,copy) NSString *RecordDate;
@property (nonatomic,copy) NSString *UserId;

@property (nonatomic,readonly) NSString *monthDayText;
@property (nonatomic,readonly) NSString *MeasureText;
@property (nonatomic,readonly) NSString *SugarDetail;
@property (nonatomic,readonly) NSString *TimeSpanText;
@property (nonatomic,readonly) NSString *chartDateText;
@end
/***
 @"CREATE TABLE if not exists \"RecordBloodSugar\" (\"ID\" CHAR(36) PRIMARY KEY  NOT NULL  UNIQUE,\"BloodSugarGuid\" CHAR(36),\"Name\" CHAR(100),\"Measure\" CHAR(50),\"BloodSugar\" CHAR(50),\"TimeSpan\" CHAR(50),\"RecordDate\" DATETIME, \"CreateDate\" DATETIME DEFAULT CURRENT_TIMESTAMP);"
**/