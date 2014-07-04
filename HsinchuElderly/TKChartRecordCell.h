//
//  TKChartRecordCell.h
//  HsinchuElderly
//
//  Created by aJia on 2014/7/4.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolygonalScrollView.h"
#import "ChartView.h"
@interface TKChartRecordCell : UITableViewCell
@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UIScrollView *charScrollView;
@property (nonatomic,strong) ChartView *chart;
@end
