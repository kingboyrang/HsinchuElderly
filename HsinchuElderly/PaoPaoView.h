//
//  PaoPaoView.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/13.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocation.h>
@class BasicModel;
@interface PaoPaoView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *userTable;
@property (nonatomic,strong) NSMutableArray *cells;
@property (nonatomic,strong) BasicModel *Entity;
- (void)setViewDataSource:(BasicModel*)entity;
@end
