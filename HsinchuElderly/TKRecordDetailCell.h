//
//  TKRecordDetailCell.h
//  HsinchuElderly
//
//  Created by aJia on 2014/6/17.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKRecordDetailCell : UITableViewCell
@property (nonatomic,strong) UILabel *labTime;
@property (nonatomic,strong) UILabel *labName;
@property (nonatomic,strong) UILabel *labValue1;
@property (nonatomic,strong) UILabel *labValue2;
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,assign) BOOL showValue1;
- (void)setTime:(NSString*)time name:(NSString*)user detail:(NSString*)message;
- (void)setTime:(NSString*)time name:(NSString*)user value1:(NSString*)msg1 value2:(NSString*)msg2;
@end
