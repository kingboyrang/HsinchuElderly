//
//  TKDrugCell.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TKDrugCell.h"
#import "UIButton+TPCategory.h"
@implementation TKDrugCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    UIImage *img=[UIImage imageNamed:@"cell_bg.png"];
    img=[img stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    CGRect r=self.frame;
    r.size.width=DeviceWidth;
    UIView *bgView=[[UIView alloc] initWithFrame:r];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:bgView.bounds];
    [imageView setImage:img];
    [bgView addSubview:imageView];
    self.backgroundView=bgView;
    
    _deleteButton=[UIButton barButtonWithTitle:@"刪除" target:self action:nil forControlEvents:UIControlEventTouchUpInside];
    self.accessoryView=_deleteButton;
    
    _drugName=[[UILabel alloc] initWithFrame:CGRectZero];
    _drugName.backgroundColor=[UIColor clearColor];
    _drugName.font=defaultBDeviceFont;
    _drugName.textColor=[UIColor colorFromHexRGB:@"711200"];
    [self.contentView addSubview:_drugName];
    
    _timeText=[[UILabel alloc] initWithFrame:CGRectZero];
    _timeText.backgroundColor=[UIColor clearColor];
    _timeText.font=defaultSDeviceFont;
    _timeText.textColor=defaultDeviceFontColor;
    [self.contentView addSubview:_timeText];
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size=[_drugName.text textSize:defaultBDeviceFont withWidth:self.frame.size.width];
    _drugName.frame=CGRectMake(10, self.frame.size.height/2-size.height-1, size.width, size.height);
    
    size=[_timeText.text textSize:defaultSDeviceFont withWidth:self.frame.size.width];
    CGRect r=_drugName.frame;
    r.origin.y+=r.size.height+2;
    r.size=size;
   
    
    _timeText.frame=r;
    
}
@end
