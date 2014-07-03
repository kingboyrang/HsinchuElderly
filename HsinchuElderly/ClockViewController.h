//
//  ClockViewController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/8.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPMenuHelper.h"
@class SystemUserHelper;
@interface ClockViewController : BasicViewController<TPMenuHelperDelegate>
@property (nonatomic,strong) SystemUserHelper *userHelper;
@property (nonatomic,strong) TPMenuHelper *menuHelper;
@property (nonatomic,strong) NSDictionary *notificeUserInfo;
@end
