//
//  MedicalCareController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "MedicalCareController.h"
#import "MedicalCareHelper.h"
@interface MedicalCareController ()
@end

@implementation MedicalCareController

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
     self.title=@"醫療";
}
- (void)defaultPageInit{
    self.dbHelper=[[MedicalCareHelper alloc] init];
}
@end
