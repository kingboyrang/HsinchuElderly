//
//  MedicineDrug.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/9.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MedicineDrug : NSObject<NSCoding,NSCopying>
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *UserId;//使用者id
@property (nonatomic,copy) NSString *UserName;//使用者名稱
@property (nonatomic,copy) NSString *Name;//藥名
@property (nonatomic,copy) NSString *Rate;//頻率
@property (nonatomic,copy) NSString *TimeSpan;//定時時間
@property (nonatomic,copy) NSString *CreateDate;//建立時間

@property (unsafe_unretained) NSUInteger myHash;
@property (nonatomic,readonly) NSString *TimeSpanText;
@property (nonatomic,readonly) NSCalendarUnit repeatInterval;
@property (nonatomic,readonly) NSDate *repeatDate;
@end
