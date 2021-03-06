//
//  UploadPhotoController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/14.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "UploadPhotoController.h"
#import "UIImage+TPCategory.h"
@interface UploadPhotoController ()
- (CGSize)autoImageSize:(CGSize)imgSize;
@end

@implementation UploadPhotoController

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
    
    _alertView=[[UploadAlertView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-300)/2, 0, 300, 0)];
    _alertView.delegate=self;
    
    //self.view.backgroundColor=[UIColor colorFromHexRGB:@"fffbbe"];
    self.title=@"分享照片";
    //頂部圖片
    UIImage *topImg=[UIImage imageNamed:[self imageNameWithName:@"u_top" forType:@"png"]];
    UIImageView *imageView1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, topImg.size.width, topImg.size.height)];
    [imageView1 setImage:topImg];
    [self.view addSubview:imageView1];
    
    //上傳按鈕
    CGFloat topY=self.view.bounds.size.height-[self topHeight]-10-40;
    UIImage *img1=[UIImage imageNamed:@"btn_bg.png"];
    img1=[img1 stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    _uploadBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _uploadBtn.frame=CGRectMake((self.view.bounds.size.width-150)/2, topY, 150, 40);
    [_uploadBtn setBackgroundImage:img1 forState:UIControlStateNormal];
    [_uploadBtn setTitle:@"上傳" forState:UIControlStateNormal];
    [_uploadBtn setTitleColor:defaultDeviceFontColor forState:UIControlStateNormal];
    _uploadBtn.titleLabel.font=defaultBDeviceFont;
    [_uploadBtn addTarget:self action:@selector(buttonUploadClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_uploadBtn];
    
    //底部圖片
    UIImage *bottomImg=[UIImage imageNamed:[self imageNameWithName:@"u_bottom" forType:@"png"]];
    UIImageView *imageView2=[[UIImageView alloc] initWithFrame:CGRectMake(0,_uploadBtn.frame.origin.y-bottomImg.size.height-10, bottomImg.size.width, bottomImg.size.height)];
    [imageView2 setImage:bottomImg];
    [self.view addSubview:imageView2];
    
    //圖片預覽部分背景
    topY=imageView1.frame.origin.y+imageView1.frame.size.height-(DeviceIsPad?30:13);
    CGFloat h=imageView2.frame.origin.y-topY+(DeviceIsPad?85:34);
    CGRect r=CGRectMake(0, topY, self.view.bounds.size.width, h);
    self.maxRect=r;
    //UIView *bgView=[[UIView alloc] initWithFrame:r];
    //bgView.backgroundColor=[UIColor clearColor];
    //[self.view addSubview:bgView];
    
    //最底部
    topY=imageView2.frame.origin.y+imageView2.frame.size.height;
    h=self.view.bounds.size.height-[self topHeight]-topY;
    UIView *bgView1=[[UIView alloc] initWithFrame:CGRectMake(0, topY, self.view.bounds.size.height, h)];
    //bgView1.backgroundColor=[UIColor colorFromHexRGB:@"ff9800"];
    bgView1.backgroundColor=[UIColor clearColor];
    [self.view addSubview:bgView1];
    [self.view bringSubviewToFront:_uploadBtn];
    
    //顯示圖片
    CGSize imgSize=[self autoImageSize:self.uploadImage.size];
    topY=self.maxRect.origin.y+(self.maxRect.size.height-imgSize.height)/2;
    _previewImageView=[[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-imgSize.width)/2, topY, imgSize.width, imgSize.height)];
    [_previewImageView setImage:self.uploadImage];
    [self.view addSubview:_previewImageView];
    [self.view sendSubviewToBack:_previewImageView];
    
}
//圖片等比例顯示
- (CGSize)autoImageSize:(CGSize)imgSize
{
    CGFloat oldWidth = imgSize.width;
    CGFloat oldHeight = imgSize.height;
    CGSize saveSize =imgSize;
    
    CGSize defaultSize =self.maxRect.size; //預設大小
    CGFloat wPre = oldWidth / defaultSize.width;
    CGFloat hPre = oldHeight / defaultSize.height;
    if (oldWidth > defaultSize.width || oldHeight > defaultSize.height) {
        if (wPre > hPre) {
            saveSize.width = defaultSize.width;
            saveSize.height = oldHeight / wPre;
        }
        else {
            saveSize.width = oldWidth / hPre;
            saveSize.height = defaultSize.height;
        }
    }
    if (saveSize.width>self.maxRect.size.width) {
        saveSize.width=self.maxRect.size.width;
    }
    if (saveSize.height>self.maxRect.size.height) {
        saveSize.height=self.maxRect.size.height;
    }
    return saveSize;
}
#pragma mark -UploadAlertViewDelegate Methods
- (void)startUploadImage{
    if (![self hasNewWork]) {
        [self showErrorNetWorkNotice:nil];
        return;
    }
    /***
    _uploadBtn.enabled=NO;
    [self showLoadingAnimatedWithTitle:@"正在上傳圖片..."];
    
    NSMutableArray *params=[NSMutableArray array];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:[self.uploadImage imageBase64String],@"imgBase64String", nil]];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:_alertView.fieldTitle.text,@"title", nil]];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:_alertView.fieldEmail.text,@"email", nil]];
    ServiceArgs *args=[[ServiceArgs alloc] init];
    args.methodName=@"UploadImg";//要調用的webservice方法
    args.soapParams=params;//傳遞方法參數
    args.httpWay=ServiceHttpSoap12;
    SRMNetworkEngine *engine=[[SRMNetworkEngine alloc] initWithHostName:args.hostName];
    [engine requestWithArgs:args success:^(MKNetworkOperation *completedOperation) {
        //NSLog(@"xml=%@",completedOperation.responseString);
        _uploadBtn.enabled=YES;
        [self hideLoadingSuccessWithTitle:@"照片上傳完成" completed:^(AnimateErrorView *successView) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    } failure:^(MKNetworkOperation *completedOperation, NSError *error) {
        _uploadBtn.enabled=YES;
        [self hideLoadingFailedWithTitle:@"上傳失敗！" completed:nil];
    }];
     ***/
}
//上傳圖片
- (void)buttonUploadClick:(UIButton*)btn{
    
    [_alertView show];
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
