//
//  AppDelegate.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/7.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicPopoverView.h"
#import "BloodPopoverView.h"
#import "BloodSugarPopoverView.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,PopoverViewDelegate>

@property (strong, nonatomic) UIWindow *window;
- (void)dbInitLoad;
- (void)resetBageNumber;
- (void)handlerNotificeWithUseInfo:(NSDictionary*)userInfo;
@end
