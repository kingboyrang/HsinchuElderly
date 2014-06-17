//
//  TKRecordDetailCell.m
//  HsinchuElderly
//
//  Created by aJia on 2014/6/17.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TKRecordDetailCell.h"

@implementation TKRecordDetailCell

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
    
    _labTime=[[UILabel alloc] initWithFrame:CGRectZero];
    _labTime.backgroundColor=[UIColor clearColor];
    _labTime.textColor = defaultDeviceFontColor;
    _labTime.font = [UIFont fontWithName:defaultDeviceFontName size:18];
    [self.contentView addSubview:_labTime];
    
    _labName=[[UILabel alloc] initWithFrame:CGRectZero];
    _labName.backgroundColor=[UIColor clearColor];
    _labName.textColor = defaultDeviceFontColor;
    _labName.font = [UIFont fontWithName:defaultDeviceFontName size:18];
    [self.contentView addSubview:_labName];
    
    _labValue1=[[UILabel alloc] initWithFrame:CGRectZero];
    _labValue1.backgroundColor=[UIColor clearColor];
    _labValue1.textColor = defaultDeviceFontColor;
    _labValue1.font = [UIFont fontWithName:defaultDeviceFontName size:18];
    _labValue1.numberOfLines=0;
    _labValue1.lineBreakMode=NSLineBreakByWordWrapping;
    [self.contentView addSubview:_labValue1];
    
    _labValue2=[[UILabel alloc] initWithFrame:CGRectZero];
    _labValue2.backgroundColor=[UIColor clearColor];
    _labValue2.textColor = defaultDeviceFontColor;
    _labValue2.font = [UIFont fontWithName:defaultDeviceFontName size:18];
    _labValue2.numberOfLines=0;
    _labValue2.lineBreakMode=NSLineBreakByWordWrapping;
    [self.contentView addSubview:_labValue2];
    
    self.cellHeight=70.0f;
    return self;
}
- (void)setTime:(NSString*)time name:(NSString*)user detail:(NSString*)message{
    _labTime.text=time;
    _labName.text=user;
    _labValue1.text=message;
    _labValue1.textAlignment=NSTextAlignmentRight;
   _labValue2.frame=CGRectZero;
    self.showValue1=YES;
    
    [self relayoutValue1];
}
- (void)relayoutValue1{
    CGSize size=[_labTime.text textSize:_labTime.font withWidth:self.frame.size.width];
    _labTime.frame=CGRectMake(10, (self.frame.size.height-size.height)/2, size.width, size.height);
    
    size=[_labName.text textSize:_labName.font withWidth:self.frame.size.width];
    _labName.frame=CGRectMake(_labTime.frame.origin.x+_labTime.frame.size.width+10, (self.frame.size.height-size.height)/2, size.width, size.height);
    
    
    
    CGFloat leftX=_labName.frame.size.width+_labName.frame.origin.x+10;
    CGFloat w=self.frame.size.width-5-leftX;
    size=[_labValue1.text textSize:_labValue1.font withWidth:w];
    
    _labValue1.frame=CGRectMake(leftX, (self.frame.size.height-size.height)/2, w, size.height);
    
    CGFloat h=size.height;
    self.cellHeight=h;
}
- (void)relayoutValue2{
    CGSize size=[_labTime.text textSize:_labTime.font withWidth:self.frame.size.width];
    _labTime.frame=CGRectMake(10, (self.frame.size.height-size.height)/2, size.width, size.height);
    
    size=[_labName.text textSize:_labName.font withWidth:self.frame.size.width];
    _labName.frame=CGRectMake(_labTime.frame.origin.x+_labName.frame.size.width+10, (self.frame.size.height-size.height)/2, size.width, size.height);
    
    CGFloat leftX=_labName.frame.size.width+_labName.frame.origin.x+10;
    CGFloat w=self.frame.size.width-5-leftX;
    size=[_labValue1.text textSize:_labValue1.font withWidth:w];
    CGSize size1=[_labValue2.text textSize:_labValue2.font withWidth:w];
    _labValue1.frame=CGRectMake(leftX, (self.frame.size.height-size.height-size1.height-8)/2, w, size.height);
    _labValue2.frame=CGRectMake(leftX, _labValue1.frame.origin.y+_labValue1.frame.size.height+8, w, size1.height);
    
    
    CGFloat h=size.height+size1.height+8;
    self.cellHeight=h;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.showValue1) {
        [self relayoutValue1];
    }else{
        [self relayoutValue2];
    }
    
}
- (void)setTime:(NSString*)time name:(NSString*)user value1:(NSString*)msg1 value2:(NSString*)msg2{
    _labTime.text=time;
    _labName.text=user;
    _labValue1.text=msg1;
    _labValue2.text=msg2;
    self.showValue1=NO;
    [self relayoutValue2];
    
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
@end
