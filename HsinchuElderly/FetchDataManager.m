//
//  FetchDataManager.m
//  HsinchuElderly
//
//  Created by rang on 14-10-22.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "FetchDataManager.h"
#import "ASIServiceArgs.h"
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
    ASIServiceArgs *args=[[ASIServiceArgs alloc] init];
    args.methodName=@"GetAppData";
    ASIHTTPRequest *manager=[args request];
    __block ASIHTTPRequest *request = manager;
    [manager setCompletionBlock:^{
        NSError *error=nil;
        NSArray *arr=[NSJSONSerialization JSONObjectWithData:request.responseData options:1 error:&error];
        if (error==nil) {//表示转换正常
            [HEBasicHelper updateInformationWithArray:arr];
        }
    }];
    [manager setFailedBlock:^{
        
    }];
    [manager startAsynchronous];
}
- (void)asyncMetaVersion{
    ASIServiceArgs *args=[[ASIServiceArgs alloc] init];
    args.methodName=@"GetAppDataVersion";//GetAppData GetAppDataVersion
    NSLog(@"header=%@",args.headers);
    NSLog(@"body=%@",args.bodyMessage);
    ASIHTTPRequest *manager=[args request];
    __block ASIHTTPRequest *request = manager;
    [manager setCompletionBlock:^{
        NSLog(@"xml=%@",request.responseString);
        
        NSString *version=request.responseString;
        NSString *oldVersion=[UCSUserDefaultManager GetLocalDataString:kMetaVersion];
        if (![version isEqualToString:oldVersion]) {
            [UCSUserDefaultManager SetLocalDataString:version key:kMetaVersion];
            [self backgroundFetchData];//更新数据
        }
    }];
    [manager setFailedBlock:^{
         NSLog(@"error=%@",request.error.description);
    }];
    [manager startAsynchronous];
}
- (void)updateCheckMeta{
    ASIServiceArgs *args=[[ASIServiceArgs alloc] init];
    args.methodName=@"GetAppDataVersion";
    ASIHTTPRequest *manager=[args request];
     __block ASIHTTPRequest *request = manager;
    [manager setCompletionBlock:^{
        NSString *version=request.responseString;
        NSString *oldVersion=[UCSUserDefaultManager GetLocalDataString:kMetaVersion];
        int total=[HEBasicHelper getMetaDataCount];
        if (![version isEqualToString:oldVersion]||total==0) {
            [UCSUserDefaultManager SetLocalDataString:version key:kMetaVersion];
            [self backgroundFetchData];//更新数据
        }else if (![UCSUserDefaultManager GetLocalDataBoolen:kUpdateMetaSuccess])
        {
            [self backgroundFetchData];//更新数据
        }
    }];
    [manager setFailedBlock:^{
        NSLog(@"error=%@",request.error.description);
    }];
    [manager startAsynchronous];
}
@end
