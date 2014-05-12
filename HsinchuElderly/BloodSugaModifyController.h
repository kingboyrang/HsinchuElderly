//
//  BloodSugaModifyController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BloodSugar.h"
@interface BloodSugaModifyController : BasicViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *userTable;
@property (nonatomic,strong) NSMutableArray *cells;
@property (nonatomic,strong) NSMutableArray *systemUsers;
@property (nonatomic,strong) BloodSugar *Entity;
@property (nonatomic,assign) NSInteger operType;//1:表示新增 2:表示修改

@end
