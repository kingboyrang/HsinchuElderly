//
//  UploadPhotoController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/14.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UploadAlertView.h"
@interface UploadPhotoController : BasicViewController<UploadAlertViewDelegate>
@property (nonatomic,strong) UIImage *uploadImage;
@property (nonatomic,strong) UIImageView *previewImageView;
@property (nonatomic,strong) UploadAlertView *alertView;
@property (nonatomic,strong) UIButton *uploadBtn;
@property (nonatomic,assign) CGRect maxRect;
@end
