//
//  MedicalCareDetailController.m
//  HsinchuElderly
//
//  Created by rang on 14-5-11.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "HEItemDetailController.h"
#import "TKLabelLabelCell.h"
#import "ActionSheetHelper.h"
#import "RIButtonItem.h"
#import "ShowMapController.h"
#import "ShowMapController.h"
#import "AlertHelper.h"
#import "TKDetailDataCell.h"
@interface HEItemDetailController ()

@end

@implementation HEItemDetailController

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
    
    self.webView=[[UIWebView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.webView];
    
    _detailTable=[[UITableView alloc] initWithFrame:r style:UITableViewStylePlain];
    _detailTable.delegate=self;
    _detailTable.dataSource=self;
    _detailTable.backgroundColor=[UIColor clearColor];
    _detailTable.bounces=NO;
    _detailTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_detailTable];
    
    self.cells=[self getTableSource];
    [_detailTable reloadData];
    
    
}
- (NSMutableArray*)getTableSource{
  
    
    TKDetailDataCell *cell1=[[TKDetailDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell1.labName.text=@"名稱：";
    cell1.labDetail.text=self.Entity.Name;
    
    TKDetailDataCell *cell2=[[TKDetailDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell2.labName.text=@"電話：";
    cell2.labDetail.text=self.Entity.Tel;
    
    TKDetailDataCell *cell3=[[TKDetailDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell3.labName.text=@"地址：";
    cell3.labDetail.text=self.Entity.Address;
    
    NSMutableArray *source=[NSMutableArray arrayWithObjects:cell1,cell2,cell3, nil];
    
    if(self.Entity.WebSiteURL&&[self.Entity.WebSiteURL length]>0){
        TKDetailDataCell *cell4=[[TKDetailDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell4.labName.text=@"網址：";
        cell4.labDetail.text=self.Entity.WebSiteURL;
        [source addObject:cell4];
    }
    //詳細資訊網址
    if (self.Entity.Detial&&[self.Entity.Detial length]>0) {
        TKDetailDataCell *cell5=[[TKDetailDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell5.labName.text=@"詳細資訊網址：";
        cell5.labDetail.text=self.Entity.Detial;
        [source addObject:cell5];
    }
    //掛號網址
    if (self.Entity.Register&&[self.Entity.Register length]>0) {
        TKDetailDataCell *cell6=[[TKDetailDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell6.labName.text=@"掛號網址：";
        cell6.labDetail.text=self.Entity.Register;
        [source addObject:cell6];
    }
    return source;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)callTelWithNumber:(NSString*)tel{
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",tel]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}
#pragma mark -UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.cells count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=self.cells[indexPath.row];
    cell.backgroundColor=[UIColor colorFromHexRGB:@"fef59d"];
    if (indexPath.row==0) {
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }else{
        if (indexPath.row==1) {
            if (!DeviceIsPad) {
                UIImage *rightImg=[UIImage imageNamed:@"arrow_right.png"];
                UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame=CGRectMake(0, 0, rightImg.size.width, rightImg.size.height);
                [btn setBackgroundImage:rightImg forState:UIControlStateNormal];
                cell.accessoryView=btn;
            }
        }else{
            UIImage *rightImg=[UIImage imageNamed:@"arrow_right.png"];
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(0, 0, rightImg.size.width, rightImg.size.height);
            [btn setBackgroundImage:rightImg forState:UIControlStateNormal];
            cell.accessoryView=btn;
        }
       
    }
    return cell;
}
#pragma mark -UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==1&&self.Entity.Tel&&[self.Entity.Tel length]>0) {//電話
         NSArray *arrs=[self.Entity.Tel componentsSeparatedByString:@","];
        if (arrs.count==1) {
            [self callTelWithNumber:self.Entity.Tel];
        }else{
            NSMutableArray *actions=[NSMutableArray arrayWithCapacity:arrs.count];
            for (NSString *tel in arrs) {
                RIButtonItem *item=[RIButtonItem item];
                item.label=[NSString stringWithFormat:@"%@ 撥打",tel];
                item.action=^(){
                    [self callTelWithNumber:tel];
                };
                [actions addObject:item];
            }
            [ActionSheetHelper showSheetInView:self.view actions:actions];
        }
    }
    if (indexPath.row==2) {//地址
        ShowMapController *map=[[ShowMapController alloc] init];
        map.Entity=self.Entity;
        [self.navigationController pushViewController:map animated:YES];
    }
    if (indexPath.row>=3) {//網址
        TKDetailDataCell *cell1=self.cells[indexPath.row];
        NSString * encodedString=(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                       (CFStringRef)[cell1.labDetail.text Trim],
                                                                                                       NULL,
                                                                                                       NULL,
                                                                                                       kCFStringEncodingUTF8));
        NSURL *url=[NSURL URLWithString:encodedString];
        [[UIApplication sharedApplication] openURL:url];//使用瀏覽器打開
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TKDetailDataCell *cell=self.cells[indexPath.row];
    CGSize size1=[cell.labName.text textSize:cell.labName.font withWidth:self.view.bounds.size.width];
    CGFloat w=self.view.bounds.size.width-18-(size1.width+2+10);
    CGSize size=[cell.labDetail.text textSize:default18DeviceFont withWidth:w];
    if (size.height+20>44.0f) {
        return size.height+20;
    }
    return 44.0;
}
@end
