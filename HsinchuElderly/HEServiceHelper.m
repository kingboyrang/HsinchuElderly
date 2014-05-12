//
//  HEServiceHelper.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "HEServiceHelper.h"
#import "HEService.h"
@implementation HEServiceHelper
- (HEBasicTable)basicTable{
    return HEBasicService;
}
- (NSString*)tableName{
    return @"Service";
}
- (NSString*)categoryTableName{
    return @"ServiceCategory";
}
- (NSString*)areaTableName{
    return @"ServiceArea";
}
- (id)init{
    if (self=[super init]) {
        [self registerBasicModelSubclass:[HEService class]];
    }
    return self;
}
@end
