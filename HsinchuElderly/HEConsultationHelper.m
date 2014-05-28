//
//  HEConsultationHelper.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/14.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "HEConsultationHelper.h"
#import "HEConsultation.h"
@implementation HEConsultationHelper
- (HEBasicTable)basicTable{
    return HEBasicWelfare;
}
//咨詢
- (NSString*)tableName{
    return @"1";
}
- (NSString*)categoryTableName{
    return @"ConsultationCategory";
}
- (NSString*)areaTableName{
    return @"ConsultationArea";
}
- (id)init{
    if (self=[super init]) {
        [self registerBasicModelSubclass:[HEConsultation class]];
    }
    return self;
}
@end
