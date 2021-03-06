//
//  BloodEditController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/7/11.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Blood.h"
#import "TKSelectFieldCell.h"
@interface BloodEditController :  BasicViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *userTable;
@property (nonatomic,strong) NSMutableArray *cells;
@property (nonatomic,strong) NSMutableArray *systemUsers;
@property (nonatomic,strong) Blood *Entity;

@end
