//
//  HEWelfareViewController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HEWelfareViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *refreshTable;
@property (nonatomic,strong) NSMutableArray *list;
@end
