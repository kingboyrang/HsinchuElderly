//
//  TKTextFieldCell.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/29.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKTextFieldCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *field;
@property (nonatomic,readonly) BOOL hasValue;
@end
