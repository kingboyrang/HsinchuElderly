//
//  BloodSugarViewController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BloodSugarHelper.h"
#import "SystemUserHelper.h"
@interface BloodSugarViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *userTable;
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,strong) BloodSugarHelper *userHelper;
@property (nonatomic,strong) SystemUserHelper *systemUserHelper;

@end
