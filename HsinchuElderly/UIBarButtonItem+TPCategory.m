//
//  UIBarButtonItem+TPCategory.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/9.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "UIBarButtonItem+TPCategory.h"
#import "UIImage+TPCategory.h"
@implementation UIBarButtonItem (TPCategory)
+ (id)barButtonWithTitle:(NSString*)title target:(id)sender action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    
   
    //UIImage *corImg=[UIImage imageNamed:@"btn_bg_cor.png"];
    //corImg=[corImg stretchableImageWithLeftCapWidth:15 topCapHeight:0];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 55,35);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont fontWithName:defaultDeviceFontName size:20];
    //btn.titleLabel.shadowColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    //btn.titleLabel.shadowOffset=CGSizeMake(0, 0);
    //[btn setBackgroundImage:corImg forState:UIControlStateNormal];
    //btn.showsTouchWhenHighlighted=YES;
    //[btn setBackgroundImage:img forState:UIControlStateNormal];
    [btn addTarget:sender action:action forControlEvents:controlEvents];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
