//
//  RecordViewController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/6/13.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordTopView.h"
@interface RecordViewController : BasicViewController<RecordTopViewDelegate>
@property (nonatomic,strong) RecordTopView *topView;
@property (nonatomic,copy)   NSString *recordType;
@property (nonatomic,copy)   NSString *userId;//当前选中用户id
@end
