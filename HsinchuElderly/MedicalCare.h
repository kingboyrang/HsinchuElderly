//
//  MedicalCare.h
//  HsinchuElderly
//
//  Created by rang on 14-5-10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MedicalCare : NSObject
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *Name;
@property (nonatomic,copy) NSString *Address;
@property (nonatomic,copy) NSString *Tel;
@property (nonatomic,copy) NSString *MedicalCareCategoryGuid;
@property (nonatomic,copy) NSString *MedicalCareAreaGuid;
@property (nonatomic,copy) NSString *WebSiteURL;
@end
