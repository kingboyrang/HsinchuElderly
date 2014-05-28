//
//  Global.h
//  Eland
//
//  Created by aJia on 13/9/27.
//  Copyright (c) 2013年 rang. All rights reserved.
//

//取得Device的物理大小
#define IOSVersion [[UIDevice currentDevice].systemVersion floatValue]
#define DeviceRect [UIScreen mainScreen].bounds
#define DeviceWidth [UIScreen mainScreen].bounds.size.width
#define DeviceHeight [UIScreen mainScreen].bounds.size.height
#define StatusBarHeight 20 //狀態欄高度
#define TabHeight 59 //工具欄高度
#define DeviceRealHeight DeviceHeight-20
#define DeviceRealRect CGRectMake(0, 0, DeviceWidth, DeviceRealHeight)
//路徑設定
#define DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define TempPath NSTemporaryDirectory()
//Device
#define DeviceIsPad UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad

//介面顏色設定
#define defaultDeviceFontColorName @"e32600"
#define defaultDeviceFontName @"Courier-Bold"
#define defaultDeviceFontColor [UIColor colorFromHexRGB:defaultDeviceFontColorName]
#define defaultBDeviceFont [UIFont fontWithName:defaultDeviceFontName size:16]
#define defaultSDeviceFont [UIFont fontWithName:defaultDeviceFontName size:14]

//資料庫設置路徑
//#define HEDBPath [[NSBundle mainBundle] pathForResource:@"HsinchuElderly" ofType:@"sqlite"]
#define HEDBPath [DocumentPath stringByAppendingPathComponent:@"remind.sqlite"]

//图片上传
//http://60.251.51.217/Hchg_Elderly/WebService.asmx
//#define DataWebserviceURL @"http://192.168.123.150:8080/WebService.asmx"
#define DataWebserviceURL @"http://60.251.51.217/Hchg_Elderly/WebService.asmx"
#define DataWeserviceNameSpace @"http://tempuri.org/"

#define PushBloodSugarMessage @"親愛的%@,該量血糖囉!"
#define PushBloodMessage @"親愛的%@,該量血壓囉!"
#define PushDrugMessage @"親愛的%@,該吃藥囉!"




