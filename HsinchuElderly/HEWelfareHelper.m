//
//  HEWelfareHelper.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/12.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "HEWelfareHelper.h"
#import "HEWelfare.h"
@implementation HEWelfareHelper
- (HEBasicTable)basicTable{
    return HEBasicWelfare;
}
- (NSString*)tableName{
    return @"Welfare";
}
- (NSString*)categoryTableName{
    return @"WelfareCategory";
}
- (NSString*)areaTableName{
    return @"WelfareArea";
}
- (id)init{
    if (self=[super init]) {
        [self registerBasicModelSubclass:[HEWelfare class]];
    }
    return self;
}
@end
