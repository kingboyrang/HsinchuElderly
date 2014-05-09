//
//  TKPhotoCell.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/8.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TKPhotoCell.h"
#import "UIButton+TPCategory.h"
#import "UIImage+TPCategory.h"

@interface TKPhotoCell ()
@property(strong,nonatomic) UIImageView *lineView;
@end

@implementation TKPhotoCell
@synthesize hasImage=_hasImg;
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    UIImage *img=[UIImage imageNamed:@"head"];
    _photoImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width,img.size.height)];
    [_photoImage setImage:[UIImage imageNamed:@"head"]];
    [self.contentView addSubview:_photoImage];
    
    UIImage *img1=[UIImage imageNamed:@"btn_bg.png"];
    UIEdgeInsets edginset=UIEdgeInsetsMake(10, 10, 10, 10);
    _albumBtn=[UIButton barButtonWithTitle:@"相冊" target:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [_albumBtn setBackgroundImage:[img1 resizableImageWithCapInsets:edginset] forState:UIControlStateNormal];
    [self.contentView addSubview:_albumBtn];
    
    _cameraBtn=[UIButton barButtonWithTitle:@"拍照" target:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [_cameraBtn setBackgroundImage:[img1 resizableImageWithCapInsets:edginset] forState:UIControlStateNormal];
	[self.contentView addSubview:_cameraBtn];
    
    _lineView=[[UIImageView alloc] initWithFrame:CGRectMake(0,200, self.bounds.size.width, 5)];
    [_lineView setImage:[UIImage createImageWithColor:[UIColor colorFromHexRGB:@"fc680f"]]];
    [self.contentView addSubview:_lineView];
    
    self.hasImage=NO;
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}
- (void)setPhotoWithImage:(UIImage*)img{
    [_photoImage setImage:img];
    self.hasImage=YES;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r=_photoImage.frame;
    r.origin.y=20;
    r.origin.x=(self.frame.size.width-r.size.width)/2;
    _photoImage.frame=r;
    
    r=_albumBtn.frame;
    r.size=CGSizeMake(100, 40);
    r.origin.y=_photoImage.frame.origin.y*2+_photoImage.frame.size.height;
    r.origin.x=(self.frame.size.width-100*2-30)/2;
    _albumBtn.frame=r;
    
    r.origin.x+=r.size.width+30;
    _cameraBtn.frame=r;
    
    r=_lineView.frame;
    r.origin.y=_cameraBtn.frame.origin.y+_cameraBtn.frame.size.height+20;
    r.size.width=self.frame.size.width;
    _lineView.frame=r;
}
@end
