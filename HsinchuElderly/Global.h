//
//  Global.h
//  Eland
//
//  Created by aJia on 13/9/27.
//  Copyright (c) 2013年 rang. All rights reserved.
//

//获取设备的物理大小
#define IOSVersion [[UIDevice currentDevice].systemVersion floatValue]
#define DeviceRect [UIScreen mainScreen].bounds
#define DeviceWidth [UIScreen mainScreen].bounds.size.width
#define DeviceHeight [UIScreen mainScreen].bounds.size.height
#define StatusBarHeight 20 //状态栏高度
#define TabHeight 59 //工具栏高度
#define DeviceRealHeight DeviceHeight-20
#define DeviceRealRect CGRectMake(0, 0, DeviceWidth, DeviceRealHeight)
//路径设置
#define DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define TempPath NSTemporaryDirectory()
//设备
#define DeviceIsPad UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad

//界面颜色设置
#define defaultDeviceFontColorName @"e32600"
#define defaultDeviceFontName @"Courier-Bold"
#define defaultDeviceFontColor [UIColor colorFromHexRGB:defaultDeviceFontColorName]
#define defaultBDeviceFont [UIFont fontWithName:defaultDeviceFontName size:16]
#define defaultSDeviceFont [UIFont fontWithName:defaultDeviceFontName size:14]

//数据库配置路径
#define HEDBPath [DocumentPath stringByAppendingPathComponent:@"HsinchuElderly.sqlite"]




