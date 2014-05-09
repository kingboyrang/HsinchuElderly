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
        self.backgroundColor=[UIColor colorFromHexRGB:@"fd980a"];
        
        _categoryButton=[UIButton barButtonWithTitle:@"所有類別" target:self action:nil forControlEvents:UIControlEventTouchUpInside];
        CGFloat h=frame.size.height-10,w=(frame.size.width-20*3)/2;
        _categoryButton.frame=CGRectMake(20, 5, w, h);
        [self addSubview:_categoryButton];
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
