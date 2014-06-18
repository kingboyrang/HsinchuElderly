//
//  AppHelper.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/21.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppHelper : NSObject
+ (void)sendLocationNotice:(NSString*)noticeKey sendType:(NSString*)type message:(NSString*)msg noticeDate:(NSDate*)date repeatInterval:(NSCalendarUnit)repeat;
+ (void)sendLocationNotice:(NSDictionary*)userInfo message:(NSString*)msg noticeDate:(NSDate*)date repeatInterval:(NSCalendarUnit)repeat;
+ (void)removeLocationNoticeWithName:(NSString*)name;
+ (void)removeLocationNotice;
+ (void)setNavigationBarTitleAttrsFontWhite:(BOOL)white;
@end
