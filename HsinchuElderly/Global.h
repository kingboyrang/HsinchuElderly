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

#define kMetaVersion                @"kMetaVersion"
#define kUpdateMetaSuccess          @"kUpdateMetaSuccess"
#define kNotificeUpdateMetaFinished @"kNotificeUpdateMetaFinished"

//Helvetica-Bold Courier-Bold
//介面顏色設定
#define defaultBFontSize  DeviceIsPad?19*1.5:19
#define defaultSFontSize  DeviceIsPad?16*1.5:16
#define default18FontSize  DeviceIsPad?18*1.5:18

#define defaultDeviceFontColorName @"e32600"
#define defaultDeviceFontName @"Helvetica-Bold"
#define defaultDeviceFontColor [UIColor colorFromHexRGB:defaultDeviceFontColorName]
#define defaultBDeviceFont [UIFont fontWithName:defaultDeviceFontName size:defaultBFontSize]
#define defaultSDeviceFont [UIFont fontWithName:defaultDeviceFontName size:defaultSFontSize]
#define default18DeviceFont [UIFont fontWithName:defaultDeviceFontName size:default18FontSize]

//資料庫設置路徑
//#define HEDBPath [[NSBundle mainBundle] pathForResource:@"HsinchuElderly" ofType:@"sqlite"]
#define HEDBPath [DocumentPath stringByAppendingPathComponent:@"remind.sqlite"]

//图片上传
//http://60.251.51.217/Hchg_Elderly/WebService.asmx
#define DataWebserviceURL @"https://data.hsinchu.gov.tw/hchgopendataadmin/webservice.asmx"
#define DataWeserviceNameSpace @"http://tempuri.org/"

#define PushBloodSugarMessage @"親愛的%@,該量血糖囉!"
#define PushBloodMessage @"親愛的%@,該量血壓囉!"
#define PushDrugMessage @"親愛的%@,該吃藥囉!"

#define SugarSource [NSArray arrayWithObjects:@"早餐前血糖",@"早餐後血糖",@"午餐前血糖",@"午餐後血糖",@"晚餐前血糖",@"晚餐後血糖", nil]




