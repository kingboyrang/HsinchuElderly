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
@implementation AppDelegate

- (void)dbInitLoad{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"HsinchuElderly" ofType:@"sqlite"];
    NSString *dbPath=[DocumentPath stringByAppendingPathComponent:@"HsinchuElderly.sqlite"];
    if (![FileHelper existsFilePath:dbPath]) {
         NSData *mainBundleFile = [NSData dataWithContentsOfFile:path];
        [[NSFileManager defaultManager] createFileAtPath:dbPath
                                                contents:mainBundleFile
                                              attributes:nil];
    }
    [FileHelper createDocumentDirectoryWithName:@"SystemUserImage"];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end