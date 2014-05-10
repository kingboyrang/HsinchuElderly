//
//  BloodModifyController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Blood.h"
#import "TKLabelSelectCell.h"
#import "TKLabelCalendarCell.h"
@interface BloodModifyController : BasicViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *userTable;
@property (nonatomic,strong) NSMutableArray *cells;
@property (nonatomic,strong) NSMutableArray *systemUsers;
@property (nonatomic,strong) Blood *Entity;
@property (nonatomic,assign) NSInteger operType;//1:表示新增 2:表示修改
@end
