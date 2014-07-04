//
//  ChartRecord.h
//  HsinchuElderly
//
//  Created by aJia on 2014/7/4.
//  Copyright (c) 2014年 lz. All rights reserved.
//
//图表记录中间资料转换器
#import <Foundation/Foundation.h>

@interface ChartRecord : NSObject
@property (nonatomic,copy) NSString *chartDate;//图表x軸顯示的日期
@property (nonatomic,copy) NSString *chartValue;//圖表y軸顯示的值
@end
