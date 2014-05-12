//
//  HEStudyHelper.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "HEStudyHelper.h"
#import "HEStudy.h"
@implementation HEStudyHelper
- (HEBasicTable)basicTable{
    return HEBasicStudy;
}
- (NSString*)tableName{
    return @"Student";
}
- (NSString*)categoryTableName{
    return @"StudentCategory";
}
- (NSString*)areaTableName{
    return @"StudentArea";
}
- (id)init{
    if (self=[super init]) {
        [self registerBasicModelSubclass:[HEStudy class]];
    }
    return self;
}
@end
