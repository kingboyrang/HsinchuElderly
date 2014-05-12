//
//  BloodSugar.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BloodSugar : NSObject<NSCoding>
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *UserId;//用户id
@property (nonatomic,copy) NSString *Rate;//频率
@property (nonatomic,copy) NSString *TimeSpan;//定时时间
@property (nonatomic,copy) NSString *CreateDate;//创建时间

@property (nonatomic,readonly) NSString *TimeSpanText;
@end
