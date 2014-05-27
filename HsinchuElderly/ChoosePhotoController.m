//
//  ChoosePhotoController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/14.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "ChoosePhotoController.h"
#import "UploadPhotoController.h"
@interface ChoosePhotoController ()

@end

@implementation ChoosePhotoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"分享照片";
    
    self.albumCamera=[[AlbumCameraImage alloc] init];
    self.albumCamera.delegate=self;
    
    
    UIImage *img1=[UIImage imageNamed:[self imageNameWithName:@"upalbum" forType:@"png"]];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(10, 10, img1.size.width, img1.size.height);
    [btn setImage:img1 forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonAlbumClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIImage *img2=[UIImage imageNamed:[self imageNameWithName:@"upcamera" forType:@"png"]];
    CGFloat topY=self.view.bounds.size.height-[self topHeight]-img2.size.height-10;
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(self.view.bounds.size.width-img2.size.width-10, topY, img2.size.width, img2.size.height);
    [btn2 setImage:img2 forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(buttonCameraClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}
//相簿
- (void)buttonAlbumClick:(UIButton*)btn{
  [self.albumCamera showAlbumInController:self];
}
//拍照
- (void)buttonCameraClick:(UIButton*)btn{
    [self.albumCamera showCameraInController:self];
}
#pragma mark AlbumCameraDelegate Methods
- (void)photoFromAlbumCameraWithImage:(UIImage*)image{
    UploadPhotoController *upload=[[UploadPhotoController alloc] init];
    upload.uploadImage=image;
    [self.navigationController pushViewController:upload animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
