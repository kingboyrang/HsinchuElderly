//
//  VersionViewController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/22.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "VersionViewController.h"
#import "VersionView.h"
#import <MessageUI/MessageUI.h>
#import "AlertHelper.h"
#import "AppHelper.h"
#import "SendMailViewController.h"
@interface VersionViewController ()<MFMailComposeViewControllerDelegate>

@end

@implementation VersionViewController

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
     self.title=@"竹縣長青樂";
    
    VersionView *version=[[VersionView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
    CGRect r=version.frame;
    r.origin.x=(self.view.bounds.size.width-r.size.width)/2;
    r.origin.y=(self.view.bounds.size.height-[self topHeight]-r.size.height)/2;
    version.frame=r;
    [version.emailBtn addTarget:self action:@selector(buttonEmailClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:version];
}
//發送email
- (void)buttonEmailClick:(UIButton*)btn{
   
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *emailer = [[MFMailComposeViewController alloc] init];
        emailer.mailComposeDelegate = self;
        // 添加发送者
        NSArray *toRecipients = [NSArray arrayWithObject: @"hchgL301@hchg.gov.tw"];
        [emailer setToRecipients: toRecipients];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            emailer.modalPresentationStyle = UIModalPresentationPageSheet;
        }
        [self presentViewController:emailer animated:YES completion:nil];
    }else{
       [AlertHelper initWithTitle:@"提示" message:@"未設置郵件帳號，無法發送郵件！"];
    }
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            //msg = @"郵件發送取消";
            break;
        case MFMailComposeResultSaved:
            //msg = @"郵件儲存成功";
            //[self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultSent:
            //[AlertHelper initWithTitle:@"提示" message:@"郵件發送成功!"];
            //[self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultFailed:
            //msg = @"郵件發送失敗";
            //[self alertWithTitle:nil msg:msg];
            //[AlertHelper initWithTitle:@"提示" message:@"郵件發送失敗!"];
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
