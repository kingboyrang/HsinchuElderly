//
//  RecordTimeView.h
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordTimeView : UIView
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property(nonatomic,retain) NSDateFormatter *dateForFormat;
@property (nonatomic,readonly) NSString *timeValue;
- (void)defaultInitParams;
//设置值选中
- (void)setSelectedValue:(NSString*)val;
@end
