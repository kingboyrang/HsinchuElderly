//
//  BasicViewController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/7.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "BasicViewController.h"
#import "UIButton+TPCategory.h"
#import "NetWorkConnection.h"
@interface BasicViewController (){
    AnimateLoadView *_loadView;
    AnimateErrorView *_errorView;
    AnimateErrorView *_successView;
}
- (void)setBarBackButtonItem;
- (void)buttonBackClick:(id)sender;
@end

@implementation BasicViewController

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
#ifdef __IPHONE_7_0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
#endif
    if (self.navigationController) {
        if ([self.navigationController.viewControllers count]==1) {
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:self.view.bounds];
            [imageView setImage:[UIImage imageNamed:@"index_bg.png"]];
            [self.view addSubview:imageView];
        }else{
            UIImage *img=[UIImage imageNamed:@"bg.png"];
            CGRect r=self.view.bounds;
            r.size.height-=[self topHeight];
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:r];
            [imageView setImage:img];
            [self.view addSubview:imageView];
            [self setBarBackButtonItem];//返回按钮
        }
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    //UIStatusBarStyleDefault = 0 黑色文字，浅色背景时使用
    //UIStatusBarStyleLightContent = 1 白色文字，深色背景时使用
}

- (BOOL)prefersStatusBarHidden
{
    return self.navigationController.viewControllers.count==1?YES:NO; //返回NO表示要显示，返回YES将hiden
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /***
    if (self.navigationController.viewControllers.count==1) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }else{
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    }
     ***/
}
- (float)topHeight{
    float h=0;
#ifdef __IPHONE_7_0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        if (self.navigationController) {
            return 64;
        }
    }
#endif
    if (self.navigationController) {
        return 44;
    }
    return h;
}
- (BOOL)hasNewWork{
    return [NetWorkConnection IsEnableConnection];
}
- (void)setBarBackButtonItem{
    UIButton *btn=[UIButton buttonWithImageName:@"left_back.png" target:self action:@selector(buttonBackClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtn=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=barBtn;
}
- (void)buttonBackClick:(id)sender{
    if (![self backPrevViewController]) {
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)backPrevViewController{
    return YES;
}
#pragma mark 動畫提示
-(AnimateErrorView*) errorView {
    
    if (!_errorView) {
        _errorView=[[AnimateErrorView alloc] initWithFrame:CGRectMake(0,4, self.view.bounds.size.width, 40)];
        _errorView.backgroundColor=[UIColor redColor];
        [_errorView setErrorImage:[UIImage imageNamed:@"notice_error_icon.png"]];
    }
    return _errorView;
}

-(AnimateLoadView*) loadingView {
    if (!_loadView) {
        _loadView=[[AnimateLoadView alloc] initWithFrame:CGRectMake(0,4, self.view.bounds.size.width, 40)];
    }
    return _loadView;
}
-(AnimateErrorView*) successView {
    if (!_successView) {
        _successView=[[AnimateErrorView alloc] initWithFrame:CGRectMake(0, 4, self.view.bounds.size.width, 40)];
        _successView.backgroundColor=[UIColor colorFromHexRGB:@"51c345"];
        [_successView setErrorImage:[UIImage imageNamed:@"notice_success_icon.png"]];
    }
    return _successView;
}
-(void) showLoadingAnimatedWithTitle:(NSString*)title{
    [self showLoadingAnimated:^(AnimateLoadView *errorView) {
        errorView.labelTitle.text=title;
    }];
}
-(void) showLoadingAnimated:(void (^)(AnimateLoadView *errorView))process{
    AnimateLoadView *loadingView = [self loadingView];
    if (process) {
        process(loadingView);
    }
    [self.view addSubview:loadingView];
    CGRect r=loadingView.frame;
    r.origin.y=2;
    [loadingView.activityIndicatorView startAnimating];
    [UIView animateWithDuration:0.5f animations:^{
        loadingView.frame=r;
    }];
}

-(void) hideLoadingViewAnimated:(void (^)(AnimateLoadView *hideView))complete{
    
    AnimateLoadView *loadingView = [self loadingView];
    CGRect r=loadingView.frame;
    r.origin.y=-r.size.height;
    [UIView animateWithDuration:0.5f animations:^{
        loadingView.frame=r;
    } completion:^(BOOL finished) {
        [loadingView.activityIndicatorView stopAnimating];
        [loadingView removeFromSuperview];
        if (complete) {
            complete(loadingView);
        }
    }];
}


-(void) showErrorViewAnimated:(void (^)(AnimateErrorView *errorView))process{
    AnimateErrorView *errorView = [self errorView];
    if (process) {
        process(errorView);
    }
    [self.view addSubview:errorView];
    CGRect r=errorView.frame;
    r.origin.y=2;
    [UIView animateWithDuration:0.5f animations:^{
        errorView.frame=r;
    }];
}
-(void) hideErrorViewAnimatedWithDuration:(NSTimeInterval)duration completed:(void (^)(AnimateErrorView *errorView))complete{
    
    AnimateErrorView *errorView = [self errorView];
    CGRect r=errorView.frame;
    r.origin.y=-r.size.height;
    [UIView animateWithDuration:duration animations:^{
        errorView.frame=r;
    } completion:^(BOOL finished) {
        if (finished) {
            [errorView removeFromSuperview];
            if (complete) {
                complete(errorView);
            }
        }
    }];
}
-(void) hideErrorViewAnimated:(void (^)(AnimateErrorView *errorView))complete{
    [self hideErrorViewAnimatedWithDuration:0.5f completed:complete];
}
-(void) showErrorViewWithHide:(void (^)(AnimateErrorView *errorView))process completed:(void (^)(AnimateErrorView *errorView))complete{
    [self showErrorViewAnimated:process];
    //設置延遲執行時間為1秒
    int64_t delayInSeconds = 2.0f;
    dispatch_time_t popTime =
    dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self hideErrorViewAnimated:complete];
    });
}
-(void) hideLoadingFailedWithTitle:(NSString*)title completed:(void (^)(AnimateErrorView *errorView))complete{
    [self hideLoadingViewAnimated:^(AnimateLoadView *hideView) {
        [self showErrorViewWithHide:^(AnimateErrorView *errorView) {
            errorView.labelTitle.text=title;
        } completed:complete];
    }];
}
-(void) showSuccessViewAnimated:(void (^)(AnimateErrorView *errorView))process{
    AnimateErrorView *errorView = [self successView];
    if (process) {
        process(errorView);
    }
    [self.view addSubview:errorView];
    CGRect r=errorView.frame;
    r.origin.y=2;
    [UIView animateWithDuration:0.5f animations:^{
        errorView.frame=r;
    }];
}
-(void) hideSuccessViewAnimated:(void (^)(AnimateErrorView *errorView))complete{
    AnimateErrorView *errorView = [self successView];
    CGRect r=errorView.frame;
    r.origin.y=-r.size.height;
    [UIView animateWithDuration:0.5f animations:^{
        errorView.frame=r;
    } completion:^(BOOL finished) {
        [errorView removeFromSuperview];
        if (complete) {
            complete(errorView);
        }
    }];
}
-(void) showSuccessViewWithHide:(void (^)(AnimateErrorView *errorView))process completed:(void (^)(AnimateErrorView *errorView))complete{
    [self showSuccessViewAnimated:process];
    //設置延遲執行時間為1秒
    int64_t delayInSeconds = 2.0f;
    dispatch_time_t popTime =
    dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self hideSuccessViewAnimated:complete];
    });
    
}
-(void) hideLoadingSuccessWithTitle:(NSString*)title completed:(void (^)(AnimateErrorView *errorView))complete{
    [self hideLoadingViewAnimated:^(AnimateLoadView *hideView) {
        [self showSuccessViewAnimated:^(AnimateErrorView *errorView) {
            errorView.labelTitle.text=title;
        }];
        [self performSelector:@selector(hideSuccessViewAnimated:) withObject:complete afterDelay:1.0f];
    }];
}
- (void) showErrorNetWorkNotice:(void (^)(void))dismissError{
    
    [self showErrorViewWithHide:^(AnimateErrorView *errorView) {
        errorView.labelTitle.text=@"網路尚未連接，請檢查您的網路連接後再次連接！";
    } completed:nil];
}
- (void) showMessageWithTitle:(NSString*)title{
    [self showMessageWithTitle:title innerView:self.view dismissed:nil];
}
- (void) showMessageWithTitle:(NSString*)title innerView:(UIView*)view dismissed:(void(^)())completed{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
