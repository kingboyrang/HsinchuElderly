//
//  PolygonalScrollView.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/2.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "PolygonalScrollView.h"
#import "ChartRecord.h"
@implementation PolygonalScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化
        self.pagingEnabled=YES;
        self.showsVerticalScrollIndicator=YES;
        self.showsHorizontalScrollIndicator=YES;
        self.backgroundColor=[UIColor clearColor];
        self.radius=3.0f;
        self.radiusWidth=1.0f;
        self.maxHeight=270.0f;
        self.rowHeight=10.0f;
        
        UIFont *font=[UIFont systemFontOfSize:12.0f];
        NSString *str=@"07/02 17:48";
        CGSize size=[str textSize:font withWidth:frame.size.width];
        self.columnWidth=size.width/2+size.width+5;
        
        self.dateFont=font;
        self.valueFont=[UIFont systemFontOfSize:10.0f];
    }
    return self;
}
//画血压图表
- (void)drawBloodWithSource:(NSArray*)source dateFieldName:(NSString*)dName valueFieldName:(NSString*)vName{
    NSMutableArray *results=[NSMutableArray array];
    if (source&&[source count]>0) {
        
    }
    self.Entitys=results;
}
#pragma mark - 画图部份
- (void)drawJoinLine:(CGContextRef)ctx startPoint:(CGPoint)spoint endPoint:(CGPoint)epoint{
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
    [self drawLineWithContext:ctx start:startP end:endP];
}
//画日期文字
- (void)drawTextWithContext:(CGContextRef)ctx point:(CGPoint)point value:(NSString*)val{
    CGSize size=[val textSize:self.dateFont withWidth:self.bounds.size.width];
    //画文字
    [val drawInRect:CGRectMake(point.x,point.y, size.width,size.height) withFont:self.dateFont lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
}
//画线
- (void)drawLineWithContext:(CGContextRef)ctx start:(CGPoint)spoint end:(CGPoint)epoint{
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextSetLineWidth(ctx, self.radiusWidth);//线的宽度

    CGContextMoveToPoint(ctx, spoint.x,spoint.y);
    CGContextAddLineToPoint(ctx, epoint.x,epoint.y);
    CGContextStrokePath(ctx);//绘画路径
}
//画圆
- (void)drawRadioWithContext:(CGContextRef)ctx locationX:(CGFloat)x locationY:(CGFloat)y value:(NSString*)val{
    UIColor *radioColor=[UIColor redColor];
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
    [val drawInRect:CGRectMake(leftX, y-(self.radius+self.radiusWidth+5), size.width,size.height) withFont:self.valueFont lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
    
}
//乡亲们我要画图了,求鉴赏~~~
/**
  1.有几行数据画几列，先画表格
  2.再画日期文字
  3.画连接线
 **/
- (void)drawRect:(CGRect)rect{
    CGContextRef ctx =UIGraphicsGetCurrentContext();
    UIFont *font=[UIFont systemFontOfSize:3.5f];
    NSString *str=@"07/02 17:48";
    CGSize size=[str textSize:font withWidth:rect.size.width];
    //画文字
    [str drawInRect:CGRectMake(0, self.maxHeight+2, size.width,size.height) withFont:font lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
    
    NSInteger row=self.maxHeight/self.rowHeight,h=self.rowHeight;
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorFromHexRGB:@"b6b6b6"].CGColor);
    CGContextSetLineWidth(ctx,0.1);
    CGContextBeginPath(ctx);
    for (NSInteger a=0;a<row;a++) {
        //畫橫線
        CGContextMoveToPoint(ctx, 0,(a+1)*h);
        CGContextAddLineToPoint(ctx, rect.size.width,(a+1)*h);
    }
    for (NSInteger b=0; b<7; b++) {
        //畫書線
        CGContextMoveToPoint(ctx, self.columnWidth*b,0);
        CGContextAddLineToPoint(ctx, self.columnWidth*b,row*h);
    }
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
    
    //画圆
    [self drawRadioWithContext:ctx locationX:1.4 locationY:self.maxHeight-54 value:@"54"];
    [self drawRadioWithContext:ctx locationX:self.columnWidth locationY:self.maxHeight-54 value:@"54"];
    [self drawJoinLine:ctx startPoint:CGPointMake(1.4, self.maxHeight-54) endPoint:CGPointMake(self.columnWidth, self.maxHeight-54)];
    
    self.contentSize=CGSizeMake(7*self.columnWidth, rect.size.height);

}
@end
