//
//  BloodSugarPopoverView.h
//  HsinchuElderly
//
//  Created by aJia on 2014/6/17.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicPopoverView.h"
@interface BloodSugarPopoverView : BasicPopoverView<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *field;
@end
