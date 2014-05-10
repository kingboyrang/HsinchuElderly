//
//  BloodViewController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BloodHelper.h"
#import "SystemUserHelper.h"
@interface BloodViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *userTable;
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,strong) BloodHelper *userHelper;
@property (nonatomic,strong) SystemUserHelper *systemUserHelper;

@end
