//
//  MedicalCareController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPMenuHelper.h"
#import "TopBarView.h"
@interface MedicalCareController : BasicViewController<TPMenuHelperDelegate>
@property (nonatomic,strong) TPMenuHelper *menuHelper;
@property (nonatomic,strong) TopBarView *topBarView;
@end
