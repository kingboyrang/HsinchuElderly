//
//  HESegmentControl.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/9.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "HESegmentControl.h"
#import <QuartzCore/QuartzCore.h>
@interface HESegmentControl ()
- (void)buttonRelayouts;
@end

@implementation HESegmentControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectedIndex=0;
        self.backgroundColor=[UIColor whiteColor];
        self.layer.cornerRadius=5.0;
        self.layer.masksToBounds=YES;
    }
    return self;
}
- (void)insertSegmentWithTitle:(NSString*)title withIndex:(NSInteger)index{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(index*self.bounds.size.width/2, 0, self.bounds.size.width/2, self.bounds.size.height);
    btn.tag=100+index;
    if (index==self.selectedIndex) {
        btn.selected=YES;
    }
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor colorFromHexRGB:@"fc680a"] forState:UIControlStateNormal];
    btn.titleLabel.font=defaultSDeviceFont;
    NSString *selectedImgName=index==0?@"seg_left_selected.png":@"seg_right_selected.png";
    UIImage *selectedImg=[UIImage imageNamed:selectedImgName];
    UIEdgeInsets edginset=UIEdgeInsetsMake(5, 10, 5, 10);
    [btn setBackgroundImage:[selectedImg resizableImageWithCapInsets:edginset] forState:UIControlStateSelected];
    
    NSString *normalImgName=index==0?@"seg_left.png":@"seg_right.png";
    UIImage *normalImg=[UIImage imageNamed:normalImgName];
    [btn setBackgroundImage:[normalImg resizableImageWithCapInsets:edginset] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(buttonSelectedClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}
- (void)setTitle:(NSString*)title withIndex:(NSInteger)index{
    if ([self viewWithTag:100+index]) {
        UIButton *btn=(UIButton*)[self viewWithTag:100+index];
        [btn setTitle:title forState:UIControlStateNormal];
    }
}
- (void)buttonSelectedClick:(UIButton*)btn{
    if (self.selectedIndex+100!=btn.tag) {
        UIButton *btn1=(UIButton*)[self viewWithTag:self.selectedIndex+100];
        btn1.selected=NO;
    }
    self.selectedIndex=btn.tag-100;
    [UIView animateWithDuration:0.5f animations:^{
        btn.selected=YES;
    }];
}
- (void)setSelectedSegmentIndex:(NSInteger)index{
    if ([self viewWithTag:100+index]) {
        UIButton *btn=(UIButton*)[self viewWithTag:100+index];
        [self buttonSelectedClick:btn];
    }
}
- (void)buttonRelayouts{
    if ([self.subviews count]>0) {
        CGRect r=CGRectZero;
        for (UIView *item in self.subviews) {
            r=item.frame;
            r.size.width=self.frame.size.width/2;
            r.size.height=self.frame.size.height;
            r.origin.y=0;
            r.origin.x=(item.tag-100)*r.size.width;
            item.frame=r;
        }
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self buttonRelayouts];
}
@end
