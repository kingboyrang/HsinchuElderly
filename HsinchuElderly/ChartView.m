//
//  ChartView.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/4.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "ChartView.h"
#import "ChartRecord.h"
@implementation ChartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        
        
        self.radius=3.0f;
        self.radiusWidth=1.0f;
        self.maxHeight=270.0f;
        self.rowHeight=10.0f;
        self.rate=1.0f;
        
        UIFont *font=[UIFont systemFontOfSize:DeviceIsPad?10*1.5:10];
        NSString *str=@"07/02 17:48";
        CGSize size=[str textSize:font withWidth:frame.size.width];
        self.columnWidth=size.width/2+size.width+5;
        
        self.dateFont=font;
        self.valueFont=[UIFont systemFontOfSize:DeviceIsPad?12*1.5:12];
        self.chartColor=[UIColor redColor];
    }
    return self;
}
- (void)drawChartWithSource:(NSArray*)source otherSource:(NSArray*)arr{
    if (source&&[source count]>0) {
        CGRect r=self.frame;
        r.size.width=[source count]*self.columnWidth;
        if (r.size.width>self.frame.size.width) {
            self.frame=r;
        }
    }
    self.Entitys=source;
    self.EntityValue1=arr;
    [self setNeedsDisplay];//重绘图像
}
//画血压图表
- (void)drawChartWithSource:(NSArray*)source{
    if (source&&[source count]>0) {
        CGRect r=self.frame;
        r.size.width=[source count]*self.columnWidth;
        if (r.size.width>self.frame.size.width) {
            self.frame=r;
        }
    }
    self.Entitys=source;
    [self setNeedsDisplay];//重绘图像
}
- (void)drawChartWithSource:(NSArray*)source chartHeight:(CGFloat)height lineColor:(UIColor*)color{
    CGRect r=self.frame;
    r.size.height=height+20;
    if (source&&[source count]>0) {
        if (self.frame.size.width<[source count]*self.columnWidth) {
             r.size.width=[source count]*self.columnWidth;
        }
    }
    self.frame=r;
    self.maxHeight=height;
    self.Entitys=source;
    if (color) {
        self.chartColor=color;
    }else{
        self.chartColor=[UIColor redColor];
    }
    [self setNeedsDisplay];//重绘图像
}
#pragma mark - 画图部份
//画表格
- (void)drawTableWithContext:(CGContextRef)ctx{
    NSInteger row=self.maxHeight/self.rowHeight,h=self.rowHeight;
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorFromHexRGB:@"b6b6b6"].CGColor);
    CGContextSetLineWidth(ctx,0.1);
    CGContextBeginPath(ctx);
    for (NSInteger a=0;a<row;a++) {
        //畫橫線
        CGContextMoveToPoint(ctx, 0,(a+1)*h);
        CGContextAddLineToPoint(ctx, self.bounds.size.width,(a+1)*h);
    }
    NSInteger total=self.bounds.size.width*1.0f/self.columnWidth+1;
    for (NSInteger b=0; b<total; b++) {
        //畫書線
        CGContextMoveToPoint(ctx, self.columnWidth*b,0);
        CGContextAddLineToPoint(ctx, self.columnWidth*b,row*h);
    }
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
}
- (void)drawJoinLine:(CGContextRef)ctx startPoint:(CGPoint)spoint endPoint:(CGPoint)epoint lineColor:(UIColor*)color{
    //保存结果
    CGPoint startP=CGPointMake(0, spoint.y);
    CGPoint endP=CGPointMake(0, epoint.y);
    
    if (spoint.y==epoint.y) {//属于同一直线
        startP.x=spoint.x+self.radius+self.radiusWidth;
        endP.x=epoint.x-self.radius-self.radiusWidth;
    }
    else if (spoint.y>epoint.y) {//结束点在开始点的上面
        CGFloat a=epoint.x-spoint.x;
        CGFloat b=spoint.y-epoint.y;
        CGFloat c=sqrt(pow(a, 2)+pow(b, 2));//斜边
        endP.y=sin(b/c)*(self.radius+self.radiusWidth)+epoint.y;
        endP.x=a-sqrt(pow(self.radius+self.radiusWidth, 2)-pow(endP.y-epoint.y, 2))+spoint.x;
        
        CGFloat b1=sin(b/c)*(self.radius+self.radiusWidth);
        startP.y=b-b1+epoint.y;
        startP.x=sqrt(pow(self.radius+self.radiusWidth, 2)-pow(b1, 2))+spoint.x;
        
    }else{//spoint.y<epoint.y
        CGFloat a=epoint.y-spoint.y;
        CGFloat b=epoint.x-spoint.x;
        CGFloat c=sqrt(pow(a, 2)+pow(b, 2));
        CGFloat b1=sin(b/c)*(self.radius+self.radiusWidth);
        endP.x=b-sin(b/c)*(self.radius+self.radiusWidth)+spoint.x;
        endP.y=a-sqrt(pow(self.radius+self.radiusWidth, 2)-pow(b1, 2))+spoint.y;
        
        startP.x=b1+spoint.x;
        startP.y=sqrt(pow(self.radius+self.radiusWidth, 2)-pow(b1, 2))+spoint.y;
    }
    [self drawLineWithContext:ctx start:startP end:endP lineColor:color];
}
//画日期文字
- (void)drawTextWithContext:(CGContextRef)ctx point:(CGPoint)point value:(NSString*)val{
    
    CGContextSetLineWidth(ctx, self.radiusWidth);//线的宽度
    CGSize size=[val textSize:self.dateFont withWidth:self.bounds.size.width];
    //画文字
    [val drawInRect:CGRectMake(point.x!=0?point.x-size.width/2:point.x,point.y, size.width,size.height) withFont:self.dateFont lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
}
//画线
- (void)drawLineWithContext:(CGContextRef)ctx start:(CGPoint)spoint end:(CGPoint)epoint lineColor:(UIColor*)color{
    CGContextSetStrokeColorWithColor(ctx, color.CGColor);
    CGContextSetLineWidth(ctx, self.radiusWidth);//线的宽度
    
    CGContextMoveToPoint(ctx, spoint.x,spoint.y);
    CGContextAddLineToPoint(ctx, epoint.x,epoint.y);
    CGContextStrokePath(ctx);//绘画路径
}
//画圆
- (void)drawRadioWithContext:(CGContextRef)ctx locationX:(CGFloat)x locationY:(CGFloat)y value:(NSString*)val lineColor:(UIColor*)radioColor{
    //画圆
    CGContextSetRGBStrokeColor(ctx,radioColor.red,radioColor.green,radioColor.blue,1.0);//画笔线的颜色
    CGContextSetLineWidth(ctx, self.radiusWidth);//线的宽度
    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    CGContextAddArc(ctx,x,y,self.radius, 0,2*M_PI, 0); //添加一个圆
    CGContextDrawPath(ctx, kCGPathStroke); //绘制路径
    
    //画文字
    CGSize size=[val textSize:self.valueFont withWidth:self.bounds.size.width];
    CGFloat leftX=x-size.width/2;
    leftX=leftX<0?x:leftX;
    [val drawInRect:CGRectMake(leftX, y-(self.radius+self.radiusWidth+5+size.height), size.width,size.height) withFont:self.valueFont lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
    
}
//根据数据源画内容
- (void)drawChartWithContext:(CGContextRef)ctx drawSource:(NSArray*)source lineColor:(UIColor*)color{
    //画圆与连接线
    if (source&&[source count]>0) {
        CGPoint prePoint=CGPointMake(0, 0);
        for (NSInteger i=0;i<source.count;i++) {
            ChartRecord *item=source[i];
            CGFloat leftX=i==0?self.radius+self.radiusWidth:self.columnWidth*i;
            CGFloat v=[item.chartValue floatValue]*self.rate;
            if (i==0) {
                prePoint.x=leftX;
                prePoint.y=self.maxHeight-v;
            }
            //画圆
            [self drawRadioWithContext:ctx locationX:leftX locationY:self.maxHeight-v value:item.chartValue lineColor:color];
            if (i>0) {//画连接线
                [self drawJoinLine:ctx startPoint:prePoint endPoint:CGPointMake(i*self.columnWidth, self.maxHeight-v) lineColor:color];
                //保存前一个连接点
                prePoint.x=leftX;
                prePoint.y=self.maxHeight-v;
            }
        }
    }
    
}
//乡亲们我要画图了,求鉴赏~~~
/**
 1.有几行数据画几列，先画表格
 2.再画日期文字
 3.画连接线
 **/
- (void)drawRect:(CGRect)rect{
    CGContextRef ctx =UIGraphicsGetCurrentContext();
    //画日期
    if (self.Entitys&&[self.Entitys count]>0) {
        for (NSInteger i=0;i<self.Entitys.count;i++) {
            ChartRecord *item=self.Entitys[i];
            [self drawTextWithContext:ctx point:CGPointMake(i*self.columnWidth,self.maxHeight+2) value:item.chartDate];
        }
    }
    //画表格
    [self drawTableWithContext:ctx];
    
    //画圆与连接线(数据源1)
    [self drawChartWithContext:ctx drawSource:self.Entitys lineColor:self.chartColor];
    //画圆与连接线(数据源2)
    [self drawChartWithContext:ctx drawSource:self.EntityValue1 lineColor:[UIColor colorFromHexRGB:@"1a64a6"]];
}
@end
