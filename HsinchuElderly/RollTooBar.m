//
//  RollTooBar.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/24.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "RollTooBar.h"

@implementation RollTooBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        
        UIImage *img=[UIImage imageNamed:@"RollArrowUp"];
        _btnUp=[UIButton buttonWithType:UIButtonTypeCustom];
        _btnUp.frame=CGRectMake(0, 0, img.size.width, img.size.height);
        //[_btnUp setImage:img forState:UIControlStateNormal];
        //[_btnUp setImage:[UIImage imageNamed:@"RollArrowUp_hl"] forState:UIControlStateHighlighted];
        [_btnUp setImage:[UIImage imageNamed:@"RollArrowUp_hl"] forState:UIControlStateNormal];
        [_btnUp setBackgroundColor:[UIColor colorFromHexRGB:@"fc741c"]];
        [self addSubview:_btnUp];
        
        
        CGRect r=_btnUp.frame;
        r.origin.y=img.size.height+10;
        _btnDown=[UIButton buttonWithType:UIButtonTypeCustom];
        _btnDown.frame=r;
        //[_btnDown setImage:[UIImage imageNamed:@"RollArrowDown"] forState:UIControlStateNormal];
        //[_btnDown setImage:[UIImage imageNamed:@"RollArrowDown_hl"] forState:UIControlStateHighlighted];
        [_btnDown setImage:[UIImage imageNamed:@"RollArrowDown_hl"] forState:UIControlStateNormal];
        [_btnDown setBackgroundColor:[UIColor colorFromHexRGB:@"fc741c"]];
        [self addSubview:_btnDown];
        
        r=self.frame;
        r.size.width=img.size.width;
        r.size.height=img.size.height*2+10;
        self.frame=r;
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
