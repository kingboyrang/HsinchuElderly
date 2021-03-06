//
//  UseDrugModifyController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedicineDrug.h"
#import "TKSelectFieldCell.h"
#import "TKCalendarFieldCell.h"
#import "TKRateViewCell.h"
@interface UseDrugModifyController : BasicViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CVUICalendarDelegate,CVUISelectDelegate,CVUIRateViewDelegate>
@property (nonatomic,strong) UITableView *userTable;
@property (nonatomic,strong) NSMutableArray *cells;
@property (nonatomic,strong) NSMutableArray *systemUsers;
@property (nonatomic,strong) MedicineDrug *Entity;
@property (nonatomic,assign) NSInteger operType;//1:表示新增 2:表示修改
@end
