//
//  UserInfoViewController.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/8.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UIButton+TPCategory.h"
#import "TKPhotoCell.h"
#import "TKLabelFieldCell.h"
#import "TKLabelSegmentCell.h"
#import "UIBarButtonItem+TPCategory.h"
#import "AlertHelper.h"
#import "SystemUserHelper.h"
#import "NSDate+TPCategory.h"
#import "FileHelper.h"
@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

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
    self.title=@"基本資料";
    
    self.albumCamera=[[AlbumCameraImage alloc] init];
    self.albumCamera.delegate=self;
    
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonWithTitle:@"完成" target:self action:@selector(buttonSubmitClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect r=self.view.bounds;
    r.size.height-=[self topHeight];
    _userTable=[[UITableView alloc] initWithFrame:r style:UITableViewStylePlain];
    _userTable.dataSource=self;
    _userTable.delegate=self;
    _userTable.backgroundColor=[UIColor clearColor];
    _userTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    _userTable.bounces=NO;
    [self.view addSubview:_userTable];
    
    TKPhotoCell *cell1=[[TKPhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell1.albumBtn addTarget:self action:@selector(buttonAlbumClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell1.cameraBtn addTarget:self action:@selector(buttonCameraClick:) forControlEvents:UIControlEventTouchUpInside];
    
    TKLabelFieldCell *cell2=[[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell2.label.text=@"姓名:";
    cell2.field.placeholder=@"請輸入姓名";
    cell2.field.delegate=self;

    
    TKLabelSegmentCell *cell3=[[TKLabelSegmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell3.label.text=@"性別:";
    [cell3.segmented setTitle:@"男" withIndex:0];
    [cell3.segmented setTitle:@"女" withIndex:1];
    
    if (self.operType==2) {//修改时复值
        if (self.Entity.PhotoURL&&[self.Entity.PhotoURL length]>0&&[FileHelper existsFilePath:self.Entity.PhotoURL]) {
          [cell1 setPhotoWithImage:[UIImage imageWithContentsOfFile:self.Entity.PhotoURL]];
          cell1.hasImage=NO;
        }
        cell2.field.text=self.Entity.Name;
        [cell3.segmented setSelectedSegmentIndex:self.Entity.Sex];
    }
    
    self.cells=[NSMutableArray arrayWithObjects:cell1,cell2,cell3, nil];
    if (self.operType==2) {
        [self.userTable reloadData];
        //NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        //[self.userTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(done:)];
    tapGestureRecognizer.numberOfTapsRequired =1;
    tapGestureRecognizer.cancelsTouchesInView =NO;
    [self.userTable addGestureRecognizer:tapGestureRecognizer];  //只需要点击非文字输入区域就会响应hideKeyBoard
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboardWillShowHideNotification:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
}
-(void)done:(id)sender
{
    
    for (id v in self.cells) {
        if ([v isKindOfClass:[TKLabelFieldCell class]]) {
            TKLabelFieldCell *cell=(TKLabelFieldCell*)v;
            if (cell.field.isFirstResponder) {
                [cell.field resignFirstResponder];
                break;
            }
        }
    }
}
#pragma mark - Notifications
- (void)handleKeyboardWillShowHideNotification:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    //取得键盘的大小
    //CGRect kbFrame = [[info valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if ([notification.name isEqualToString:UIKeyboardDidHideNotification]) {//隐藏键盘
        
        NSTimeInterval animationDuration = [[info valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        [UIView animateWithDuration:animationDuration animations:^{
             self.userTable.contentInset=UIEdgeInsetsZero;
        }];
    }
}
//相册
- (void)buttonAlbumClick:(UIButton*)btn{
    [self.albumCamera showAlbumInController:self];
}
//照相
- (void)buttonCameraClick:(UIButton*)btn{
    [self.albumCamera showCameraInController:self];
}
//完成
- (void)buttonSubmitClick:(UIButton*)btn{
    TKPhotoCell *cell1=self.cells[0];
    /**
    if (self.operType==1&&!cell1.hasImage) {
        [AlertHelper initWithTitle:@"提示" message:@"請選擇頭像!"];
        return;
    }
     ***/
    TKLabelFieldCell *cell2=self.cells[1];
    if (!cell2.hasValue) {
        [AlertHelper initWithTitle:@"提示" message:@"請輸入姓名!"];
        return;
    }
    if (self.operType==1) {//新增
        self.Entity=[[SystemUser alloc] init];
        self.Entity.ID=[NSString createGUID];
        self.Entity.CreateDate=[NSDate stringFromDate:[NSDate date] withFormat:@"yyyy/MM/dd HH:mm:ss"];
    }
    TKLabelSegmentCell *cell3=self.cells[2];
    self.Entity.Name=cell2.field.text;
    self.Entity.Sex=cell3.segmented.selectedIndex;
    SystemUserHelper *_helper=[[SystemUserHelper alloc] init];
    NSString *memo=self.operType==1?@"新增":@"修改";
    [self showLoadingAnimatedWithTitle:[NSString stringWithFormat:@"正在%@...",memo]];
    [_helper addEditUserWithModel:self.Entity headImage:cell1.hasImage?cell1.photoImage.image:nil];
    [self hideLoadingSuccessWithTitle:[NSString stringWithFormat:@"%@成功!",memo] completed:^(AnimateErrorView *successView) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITextFieldDelegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(strlen([textField.text UTF8String]) >= 20 && range.length != 1)
        return NO;
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    id v=[textField superview];
    while (![v isKindOfClass:[UITableViewCell class]]) {
        v=[v superview];
    }
    UITableViewCell *cell=(UITableViewCell*)v;
    NSIndexPath *indexPath=[self.userTable indexPathForCell:cell];
    CGRect r=[self.userTable rectForRowAtIndexPath:indexPath];
    r.origin.y+=textField.frame.origin.y*2+textField.frame.size.height;
    
    
    CGFloat h=r.origin.y+216+10;
    if (h>self.userTable.frame.size.height&&h<self.userTable.contentSize.height) {
        [self.userTable setContentOffset:CGPointMake(0,h-self.userTable.frame.size.height) animated:YES];
    }
    if (h>self.userTable.contentSize.height) {
        int offset=r.origin.y-(self.userTable.frame.size.height-216);
        if (offset>0) {
            [UIView animateWithDuration:0.3f animations:^{
                self.userTable.contentInset=UIEdgeInsetsMake(-offset, 0, 0, 0);
            }];
            
        }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark AlbumCameraDelegate Methods
- (void)photoFromAlbumCameraWithImage:(UIImage*)image{
    TKPhotoCell *cell=self.cells[0];
    NSIndexPath *indexPath=[self.userTable indexPathForCell:cell];
    [cell setPhotoWithImage:image];
    [self.userTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.cells count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=self.cells[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
#pragma mark UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.cells[indexPath.row] isKindOfClass:[TKPhotoCell class]]) {
        return DeviceIsPad?327:193;
    }
    return 44.0;
}
@end
