//
//  UseDrugViewController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/9.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedicineDrugHelper.h"
#import "SystemUserHelper.h"
@interface UseDrugViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *userTable;
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,strong) MedicineDrugHelper *userHelper;
@property (nonatomic,strong) SystemUserHelper *systemUserHelper;
@end
