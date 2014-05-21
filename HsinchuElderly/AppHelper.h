//
//  AppHelper.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/21.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppHelper : NSObject
+ (void)sendLocationNotice:(NSString*)noticeKey noticeDate:(NSDate*)date message:(NSString*)msg;
+ (void)removeLocationNoticeWithName:(NSString*)name;
+ (void)removeLocationNotice;
@end
