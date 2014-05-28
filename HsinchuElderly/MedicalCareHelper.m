//
//  MedicalCareHelper.m
//  HsinchuElderly
//
//  Created by rang on 14-5-10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "MedicalCareHelper.h"
#import "MedicalCare.h"
@implementation MedicalCareHelper

- (HEBasicTable)basicTable{
    return HEBasicMedicalCare;
}
//醫療
- (NSString*)tableName{
    return @"2";
}
- (NSString*)categoryTableName{
    return @"MedicalCareCategory";
}
- (NSString*)areaTableName{
    return @"MedicalCareArea";
}
- (id)init{
    if (self=[super init]) {
        [self registerBasicModelSubclass:[MedicalCare class]];
    }
    return self;
}
@end
