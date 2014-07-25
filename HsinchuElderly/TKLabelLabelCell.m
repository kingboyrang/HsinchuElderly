//
//  TKLabelLabelCell.m
//  HsinchuElderly
//
//  Created by rang on 14-5-11.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TKLabelLabelCell.h"
#import "UIImage+TPCategory.h"

@interface TKLabelLabelCell ()
//@property (nonatomic,strong) UIImageView *lineImageView;
@end

@implementation TKLabelLabelCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    _labName = [[UILabel alloc] initWithFrame:CGRectZero];
	_labName.backgroundColor = [UIColor clearColor];
    _labName.textAlignment = NSTextAlignmentRight;
    _labName.textColor = [UIColor blackColor];
    _labName.font = default18DeviceFont;
	[self.contentView addSubview:_labName];
    
    _labDetail = [[UILabel alloc] initWithFrame:CGRectZero];
	_labDetail.backgroundColor = [UIColor clearColor];
    _labDetail.textAlignment = NSTextAlignmentLeft;
    _labDetail.textColor = [UIColor blackColor];
    _labDetail.font = default18DeviceFont;
    _labDetail.numberOfLines=0;
    _labDetail.lineBreakMode=NSLineBreakByWordWrapping;
	[self.contentView addSubview:_labDetail];
    
    /***
    UIImage *image=[UIImage createImageWithColor:[UIColor colorFromHexRGB:@"fec75a"] imageSize:CGSizeMake(self.frame.size.width, 2)];
    _lineImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [_lineImageView setImage:image];
    [self.contentView addSubview:_lineImageView];
     ***/
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}


- (void) layoutSubviews {
    [super layoutSubviews];
    
	
	CGRect r = CGRectInset(self.contentView.bounds, 10, 10);
    r.size = CGSizeMake(72,27);
    CGSize size=[_labName.text textSize:_labName.font withWidth:r.size.width];
    r.size=size;
    r.origin.y=(self.frame.size.height-size.height)/2;
	_labName.frame = r;
    
    
    CGFloat leftX=r.origin.x+r.size.width+2;
    CGFloat w=self.frame.size.width-leftX-18;
    size=[_labDetail.text textSize:_labDetail.font withWidth:w];
    _labDetail.frame=CGRectMake(leftX,(self.frame.size.height-size.height)/2, size.width, size.height);

    NSLog(@"r=%@",NSStringFromCGRect(_labDetail.frame));
    /***
    r=_lineImageView.frame;
    r.size.width=self.frame.size.width;
    r.origin.y=self.frame.size.height-r.size.height;
    _lineImageView.frame=r;
     ***/
}

@end
