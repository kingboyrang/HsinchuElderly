//
//  UIBarButtonItem+TPCategory.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/9.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "UIBarButtonItem+TPCategory.h"

@implementation UIBarButtonItem (TPCategory)
+ (id)barButtonWithTitle:(NSString*)title target:(id)sender action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
   // UIImage *img=[UIImage imageNamed:@"btn_bg.png"];
    CGSize size=[title textSize:defaultSDeviceFont withWidth:320];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, size.width,size.height);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:defaultDeviceFontColor forState:UIControlStateNormal];
    btn.titleLabel.font=defaultSDeviceFont;
    //btn.showsTouchWhenHighlighted=YES;
    //[btn setBackgroundImage:img forState:UIControlStateNormal];
    [btn addTarget:sender action:action forControlEvents:controlEvents];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
