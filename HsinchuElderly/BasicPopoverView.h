//
//  BasicPopoverView.h
//  HsinchuElderly
//
//  Created by aJia on 2014/6/16.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopoverViewDelegate <NSObject>
- (void)canclePopoverWithTarget:(id)sender;
- (void)confirmPopoverWithTarget:(id)sender;
@end

@interface BasicPopoverView : UIView
@property (nonatomic,strong) UILabel *labMessage;
@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic,strong) UIButton *confirmButton;
@property (nonatomic,assign) id<PopoverViewDelegate> delegate;
- (void)setMessage:(NSString*)message;
- (void)addCustomView:(UIView*)view;

//取消
- (void)buttonHideClick:(UIButton*)btn;
//確認
- (void)buttonConfirmClick:(UIButton*)btn;
- (void)show;
- (void)showWithUploadHide:(void(^)())completed;
@end
