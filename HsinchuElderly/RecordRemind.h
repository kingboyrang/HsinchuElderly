//
//  RecordRemind.h
//  HsinchuElderly
//
//  Created by aJia on 2014/6/18.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordRemind : NSObject
@property (nonatomic,copy) NSString *ID;//記錄ID
@property (nonatomic,copy) NSString *Name;//姓名
@property (nonatomic,copy) NSString *TimeSpan;//時間
@property (nonatomic,copy) NSString *RecordDate;//記錄時間
@property (nonatomic,copy) NSString *DetailValue1;//詳情1
@property (nonatomic,copy) NSString *DetailValue2;//詳情2
@property (nonatomic,readonly) NSString *Description;//Type=1或者3時
@property (nonatomic,copy) NSString *Type;//1:藥物 2:血壓 3:血糖
@end
