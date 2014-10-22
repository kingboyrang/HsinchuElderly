//
//  FetchDataManager.h
//  HsinchuElderly
//
//  Created by rang on 14-10-22.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchDataManager : NSObject
//单例模式
+ (FetchDataManager *)sharedInstance;
- (void)updateMetaData;
- (void)updateCheckMeta;
@end
