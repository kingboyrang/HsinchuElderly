//
//  TKRecordBloodSugarCell.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/15.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TKRecordBloodSugarCell.h"

@implementation TKRecordBloodSugarCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    self.backgroundColor=[UIColor clearColor];
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"RecordBloodSugarView" owner:nil options:nil];
    self.sugarView=(RecordBloodSugarView*)[nibContents objectAtIndex:0];
    self.sugarView.frame=CGRectMake(0, 0, DeviceWidth, DeviceIsPad?256:202);
    [self.contentView addSubview:self.sugarView];
    [self.sugarView defaultInitControl];
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
@end
