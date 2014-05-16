//
//  ChoosePhotoController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/14.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumCameraImage.h"
@interface ChoosePhotoController : BasicViewController<AlbumCameraDelegate>
@property (nonatomic,strong) AlbumCameraImage *albumCamera;
@end
