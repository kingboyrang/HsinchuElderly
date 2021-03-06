//
//  TKRecordCell.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TKRecordCell.h"
#import "UIButton+TPCategory.h"
@implementation TKRecordCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    UIImage *img=[UIImage imageNamed:@"cell_bg.png"];
    img=[img stretchableImageWithLeftCapWidth:img.size.width*0.5f topCapHeight:img.size.height*0.5f];
    CGRect r=self.frame;
    r.size.width=DeviceWidth;
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:r];
    [imageView setImage:img];
    self.backgroundView=imageView;
    
    _deleteButton=[UIButton barButtonWithTitle:@"刪除" target:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteButton];
    
    _editButton=[UIButton barButtonWithTitle:@"編輯" target:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_editButton];
    
    _drugName=[[UILabel alloc] initWithFrame:CGRectZero];
    _drugName.backgroundColor=[UIColor clearColor];
    _drugName.font=default18DeviceFont;
    _drugName.textColor=[UIColor colorFromHexRGB:@"711200"];
    _drugName.numberOfLines=0;
    _drugName.lineBreakMode=NSLineBreakByWordWrapping;
    [self.contentView addSubview:_drugName];
    
    _timeText=[[UILabel alloc] initWithFrame:CGRectZero];
    _timeText.backgroundColor=[UIColor clearColor];
    _timeText.font=default18DeviceFont;
    _timeText.textColor=defaultDeviceFontColor;
    _timeText.numberOfLines=0;
    _timeText.lineBreakMode=NSLineBreakByWordWrapping;
    [self.contentView addSubview:_timeText];
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat leftX=10,topY=10;
    CGFloat w=self.frame.size.width-leftX-_deleteButton.frame.size.width-25-2;
    CGSize size=[_drugName.text textSize:_drugName.font withWidth:w];
    _drugName.frame=CGRectMake(leftX, topY,w, size.height);
    
    topY=_drugName.frame.origin.y+size.height+5;
    size=[_timeText.text textSize:_timeText.font withWidth:w];
    _timeText.frame=CGRectMake(leftX, topY, size.width, size.height);
    
    CGRect r=_deleteButton.frame;
    r.origin.y=(self.frame.size.height-r.size.height*2-5)/2;
    r.origin.x=self.frame.size.width-r.size.width-25;
    _deleteButton.frame=r;
    
    _editButton.frame=CGRectMake(r.origin.x, r.origin.y+r.size.height+5, r.size.width, r.size.height);
    
    r=_drugName.frame;
    r.origin.y=(self.frame.size.height-r.size.height-5-_timeText.frame.size.height)/2;
    _drugName.frame=r;
    
    r=_timeText.frame;
    r.origin.y=_drugName.frame.origin.y+size.height+5;
    _timeText.frame=r;
    
}

@end
