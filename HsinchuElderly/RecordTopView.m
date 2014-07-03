//
//  RecordTopView.m
//  HsinchuElderly
//
//  Created by aJia on 2014/6/13.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "RecordTopView.h"
#import "UIButton+TPCategory.h"
#import "UIImage+TPCategory.h"
@implementation RecordTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat leftX=20;
        CGFloat w=(frame.size.width-3*leftX)/2;
        
        
        self.backgroundColor=[UIColor colorFromHexRGB:@"fc9a0a"];
        UIImage *img1=[UIImage imageNamed:@"btn_bg.png"];
        img1=[img1 stretchableImageWithLeftCapWidth:15 topCapHeight:0];
        /***
        //用藥
        _drugButton=[UIButton barButtonWithTitle:@"用藥" target:self action:nil forControlEvents:UIControlEventTouchUpInside];
        _drugButton.tag=101;
        _drugButton.frame=CGRectMake(leftX,(frame.size.height-35)/2,w, 35);
        [_drugButton setBackgroundImage:img1 forState:UIControlStateNormal];
        //設置選中時候的圖片
        UIImage *result=[UIImage createImageWithColor:[UIColor colorFromHexRGB:@"fb3306"] imageSize:_drugButton.frame.size];
        UIImage *corImg=[UIImage createRoundedRectImage:result size:result.size radius:5.0];
        [_drugButton setBackgroundImage:corImg forState:UIControlStateSelected];
        [_drugButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        _drugButton.selected=YES;
        [_drugButton addTarget:self action:@selector(buttonSelectedClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_drugButton];
         ***/
        
        _prevTag=101;
        
        //設置選中時候的圖片
        UIImage *result=[UIImage createImageWithColor:[UIColor colorFromHexRGB:@"fb3306"] imageSize:CGSizeMake(w, 35)];
        UIImage *corImg=[UIImage createRoundedRectImage:result size:result.size radius:5.0];
        
        //血壓
        _bloodButton=[UIButton barButtonWithTitle:@"血壓" target:self action:nil forControlEvents:UIControlEventTouchUpInside];
        _bloodButton.tag=101;
        _bloodButton.frame=CGRectMake(leftX, (frame.size.height-35)/2,w, 35);
        [_bloodButton setBackgroundImage:img1 forState:UIControlStateNormal];
         [_bloodButton setBackgroundImage:corImg forState:UIControlStateSelected];
        [_bloodButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_bloodButton addTarget:self action:@selector(buttonSelectedClick:) forControlEvents:UIControlEventTouchUpInside];
        _bloodButton.selected=YES;
        [self addSubview:_bloodButton];
        
        //血糖
        leftX=_bloodButton.frame.origin.x*2+_bloodButton.frame.size.width;
        _bloodSugarButton=[UIButton barButtonWithTitle:@"血糖" target:self action:nil forControlEvents:UIControlEventTouchUpInside];
         _bloodSugarButton.tag=102;
        _bloodSugarButton.frame=CGRectMake(leftX, _bloodButton.frame.origin.y,w, 35);
        [_bloodSugarButton setBackgroundImage:img1 forState:UIControlStateNormal];
        [_bloodSugarButton setBackgroundImage:corImg forState:UIControlStateSelected];
        [_bloodSugarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_bloodSugarButton addTarget:self action:@selector(buttonSelectedClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_bloodSugarButton];
        self.selectedIndex=1;
    }
    return self;
}
- (void)buttonSelectedClick:(UIButton*)btn{
    btn.selected=YES;
    if (_prevTag!=btn.tag) {
        UIButton *btn1=(UIButton*)[self viewWithTag:_prevTag];
        btn1.selected=NO;
        
        NSInteger index = btn.tag-100;
        self.selectedIndex=index;
        if (self.delegate&&[self.delegate respondsToSelector:@selector(selectedButton:type:)]) {
            [self.delegate selectedButton:btn type:index];
        }
    }
    _prevTag=btn.tag;
   
    
}
@end
