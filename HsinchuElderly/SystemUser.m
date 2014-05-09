//
//  SystemUser.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/9.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "SystemUser.h"
#import "FileHelper.h"
@implementation SystemUser
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.ID forKey:@"ID"];
    [encoder encodeObject:self.Name forKey:@"Name"];
    [encoder encodeObject:self.PhotoURL forKey:@"PhotoURL"];
    [encoder encodeInteger:self.Sex forKey:@"Sex"];
    [encoder encodeObject:self.CreateDate forKey:@"CreateDate"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.ID=[aDecoder decodeObjectForKey:@"ID"];
        self.Name=[aDecoder decodeObjectForKey:@"Name"];
        self.PhotoURL=[aDecoder decodeObjectForKey:@"PhotoURL"];
        self.Sex=[aDecoder decodeIntegerForKey:@"Sex"];
        self.CreateDate=[aDecoder decodeObjectForKey:@"CreateDate"];
    }
    return self;
}
@end
