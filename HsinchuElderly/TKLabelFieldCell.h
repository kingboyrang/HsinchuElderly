//
//  TKLabelFieldCell.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/8.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKLabelCell.h"
@interface TKLabelFieldCell : TKLabelCell<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *field;
@property (nonatomic,readonly) BOOL hasValue;
@end
