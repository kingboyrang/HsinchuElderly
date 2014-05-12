//
//  MedicalCareDetailController.h
//  HsinchuElderly
//
//  Created by rang on 14-5-11.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicModel.h"
@interface HEItemDetailController : BasicViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *detailTable;
@property (nonatomic,strong) BasicModel *Entity;
@property (nonatomic,strong) NSMutableArray *cells;
@property (nonatomic,strong) UIWebView *webView;
@end
