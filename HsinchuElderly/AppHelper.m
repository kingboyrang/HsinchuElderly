//
//  AppHelper.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/21.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "AppHelper.h"

@implementation AppHelper
//发送下载完成的本地通知
+ (void)sendLocationNotice:(NSString*)noticeKey message:(NSString*)msg noticeDate:(NSDate*)date repeatInterval:(NSCalendarUnit)repeat{
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
       // NSDate *now=[NSDate new];
        //notification.fireDate=[now dateByAddingTimeInterval:10];//10秒后通知
        notification.fireDate=date;//10秒后通知
        notification.repeatInterval=repeat;//循环次数，kCFCalendarUnitWeekday一周一次
        notification.repeatCalendar=[NSCalendar currentCalendar];
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber=1; //应用的红色数字
        notification.soundName= UILocalNotificationDefaultSoundName;//声音，可以换成alarm.soundName = @"myMusic.caf"
        //去掉下面2行就不会弹出提示框
        notification.alertBody=msg;//提示信息 弹出提示框
        //notification.alertAction = @"是";  //提示框按钮
        //notification.hasAction=YES;
        //notification.hasAction = NO; //是否显示额外的按钮，为no时alertAction消失
        NSDictionary *infoDict = [NSDictionary dictionaryWithObject:noticeKey forKey:@"guid"];
        notification.userInfo = infoDict; //添加额外的信息
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}
//取消一个通知
+ (void)removeLocationNoticeWithName:(NSString*)name{
    NSArray *narry=[[UIApplication sharedApplication] scheduledLocalNotifications];
    NSUInteger acount=[narry count];
    if (acount>0)
    {
        // 遍历找到对应nfkey和notificationtag的通知
        for (int i=0; i<acount; i++)
        {
            UILocalNotification *myUILocalNotification = [narry objectAtIndex:i];
            NSDictionary *userInfo = myUILocalNotification.userInfo;
            NSString *obj = [userInfo objectForKey:@"guid"];
            if ([obj isEqualToString:name])
            {
                // 删除本地通知
                [[UIApplication sharedApplication] cancelLocalNotification:myUILocalNotification];
                break;
            }
        }
    }
}
//取消所有通知
+ (void)removeLocationNotice{
   [[UIApplication sharedApplication] cancelAllLocalNotifications]; // 撤销所有的Notification
}
@end
