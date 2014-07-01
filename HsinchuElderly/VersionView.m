//
//  VersionView.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/22.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "VersionView.h"
#import "UIImage+TPCategory.h"
@implementation VersionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage *image=[UIImage imageNamed:@"login_title.png"];
        CGFloat w=image.size.width;
        CGRect r=self.bounds;
        r.size=image.size;
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:r];
        [imageView setImage:image];
        [self addSubview:imageView];
        
        NSString *title=@"Version:1.0.0";
        CGSize size=[title textSize:[UIFont fontWithName:defaultDeviceFontName size:20] withWidth:frame.size.width];
        UILabel *labTime=[[UILabel alloc] initWithFrame:CGRectMake(0, image.size.height+20,frame.size.width, size.height)];
        labTime.backgroundColor=[UIColor clearColor];
        labTime.textColor=[UIColor blackColor];
        labTime.font=[UIFont fontWithName:defaultDeviceFontName size:20];
        labTime.text=title;
        labTime.textAlignment=NSTextAlignmentCenter;
        [self addSubview:labTime];
        
        w=w>size.width?w:size.width;
        
        CGFloat topY=labTime.frame.origin.y+labTime.frame.size.height+10;
        
        title=@"主辦單位：新竹縣政府";
        size=[title textSize:[UIFont fontWithName:defaultDeviceFontName size:20] withWidth:frame.size.width];
        UILabel *lab1=[[UILabel alloc] initWithFrame:CGRectMake(0, topY,frame.size.width, size.height)];
        lab1.backgroundColor=[UIColor clearColor];
        lab1.textColor=[UIColor colorFromHexRGB:@"5f0000"];
        lab1.font=[UIFont fontWithName:defaultDeviceFontName size:20];
        lab1.text=title;
        lab1.textAlignment=NSTextAlignmentCenter;
        [self addSubview:lab1];
        
        w=w>size.width?w:size.width;
        
        topY=lab1.frame.origin.y+lab1.frame.size.height+10;
        title=@"hchgL301@hchg.gov.tw";
        size=[title textSize:[UIFont fontWithName:defaultDeviceFontName size:20] withWidth:frame.size.width];
        UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(0, topY,frame.size.width, size.height)];
        lab2.backgroundColor=[UIColor clearColor];
        lab2.textColor=[UIColor colorFromHexRGB:@"0498c7"];
        lab2.font=[UIFont fontWithName:defaultDeviceFontName size:20];
        lab2.text=title;
        lab2.textAlignment=NSTextAlignmentCenter;
        [self addSubview:lab2];
        
        
        w=w>size.width?w:size.width;
        
        r=self.frame;
        r.size.height=topY+size.height;
        r.size.width=w;
        self.frame=r;
        
        r=imageView.frame;
        r.origin.x=(self.frame.size.width-r.size.width)/2;
        imageView.frame=r;
        
        for (UIView *item in self.subviews) {
            if ([item isKindOfClass:[UILabel class]]) {
                r=item.frame;
                r.size.width=self.frame.size.width;
                item.frame=r;
            }
        }
        UILabel *labline=[[UILabel alloc] initWithFrame:CGRectMake(0,self.frame.size.height-2,w, 2)];
        labline.backgroundColor=[UIColor colorFromHexRGB:@"0498c7"];
        [self addSubview:labline];
        
        _emailBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _emailBtn.frame=CGRectMake(0, self.frame.size.height-(size.height+2), self.frame.size.width,size.height+2);
        [self addSubview:_emailBtn];
        
     
        
    }
    return self;
}
@end
