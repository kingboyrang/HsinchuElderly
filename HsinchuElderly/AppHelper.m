//
//  AppHelper.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/21.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "AppHelper.h"
#import "SendMailViewController.h"
@implementation AppHelper
//發送下載完成的通知
+ (void)sendLocationNotice:(NSString*)noticeKey sendType:(NSString*)type message:(NSString*)msg noticeDate:(NSDate*)date repeatInterval:(NSCalendarUnit)repeat{
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
       // NSDate *now=[NSDate new];
        //notification.fireDate=[now dateByAddingTimeInterval:10];//10秒後通知
        notification.fireDate=date;//10秒後通知
        notification.repeatInterval=repeat;//循环次数，kCFCalendarUnitWeekday一周一次
        notification.repeatCalendar=[NSCalendar currentCalendar];
        notification.timeZone=[NSTimeZone defaultTimeZone];
        //notification.applicationIconBadgeNumber=1; //應用的红色數字
        notification.soundName= UILocalNotificationDefaultSoundName;//声音，可以換成alarm.soundName = @"myMusic.caf"
        //去掉下面2行就不會彈出提示框
        notification.alertBody=msg;//提示訊息 彈出提示框
        notification.alertAction = @"確定";  //提示框按钮
        //notification.hasAction=YES;
        notification.hasAction = NO; //是否顯示額外的按钮，為no時alertAction消失
        NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:noticeKey,@"guid",type,@"type", nil];
        notification.userInfo = infoDict; //增加額外的訊息
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}
+ (void)sendLocationNotice:(NSDictionary*)userInfo message:(NSString*)msg noticeDate:(NSDate*)date repeatInterval:(NSCalendarUnit)repeat{
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
        // NSDate *now=[NSDate new];
        //notification.fireDate=[now dateByAddingTimeInterval:10];//10秒後通知
        notification.fireDate=date;//10秒後通知
        notification.repeatInterval=repeat;//循环次数，kCFCalendarUnitWeekday一周一次
        notification.repeatCalendar=[NSCalendar currentCalendar];
        notification.timeZone=[NSTimeZone defaultTimeZone];
        //notification.applicationIconBadgeNumber=[[[UIApplication sharedApplication] scheduledLocalNotifications] count]+1; //應用的红色數字
        notification.soundName= UILocalNotificationDefaultSoundName;//声音，可以換成alarm.soundName = @"myMusic.caf"
        //去掉下面2行就不會彈出提示框
        notification.alertBody=msg;//提示訊息 彈出提示框
        notification.alertAction = @"確定";  //提示框按钮
        //notification.hasAction=YES;
        notification.hasAction = NO; //是否顯示額外的按钮，為no時alertAction消失
        notification.userInfo = userInfo; //增加額外的訊息
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }

}
//取消一個通知
+ (void)removeLocationNoticeWithName:(NSString*)name{
    NSArray *narry=[[UIApplication sharedApplication] scheduledLocalNotifications];
    NSUInteger acount=[narry count];
    if (acount>0)
    {
        // 遍歷找到對應nfkey和notificationtag的通知
        for (int i=0; i<acount; i++)
        {
            UILocalNotification *myUILocalNotification = [narry objectAtIndex:i];
            NSDictionary *userInfo = myUILocalNotification.userInfo;
            NSString *obj = [userInfo objectForKey:@"guid"];
            if ([obj isEqualToString:name])
            {
                // 删除通知
                [[UIApplication sharedApplication] cancelLocalNotification:myUILocalNotification];
                break;
            }
        }
    }
}
//取消所有通知
+ (void)removeLocationNotice{
   [[UIApplication sharedApplication] cancelAllLocalNotifications]; // 撤銷所有的Notification
}
+ (void)setNavigationBarTitleAttrsFontWhite:(BOOL)white{
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 0);
    //整體設置
    UIColor *color=white?[UIColor whiteColor]:[UIColor blackColor];
    
    NSDictionary *dicAttrs=[NSDictionary dictionaryWithObjectsAndKeys:
                            color, NSForegroundColorAttributeName,
                            shadow, NSShadowAttributeName,
                            [UIFont fontWithName:@"Helvetica-Bold" size:20], NSFontAttributeName, nil];
    
    //郵件設置
     if (IOSVersion>=7.0) {
        [[UIBarButtonItem appearanceWhenContainedIn:[UIToolbar class], nil] setTitleTextAttributes:dicAttrs forState:UIControlStateNormal];
        [[UINavigationBar appearance] setTitleTextAttributes:dicAttrs];
        NSDictionary *dicAttrs1=[NSDictionary dictionaryWithObjectsAndKeys:
                             [UIColor blackColor], NSForegroundColorAttributeName,
                             [UIFont fontWithName:@"Helvetica-Bold" size:20], NSFontAttributeName, nil];
   
        [[UINavigationBar appearanceWhenContainedIn:[MFMailComposeViewController class], nil] setTitleTextAttributes:dicAttrs1];
    }
    
    
}
@end
