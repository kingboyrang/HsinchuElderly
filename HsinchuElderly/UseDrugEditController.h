//
//  UseDrugEditController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/7/11.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedicineDrug.h"
#import "TKSelectFieldCell.h"
#import "TKCalendarFieldCell.h"
@interface UseDrugEditController : BasicViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CVUICalendarDelegate,CVUISelectDelegate>
@property (nonatomic,strong) UITableView *userTable;
@property (nonatomic,strong) NSMutableArray *cells;
@property (nonatomic,strong) NSMutableArray *systemUsers;
@property (nonatomic,strong) MedicineDrug *Entity;

@end
