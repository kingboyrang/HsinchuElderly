//
//  TopBarView.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/9.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TopBarView.h"
#import "UIButton+TPCategory.h"
@implementation TopBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorFromHexRGB:@"fc9a0a"];
        UIImage *img1=[UIImage imageNamed:@"btn_bg.png"];
        img1=[img1 stretchableImageWithLeftCapWidth:15 topCapHeight:0];
        _categoryButton=[UIButton barButtonWithTitle:@"所有類別" target:self action:nil forControlEvents:UIControlEventTouchUpInside];
        [_categoryButton setBackgroundImage:img1 forState:UIControlStateNormal];
        [self addSubview:_categoryButton];
        
        _areaButton=[UIButton barButtonWithTitle:@"所有區域" target:self action:nil forControlEvents:UIControlEventTouchUpInside];
        [_areaButton setBackgroundImage:img1 forState:UIControlStateNormal];
        [self addSubview:_areaButton];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat leftx=10,topY=5;
    CGFloat w=(self.frame.size.width-leftx*2-20)/2;
    _categoryButton.frame=CGRectMake(leftx, topY, w, self.frame.size.height-topY*2);
    
    CGRect r=_categoryButton.frame;
    r.origin.x+=r.size.width+20;
    _areaButton.frame=r;
}
@end
