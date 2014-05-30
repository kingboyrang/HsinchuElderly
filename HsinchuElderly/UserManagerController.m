//
//  UserManagerController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/9.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "UserManagerController.h"
#import "UserInfoViewController.h"
#import "UIBarButtonItem+TPCategory.h"
#import "UIButton+TPCategory.h"
#import "AlertHelper.h"
@interface UserManagerController ()

@end

@implementation UserManagerController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"基本資料列表";
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonWithTitle:@"新增" target:self action:@selector(buttonAddClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.userHelper=[[SystemUserHelper alloc] init];
    
    CGRect r=self.view.bounds;
    r.size.height-=[self topHeight];
    _userTable=[[UITableView alloc] initWithFrame:r style:UITableViewStylePlain];
    _userTable.dataSource=self;
    _userTable.delegate=self;
    _userTable.backgroundColor=[UIColor clearColor];
    _userTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    _userTable.bounces=NO;
    [self.view addSubview:_userTable];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.userHelper loadDataSource];//重新載入數據
    self.list=[self.userHelper systemUsers];
    [_userTable reloadData];
}
- (void)buttonAddClick:(UIButton*)btn{
    UserInfoViewController *user=[[UserInfoViewController alloc] init];
    user.operType=1;
    [self.navigationController pushViewController:user animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//刪除功能
- (void)buttonDeleteClick:(UIButton*)btn{
    
    
    [AlertHelper initWithTitle:@"提示" message:@"確定刪除？" cancelTitle:@"取消" cancelAction:nil confirmTitle:@"確認" confirmAction:^{
        id v=[btn superview];
        while (![v isKindOfClass:[UITableViewCell class]]) {
            v=[v superview];
        }
        UITableViewCell *cell=(UITableViewCell*)v;
        NSIndexPath *indexPath=[self.userTable indexPathForCell:cell];
        SystemUser *entity=self.list[indexPath.row];
        
        if (![self.userHelper existsUserWithId:entity.ID]) {
            [AlertHelper initWithTitle:@"提示" message:@"帳號資料正在使用中，無法刪除！"];
            return;
        }

        [self.userHelper removeUserPhotoWithId:entity.ID];//删除頭像
        [self.list removeObjectAtIndex:indexPath.row];
        [self.userTable beginUpdates];
        [self.userTable deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
        [self.userTable endUpdates];
        [self.userHelper saveWithSources:self.list];
        [AlertHelper initWithTitle:@"提示" message:@"刪除成功！"];
    }];
}

#pragma mark UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"areaCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        UIImage *img=[UIImage imageNamed:@"cell_bg.png"];
        img=[img stretchableImageWithLeftCapWidth:img.size.width*0.5f topCapHeight:img.size.height*0.5f];
        //[img resizableImageWithCapInsets:UIEdgeInsetsMake(img.size.height*0.5f, img.size.width*0.5f, 0, 15) resizingMode:UIImageResizingModeStretch];
        CGRect r=cell.frame;
        r.size.width=DeviceWidth;
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:r];
        [imageView setImage:img];
        cell.backgroundView=imageView;
        
        UIButton *btn=[UIButton barButtonWithTitle:@"刪除" target:self action:@selector(buttonDeleteClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView=btn;
    }
    SystemUser *entity=self.list[indexPath.row];
    cell.textLabel.text=entity.Name;
    cell.textLabel.textColor=[UIColor colorFromHexRGB:@"711200"];
    cell.textLabel.font=defaultBDeviceFont;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UserInfoViewController *user=[[UserInfoViewController alloc] init];
    user.operType=2;
    user.Entity=self.list[indexPath.row];
    [self.navigationController pushViewController:user animated:YES];
}
@end
