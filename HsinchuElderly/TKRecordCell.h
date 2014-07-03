//
//  TKRecordCell.h
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKRecordCell : UITableViewCell
@property (nonatomic,strong) UILabel *drugName;//藥名
@property (nonatomic,strong) UILabel *timeText;//時間
@property (nonatomic,strong) UIButton *deleteButton;//刪除
@property (nonatomic,strong) UIButton *editButton;//編輯
@end
