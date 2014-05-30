//
//  ToolSearchShow.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/30.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "ToolSearchShow.h"

@implementation ToolSearchShow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorFromHexRGB:@"fff899"];
        
        CGRect r=self.bounds;
        r.origin.x=20;
        r.size.width-=r.origin.x;
        _labShow=[[UILabel alloc] initWithFrame:r];
        _labShow.textColor=defaultDeviceFontColor;
        _labShow.font=defaultBDeviceFont;
        _labShow.backgroundColor=[UIColor clearColor];
        _labShow.text=@"所有類別";
        _labShow.numberOfLines=0;
        _labShow.lineBreakMode=NSLineBreakByWordWrapping;
        [self addSubview:_labShow];
        
        r=self.bounds;
        r.size.height=2;
        r.origin.y=frame.size.height-r.size.height;
        _labLine=[[UILabel alloc] initWithFrame:r];
        _labLine.backgroundColor=[UIColor colorFromHexRGB:@"fc690a"];
        [self addSubview:_labLine];
    }
    return self;
}
- (void)setLabText:(NSString*)text{
    CGFloat w=self.bounds.size.width-20;
    CGSize size=[text textSize:_labShow.font withWidth:w];
    _labShow.text=text;
    
    if (size.height+4>self.bounds.size.height) {
        CGRect r=self.frame;
        r.size.height=size.height+4;
        self.frame=r;
    }
    _labShow.frame=CGRectMake(10,(self.frame.size.height-size.height)/2,w, size.height);
    CGRect r1=_labLine.frame;
    r1.origin.y=self.frame.size.height-r1.size.height;
    _labLine.frame=r1;
}

@end
