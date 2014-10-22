//
//  FetchDataManager.m
//  HsinchuElderly
//
//  Created by rang on 14-10-22.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "FetchDataManager.h"
#import "ServiceRequestManager.h"
#import "HEBasicHelper.h"
#import "UCSUserDefaultManager.h"
#import "NetWorkConnection.h"
@implementation FetchDataManager
//单例模式
+ (FetchDataManager *)sharedInstance{
    static dispatch_once_t  onceToken;
    static FetchDataManager * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[FetchDataManager alloc] init];
    });
    return sSharedInstance;
}
- (void)updateMetaData{
    //表示有网络
    if ([NetWorkConnection IsEnableConnection]) {
        [self asyncMetaVersion];
       //[self performSelectorInBackground:@selector(asyncMetaVersion) withObject:nil];
    }
}
- (void)backgroundFetchData{
    [UCSUserDefaultManager SetLocalDataBoolen:NO key:kUpdateMetaSuccess];
    ServiceArgs *args=[[ServiceArgs alloc] init];
    args.methodName=@"GetAppData";
    ServiceRequestManager *manager=[ServiceRequestManager requestWithArgs:args];
    [manager success:^{
        NSError *error=nil;
        NSArray *arr=[NSJSONSerialization JSONObjectWithData:manager.responseData options:1 error:&error];
        if (error==nil) {//表示转换正常
            [HEBasicHelper updateInformationWithArray:arr];
        }
    } failure:^{
        
    }];
}
- (void)asyncMetaVersion{
    ServiceArgs *args=[[ServiceArgs alloc] init];
    args.methodName=@"GetAppDataVersion";
    NSLog(@"header=%@",args.headers);
    NSLog(@"body=%@",args.bodyMessage);
    ServiceRequestManager *manager=[ServiceRequestManager requestWithArgs:args];
    [manager success:^{
        NSLog(@"xml=%@",manager.responseString);
        NSString *version=manager.responseString;
        NSString *oldVersion=[UCSUserDefaultManager GetLocalDataString:kMetaVersion];
        if (![version isEqualToString:oldVersion]) {
            [UCSUserDefaultManager SetLocalDataString:version key:kMetaVersion];
            [self backgroundFetchData];//更新数据
        }
    } failure:^{
        NSLog(@"error=%@",manager.error.description);
    }];
}
- (void)updateCheckMeta{
    ServiceArgs *args=[[ServiceArgs alloc] init];
    args.methodName=@"GetAppDataVersion";
    ServiceRequestManager *manager=[ServiceRequestManager requestWithArgs:args];
    [manager success:^{
        NSString *version=manager.responseString;
        NSString *oldVersion=[UCSUserDefaultManager GetLocalDataString:kMetaVersion];
        int total=[HEBasicHelper getMetaDataCount];
        if (![version isEqualToString:oldVersion]||total==0) {
            [UCSUserDefaultManager SetLocalDataString:version key:kMetaVersion];
            [self backgroundFetchData];//更新数据
        }else if (![UCSUserDefaultManager GetLocalDataBoolen:kUpdateMetaSuccess])
        {
            [self backgroundFetchData];//更新数据
        }
    } failure:^{
        
    }];
}
@end
