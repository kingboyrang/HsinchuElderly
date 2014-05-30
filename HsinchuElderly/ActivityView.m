//
//  ActivityView.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/14.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "ActivityView.h"
#import <QuartzCore/QuartzCore.h>

@interface ActivityView ()
- (void)addLableWithFrame:(CGRect)frame title:(NSString*)title;
- (void)addContentWithFrame:(CGRect)frame title:(NSString*)title;
@end

@implementation ActivityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorFromHexRGB:@"ffe3b1"];
        self.layer.borderWidth=1.0;
        self.layer.borderColor=[UIColor colorFromHexRGB:@"ffe3b1"].CGColor;
        self.layer.cornerRadius=8.0;
        self.layer.masksToBounds=YES;
        
        NSString *title=@"活動時間：";
        CGSize size=[title textSize:default18DeviceFont withWidth:frame.size.width];
        [self addLableWithFrame:CGRectMake(10,10, size.width, size.height) title:@"活動時間"];
        
        CGFloat topY=10+size.height+4;
        title=@"2014/06/05~2014/07/05";
        size=[title textSize:default18DeviceFont withWidth:frame.size.width];
        [self addContentWithFrame:CGRectMake(10, topY, size.width, size.height) title:title];
        
        topY+=size.height+4;
        title=@"活動內容";
        size=[title textSize:default18DeviceFont withWidth:frame.size.width];
        [self addLableWithFrame:CGRectMake(10, topY, size.width, size.height) title:title];
        
        topY+=size.height+4;
        title=@"參加「家有一老 如有一寶」活動，並下載APP及上傳爺爺奶奶照片，就有機會獲得大獎！邀請各位踴躍參加。";
        size=[title textSize:defaultSDeviceFont withWidth:frame.size.width-15];
        [self addContentWithFrame:CGRectMake(10, topY, size.width, size.height) title:title];
        
        topY+=size.height+4;
        title=@"活動辦法";
        size=[title textSize:default18DeviceFont withWidth:frame.size.width];
        [self addLableWithFrame:CGRectMake(10, topY, size.width, size.height) title:title];
        
        topY+=size.height+4;
        title=@"上傳爺爺奶奶照片，就有機會參加抽獎獲得大獎。";
        size=[title textSize:default18DeviceFont withWidth:frame.size.width-15];
        [self addContentWithFrame:CGRectMake(10, topY, size.width, size.height) title:title];
        
        topY+=size.height+10;
        CGRect r=self.frame;
        r.size.height=topY;
        self.frame=r;
        
    }
    return self;
}
- (void)addContentWithFrame:(CGRect)frame title:(NSString*)title{
    UILabel *labTime=[[UILabel alloc] initWithFrame:frame];
    labTime.backgroundColor=[UIColor clearColor];
    labTime.textColor=[UIColor blackColor];
    labTime.font=default18DeviceFont;
    labTime.text=title;
    labTime.numberOfLines=0;
    labTime.lineBreakMode=NSLineBreakByWordWrapping;
    [self addSubview:labTime];
}
- (void)addLableWithFrame:(CGRect)frame title:(NSString*)title{
    UILabel *labTime=[[UILabel alloc] initWithFrame:frame];
    labTime.backgroundColor=[UIColor clearColor];
    labTime.textColor=defaultDeviceFontColor;
    labTime.font=default18DeviceFont;
    labTime.text=title;
    [self addSubview:labTime];
}
@end
