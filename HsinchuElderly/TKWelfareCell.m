//
//  TKWelfareCell.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/30.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TKWelfareCell.h"

@interface TKWelfareCell ()
@property (nonatomic,strong) UIButton *arrowButton;
@end

@implementation TKWelfareCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    UIImage *img=[UIImage imageNamed:@"cell_bg.png"];
    img=[img stretchableImageWithLeftCapWidth:img.size.width*0.5f topCapHeight:img.size.height*0.5f];
    //[img resizableImageWithCapInsets:UIEdgeInsetsMake(img.size.height*0.5f, img.size.width*0.5f, 0, 15) resizingMode:UIImageResizingModeStretch];
    CGRect r=self.frame;
    r.size.width=DeviceWidth;
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:r];
    [imageView setImage:img];
    self.backgroundView=imageView;
    
    
    UIImage *rightImg=[UIImage imageNamed:@"arrow_right.png"];
    _arrowButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _arrowButton.frame=CGRectMake(0, 0, rightImg.size.width, rightImg.size.height);
    [_arrowButton setBackgroundImage:rightImg forState:UIControlStateNormal];
    [self.contentView addSubview:_arrowButton];
    
    
    _labName = [[UILabel alloc] initWithFrame:CGRectZero];
	_labName.backgroundColor = [UIColor clearColor];
    _labName.textColor = defaultDeviceFontColor;
    _labName.font = [UIFont fontWithName:defaultDeviceFontName size:18];
    _labName.numberOfLines = 0;
    _labName.lineBreakMode=NSLineBreakByWordWrapping;
	
	[self.contentView addSubview:_labName];
    
  
    
    
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat leftX=10;
    CGFloat w=self.frame.size.width-leftX-_arrowButton.frame.size.width-5-2;
    CGSize size=[_labName.text textSize:_labName.font withWidth:w];
    _labName.frame=CGRectMake(leftX,(self.frame.size.height-size.height)/2, size.width, size.height);
    
   
    
    CGRect r=_arrowButton.frame;
    r.origin.y=(self.frame.size.height-r.size.height)/2;
    r.origin.x=self.frame.size.width-r.size.width-5;
    _arrowButton.frame=r;
    
}

@end
