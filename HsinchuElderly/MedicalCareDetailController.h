//
//  MedicalCareDetailController.h
//  HsinchuElderly
//
//  Created by rang on 14-5-11.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedicalCare.h"
@interface MedicalCareDetailController : BasicViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *detailTable;
@property (nonatomic,strong) MedicalCare *Entity;
@property (nonatomic,strong) NSMutableArray *cells;
@end
