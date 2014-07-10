//
//  BloodSugar.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BloodSugar : NSObject<NSCoding,NSCopying>
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *UserId;//使用者id
@property (nonatomic,copy) NSString *UserName;//使用者名稱
@property (nonatomic,copy) NSString *Rate;//頻率
@property (nonatomic,assign) NSInteger RateCount;//頻率次数
@property (nonatomic,copy) NSString *TimeSpan;//定時時間
@property (nonatomic,copy) NSString *CreateDate;//建立時間

@property (nonatomic,readonly) NSString *TimeSpanText;
@property (nonatomic,readonly) NSCalendarUnit repeatInterval;
@property (nonatomic,readonly) NSDate *repeatDate;

//设定闹钟
- (void)sendLocalNotificeWithMessage:(NSString*)msg;
//设定闹钟
- (void)addLocalNotificeWithMessage:(NSString*)msg;
//移除设定闹钟
- (void)removeNotifices;
@end
