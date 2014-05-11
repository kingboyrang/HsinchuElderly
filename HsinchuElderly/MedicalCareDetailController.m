//
//  MedicalCareDetailController.m
//  HsinchuElderly
//
//  Created by rang on 14-5-11.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "MedicalCareDetailController.h"
#import "TKLabelLabelCell.h"
@interface MedicalCareDetailController ()

@end

@implementation MedicalCareDetailController

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
    CGRect r=self.view.bounds;
    r.size.height-=[self topHeight];
    _detailTable=[[UITableView alloc] initWithFrame:r style:UITableViewStyleGrouped];
    _detailTable.delegate=self;
    _detailTable.dataSource=self;
    _detailTable.backgroundColor=[UIColor clearColor];
    _detailTable.bounces=NO;
    [self.view addSubview:_detailTable];
    
    TKLabelLabelCell *cell1=[[TKLabelLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell1.labName.text=@"名稱:";
    cell1.labDetail.text=self.Entity.Name;
    
    TKLabelLabelCell *cell2=[[TKLabelLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell2.labName.text=@"電話:";
    cell2.labDetail.text=self.Entity.Tel;
    
    TKLabelLabelCell *cell3=[[TKLabelLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell3.labName.text=@"地址:";
    cell3.labDetail.text=self.Entity.Address;
    
    TKLabelLabelCell *cell4=[[TKLabelLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell4.labName.text=@"網址:";
    cell4.labDetail.text=@"";
    
    self.cells=[NSMutableArray arrayWithObjects:cell1,cell2,cell3,cell4, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.cells count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=self.cells[indexPath.row];
    if (indexPath.row==0) {
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }else{
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
#pragma mark -UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TKLabelLabelCell *cell=self.cells[indexPath.row];
    CGFloat w=self.view.bounds.size.width-5-72-10-2;
    CGSize size=[cell.labDetail.text textSize:defaultSDeviceFont withWidth:w];
    if (size.height+20>44.0f) {
        return size.height+20;
    }
    return 44.0;
}
@end
