//
//  UserInfoViewController.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/8.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumCameraImage.h"
#import "SystemUser.h"
@interface UserInfoViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate,AlbumCameraDelegate,UITextFieldDelegate>
@property (nonatomic,strong) AlbumCameraImage *albumCamera;
@property (nonatomic,strong) UITableView *userTable;
@property (nonatomic,strong) NSMutableArray *cells;
@property (nonatomic,strong) SystemUser *Entity;
@property (nonatomic,assign) NSInteger operType;//1:表示新增 2:表示修改
@end
