//
//  ChartView.h
//  HsinchuElderly
//
//  Created by aJia on 2014/7/4.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartView : UIView
@property (nonatomic,assign) CGFloat radius;//圆的半径
@property (nonatomic,assign) CGFloat radiusWidth;//圆的宽度
@property (nonatomic,assign) CGFloat maxHeight;//最大高度
@property (nonatomic,assign) CGFloat rowHeight;//行高
@property (nonatomic,assign) CGFloat columnWidth;//列宽
@property (nonatomic,strong) UIFont *dateFont;//日期字体()
@property (nonatomic,strong) UIFont *valueFont;//血压或血糖值字体
@property (nonatomic,strong) UIColor *chartColor;//线条颜色
@property (nonatomic,strong) NSArray *Entitys;//数据源1
@property (nonatomic,strong) NSArray *EntityValue1;//数据源2
@property (nonatomic,assign) CGFloat rate;//比例值
//画图表
- (void)drawChartWithSource:(NSArray*)source;
- (void)drawChartWithSource:(NSArray*)source otherSource:(NSArray*)arr;
- (void)drawChartWithSource:(NSArray*)source chartHeight:(CGFloat)height lineColor:(UIColor*)color;
@end
