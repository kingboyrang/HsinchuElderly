//
//  BloodPopoverView.h
//  HsinchuElderly
//
//  Created by aJia on 2014/6/16.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicPopoverView.h"
@interface BloodPopoverView : BasicPopoverView<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *field1;
@property (nonatomic,strong) UITextField *field2;
@end
