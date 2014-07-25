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
    
   
    UIImage *corImg=[UIImage imageNamed:@"btn_bg.png"];
    corImg=[corImg stretchableImageWithLeftCapWidth:corImg.size.width/2 topCapHeight:corImg.size.height/2];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, DeviceIsPad?65:55,30);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:defaultDeviceFontColor forState:UIControlStateNormal];
    btn.titleLabel.font=default18DeviceFont;//[UIFont fontWithName:defaultDeviceFontName size:18];
    //btn.titleLabel.shadowColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    //btn.titleLabel.shadowOffset=CGSizeMake(0, 0);
    [btn setBackgroundImage:corImg forState:UIControlStateNormal];
    //btn.showsTouchWhenHighlighted=YES;
    //[btn setBackgroundImage:img forState:UIControlStateNormal];
    [btn addTarget:sender action:action forControlEvents:controlEvents];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
