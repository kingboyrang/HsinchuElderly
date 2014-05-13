//
//  TKLineCell.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/13.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TKLineCell.h"
#import "UIImage+TPCategory.h"
@interface TKLineCell ()
@property (nonatomic,strong) UIImageView *lineImageView;
@end

@implementation TKLineCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    self.textLabel.textColor=defaultDeviceFontColor;
    self.textLabel.font=defaultSDeviceFont;
    
    UIImage *image=[UIImage createImageWithColor:[UIColor colorFromHexRGB:@"fec75a"] imageSize:CGSizeMake(self.frame.size.width, 2)];
    _lineImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [_lineImageView setImage:image];
    [self.contentView addSubview:_lineImageView];
    
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void) layoutSubviews {
    [super layoutSubviews];
	
   CGRect r=_lineImageView.frame;
    r.origin.y=self.frame.size.height-r.size.height;
    _lineImageView.frame=r;
}
@end
