//
//  UploadAlertView.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/31.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadAlertView : UIView<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *fieldTitle;
@property (nonatomic,strong) UITextField *fieldEmail;
@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic,strong) UIButton *confirmButton;
@property (nonatomic,strong) UIView *winBgView;
- (void)show;
- (void)hide;
@end
