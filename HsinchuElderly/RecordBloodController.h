//
//  RecordBloodController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShrinkPickerView.h"
#import "RecordTimeView.h"
#import "RecordBloodHelper.h"
@interface RecordBloodController : BasicViewController
@property (nonatomic,strong) ShrinkPickerView *shrinkView;
@property (nonatomic,strong) RecordTimeView *timeView;
@property (nonatomic,strong) RecordBloodHelper *bloodHelper;
@property (nonatomic,strong) RecordBlood *Entity;
@property (nonatomic,assign) int operType;//1表示新增 2:修改
@property (nonatomic,copy)   NSString *userId;//当前选中用户id
@end
