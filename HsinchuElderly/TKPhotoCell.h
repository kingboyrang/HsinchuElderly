//
//  TKPhotoCell.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/8.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKPhotoCell : UITableViewCell
@property (assign, nonatomic) BOOL hasImage;
@property (strong, nonatomic) UIImageView *photoImage;
@property (strong, nonatomic) UIButton *albumBtn;
@property (strong, nonatomic) UIButton *cameraBtn;

- (void)setPhotoWithImage:(UIImage*)img;
@end
