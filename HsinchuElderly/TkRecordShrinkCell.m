//
//  TkRecordShrinkCell.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/15.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TkRecordShrinkCell.h"

@implementation TkRecordShrinkCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    self.backgroundColor=[UIColor clearColor];
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"ShrinkPickerView" owner:nil options:nil];
    self.shrinkView=(ShrinkPickerView*)[nibContents objectAtIndex:0];
    [self.contentView addSubview:_shrinkView];
    [self.shrinkView defaultSelectedPicker];
    
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r=self.bounds;
    r.size.height=202;
    _shrinkView.frame=r;
}
@end
