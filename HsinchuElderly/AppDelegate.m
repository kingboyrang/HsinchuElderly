//
//  AppDelegate.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/7.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "AppDelegate.h"
#import "IndexViewController.h"
#import "FileHelper.h"
#import "AlertHelper.h"
#import "AppHelper.h"
#import "NSDate+TPCategory.h"
#import "HEBasicHelper.h"
#import "RecordRemindHelper.h"
@implementation AppDelegate

- (void)dbInitLoad{
    //控件颜色设置
    [AppHelper setNavigationBarTitleAttrsFontWhite:YES];
   
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"remind" ofType:@"sqlite"];
    NSString *dbPath=[DocumentPath stringByAppendingPathComponent:@"remind.sqlite"];
    if (![FileHelper existsFilePath:dbPath]) {
         NSData *mainBundleFile = [NSData dataWithContentsOfFile:path];
        [[NSFileManager defaultManager] createFileAtPath:dbPath
                                                contents:mainBundleFile
                                              attributes:nil];
        
        [HEBasicHelper createTables];//新建表
    }
    //NSLog(@"path=%@",dbPath);
    [FileHelper createDocumentDirectoryWithName:@"SystemUserImage"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    if (![userDefaults objectForKey:@"flags"]) {
        [userDefaults setValue:@"1" forKey:@"flags"];
        [userDefaults synchronize];
        [AppHelper removeLocationNotice];
        application.applicationIconBadgeNumber=0;
    }
    [self dbInitLoad];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    IndexViewController *index=[[IndexViewController alloc] init];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:index];
    self.window.rootViewController=nav;
    [self.window makeKeyAndVisible];
    
    //处理本地通知
    UILocalNotification *localNotif=[launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif) {
         application.applicationIconBadgeNumber =application.applicationIconBadgeNumber-1;
        [self handlerNotificeWithUseInfo:localNotif.userInfo];
         
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //[self resetBageNumber];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - PopoverViewDelegate
- (void)confirmPopoverWithTarget:(id)sender{
    BasicPopoverView *basic=(BasicPopoverView*)sender;
    NSDictionary *dic=[basic userInfo];
    NSString *type=[dic objectForKey:@"type"];
    if ([type isEqualToString:@"1"]) {//藥物
        //MedicineDrug *mod=(MedicineDrug*)[dic objectForKey:@"entity"];
        BOOL boo=[RecordRemindHelper insertRecordDrug:dic];
        NSString *msg=[NSString stringWithFormat:@"藥物記錄%@",boo?@"成功":@"失敗"];
        [AlertHelper initWithTitle:@"提示" message:msg];
    }
    if ([type isEqualToString:@"2"]) {//血壓
        BloodPopoverView *bloodView=(BloodPopoverView*)sender;
        
        BOOL boo=[RecordRemindHelper insertRecordBlood:dic shrink:bloodView.field1.text diastolic:bloodView.field2.text];
        NSString *msg=[NSString stringWithFormat:@"血壓記錄%@",boo?@"成功":@"失敗"];
        [AlertHelper initWithTitle:@"提示" message:msg];
    }
    if ([type isEqualToString:@"3"]) {//血糖
        BloodSugarPopoverView *bloodView=(BloodSugarPopoverView*)sender;
        BOOL boo=[RecordRemindHelper insertRecordBloodSugar:dic sugar:bloodView.field.text];
        NSString *msg=[NSString stringWithFormat:@"血糖記錄%@",boo?@"成功":@"失敗"];
        [AlertHelper initWithTitle:@"提示" message:msg];
    }
}
#pragma mark -(当应用程序处理活动状态会执行delegate,处理本地通知)
#pragma mark 本地通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    //UILocalNotification *localNotif=[userInfo objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    //[AlertHelper initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",localNotif.userInfo]];
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    notification.applicationIconBadgeNumber=0;
    //點選提示框的打開
    UIApplicationState state = application.applicationState;
    if (state == UIApplicationStateActive) {
        
        NSDictionary *dic=[notification userInfo];
        [self handlerNotificeWithUseInfo:dic];
    }
    //[self resetBageNumber];
}
- (void)resetBageNumber{
    int count =[[[UIApplication sharedApplication] scheduledLocalNotifications] count];
    if(count>0)
    {
        NSMutableArray *newarry= [NSMutableArray arrayWithCapacity:0];
        for (int i=0; i<count; i++) {
            UILocalNotification *notif=[[[UIApplication sharedApplication] scheduledLocalNotifications] objectAtIndex:i];
            notif.applicationIconBadgeNumber=i+1;
            [newarry addObject:notif];
        }
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        if (newarry.count>0) {
            for (int i=0; i<newarry.count; i++) {
                UILocalNotification *notif = [newarry objectAtIndex:i];
                [[UIApplication sharedApplication] scheduleLocalNotification:notif];
            }
        }
    }
}
- (void)handlerNotificeWithUseInfo:(NSDictionary*)dic{
    NSString *type=[dic objectForKey:@"type"];
    if ([type isEqualToString:@"1"]) {//藥物
        BasicPopoverView *basic=[[BasicPopoverView alloc] initWithFrame:CGRectMake((DeviceWidth-300)/2, 0, 300, 20)];
        basic.userInfo=dic;
        basic.delegate=self;
        [basic setMessage:[NSString stringWithFormat:@"親愛的%@,吃%@了嗎?",[dic objectForKey:@"UserName"],[dic objectForKey:@"Name"]]];
        [basic show];
    }
    if ([type isEqualToString:@"2"]) {//血壓
        
        BloodPopoverView *basic=[[BloodPopoverView alloc] initWithFrame:CGRectMake((DeviceWidth-300)/2, 0, 300, 20)];
        basic.userInfo=dic;
        basic.delegate=self;
        [basic setMessage:[NSString stringWithFormat:@"親愛的%@,請輸入您的血壓值:",[dic objectForKey:@"UserName"]]];
        [basic show];
    }
    if ([type isEqualToString:@"3"]) {//血糖
        BloodSugarPopoverView *basic=[[BloodSugarPopoverView alloc] initWithFrame:CGRectMake((DeviceWidth-300)/2, 0, 300, 20)];
        basic.userInfo=dic;
        basic.delegate=self;
        [basic setMessage:[NSString stringWithFormat:@"親愛的%@,請輸入您的血糖值:",[dic objectForKey:@"UserName"]]];
        [basic show];
    }
}
@end
