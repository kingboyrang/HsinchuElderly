//
//  UINavigationBar+CustomNavigatorBar.m
//  Bullet
//
//  Created by aJia on 12/11/13.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "UINavigationBar+TPCategory.h"
#import "UIImage+TPCategory.h"
#import "UIColor+TPCategory.h"
@implementation UINavigationBar (TPCategory)
UIImageView *backgroundView;
 #pragma -
 #pragma 第一種方法增加背景圖
 -(UIImage*)barBackground
 {
     /***
     UIImage *image=[UIImage imageNamed:@"nav_bg.png"];
#ifdef __IPHONE_7_0
     if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
         image=[UIImage imageNamed:@"nav_bg_ios7.png"];
     }
#endif
       image=[image stretchableImageWithLeftCapWidth:4 topCapHeight:0];
      ***/
    

     UIImage *image=[UIImage createImageWithColor:[UIColor colorFromHexRGB:@"fc690a"] imageSize:CGSizeMake(self.frame.size.width, 44)];
     #ifdef __IPHONE_7_0
     if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
         image=[UIImage createImageWithColor:[UIColor colorFromHexRGB:@"fc680a"] imageSize:CGSizeMake(self.frame.size.width, 64)];
     }
     #endif
     return image;
 }
 
 -(void)didMoveToSuperview
 {
 //iOS5 only
 if([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
 {
   [self setBackgroundImage:[self barBackground] forBarMetrics:UIBarMetricsDefault];
 }
 }
 //this doesn't work on iOS5 but is needed for iOS4 and earlier
 -(void)drawRect:(CGRect)rect
 {
 //draw image
   [[self barBackground] drawInRect:rect];
 }

-(void)setBackgroundImage:(UIImage*)image
{
    if(image == nil)
    {
        [backgroundView removeFromSuperview];
    }
    else
    {
        CGFloat newW=(16*self.frame.size.height)/140.0;
        UIImage *newImage=[image imageByScalingToSize:CGSizeMake(newW, self.frame.size.height)];
        backgroundView = [[UIImageView alloc] initWithImage:newImage];
        
        backgroundView.tag = 1;
        backgroundView.frame = CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height);
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        CGFloat w=(368*self.frame.size.height)/140.0;
        CGFloat leftx=(self.frame.size.width-w)/2.0;
        
        UIImageView *logoView=[[UIImageView alloc] initWithFrame:CGRectMake(leftx, 0,w, self.frame.size.height)];
        UIImage *logoImage=[[UIImage imageNamed:@"bar_logo.png"] imageByScalingToSize:CGSizeMake(w, self.frame.size.height)];
        [logoView setImage:logoImage];
        
        [backgroundView addSubview:logoView];

        
        [self addSubview:backgroundView];
        [self sendSubviewToBack:backgroundView];
        //[backgroundView release];
    }
}
//for other views
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index
{
    [super insertSubview:view atIndex:index];  
    [self sendSubviewToBack:backgroundView];
}  
@end
