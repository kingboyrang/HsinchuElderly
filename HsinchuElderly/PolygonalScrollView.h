//
//  PolygonalScrollView.h
//  HsinchuElderly
//
//  Created by aJia on 2014/7/2.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PolygonalScrollView : UIScrollView
@property (nonatomic,assign) CGFloat radius;//圆的半径
@property (nonatomic,assign) CGFloat radiusWidth;//圆的宽度
@property (nonatomic,assign) CGFloat maxHeight;//最大高度
@property (nonatomic,assign) CGFloat rowHeight;//行高
@property (nonatomic,assign) CGFloat columnWidth;//列宽
@end
