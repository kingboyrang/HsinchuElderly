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
@implementation AppDelegate

- (void)dbInitLoad{
    //控件颜色设置
    [AppHelper setNavigationBarTitleAttrsFontWhite:YES];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 0);
    NSDictionary *dicAttrs1=[NSDictionary dictionaryWithObjectsAndKeys:
                            [UIColor whiteColor], NSForegroundColorAttributeName,
                            shadow, NSShadowAttributeName,
                            defaultBDeviceFont, NSFontAttributeName, nil];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UIToolbar class], nil] setTitleTextAttributes:dicAttrs1 forState:UIControlStateNormal];//ff5500
    
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
    }
    
    application.applicationIconBadgeNumber =0;
    [self dbInitLoad];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    IndexViewController *index=[[IndexViewController alloc] init];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:index];
    self.window.rootViewController=nav;
    [self.window makeKeyAndVisible];
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
    application.applicationIconBadgeNumber =0;
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark -
#pragma mark 本地通知
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    //點選提示框的打開
    application.applicationIconBadgeNumber = notification.applicationIconBadgeNumber-1;
    UIApplicationState state = application.applicationState;
    //    NSLog(@"%@,%d",notification,state);
    if (state == UIApplicationStateActive) {
        //[AlertHelper initWithTitle:@"提醒" message:notification.alertBody];
        /***
        [AlterMessage initWithTip:[NSString stringWithFormat:@"%@,是否直接開啟?",notification.alertBody] confirmMessage:@"是" cancelMessage:@"否" confirmAction:^(){
            //處理確認
            UITabBarController *rootController=(UITabBarController*)self.window.rootViewController;
            NSArray *arr=rootController.viewControllers;
            UINavigationController *nav=(UINavigationController*)[arr objectAtIndex:rootController.selectedIndex];
            
            NSString *filePath=[[notification userInfo] objectForKey:@"path"];
            NSString *name=[[filePath lastPathComponent] stringByDeletingPathExtension];
            QLPreviewController *previewoCntroller = [[[QLPreviewController alloc] init] autorelease];
            
            
            
            PreviewDataSource *dataSource = [[[PreviewDataSource alloc]init] autorelease];
            dataSource.path=[[NSString alloc] initWithString:filePath];
            previewoCntroller.dataSource=dataSource;
            [nav pushViewController: previewoCntroller animated:YES];
            [previewoCntroller setTitle:name];
            previewoCntroller.navigationItem.rightBarButtonItem=nil;
        }];
         ***/
    }
    
}
@end
