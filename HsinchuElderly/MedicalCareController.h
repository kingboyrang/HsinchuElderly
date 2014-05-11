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
#import "MedicalCareHelper.h"
@interface MedicalCareController : BasicViewController<TPMenuHelperDelegate>{
    int pageSize;
    int pageNumber;
}
@property (nonatomic,strong) TPMenuHelper *menuHelper;
@property (nonatomic,strong) TopBarView *topBarView;
@property (nonatomic,strong) MedicalCareHelper *dbHelper;
@property (nonatomic,strong) NSMutableArray *medicalCategorys;
@property (nonatomic,strong) NSMutableArray *medicalAreas;
@property (nonatomic,strong) NSMutableArray *list;
@end
