//
//  PaoPaoView.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/13.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "PaoPaoView.h"
#import "TKEmptyCell.h"
#import "TKLabelCell.h"
#import "TKLabelLabelCell.h"
#import "BasicModel.h"
#import "TKLineCell.h"
#import "SVPlacemark.h"
@interface PaoPaoView ()
- (CGFloat)getTableHeight;
- (void)relayout;
@end

@implementation PaoPaoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect r=self.bounds;
        r.origin.y=5;
        self.userTable=[[UITableView alloc] initWithFrame:r style:UITableViewStylePlain];
        self.userTable.dataSource=self;
        self.userTable.delegate=self;
        self.userTable.bounces=NO;
        self.userTable.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self addSubview:self.userTable];
        
        TKLineCell *cell1=[[TKLineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell1.textLabel.numberOfLines=0;
        cell1.textLabel.lineBreakMode=NSLineBreakByWordWrapping;
        TKLabelLabelCell *cell2=[[TKLabelLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell2.labName.text=@"地址:";
        TKLabelLabelCell *cell3=[[TKLabelLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell3.labName.text=@"電話:";
        TKEmptyCell *cell4=[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell4.detailTextLabel.textColor=defaultDeviceFontColor;
        cell4.detailTextLabel.font=defaultSDeviceFont;
        cell4.detailTextLabel.text=@"導航";
        self.cells=[NSMutableArray arrayWithObjects:cell1,cell2,cell3,cell4, nil];
    }
    return self;
}
- (CGFloat)getTableHeight{
    CGFloat total=0;
    for (int i=0; i<self.cells.count; i++) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:i inSection:0];
        total+=[self tableView:self.userTable heightForRowAtIndexPath:indexPath];
    }
    return total;
}
- (void)relayout{
    CGRect r=self.userTable.frame;
    r.size.height=[self getTableHeight];
    self.userTable.frame=r;
    
    r=self.frame;
    r.size.height=self.userTable.frame.origin.y+self.userTable.frame.size.height;
    self.frame=r;
}
- (void)setViewDataSource:(BasicModel*)entity{
    self.Entity=entity;
    TKEmptyCell *cell1=self.cells[0];
    cell1.textLabel.text=entity.Name;
    TKLabelLabelCell *cell2=self.cells[1];
    cell2.labDetail.text=entity.Address;
    TKLabelLabelCell *cell3=self.cells[2];
    cell3.labDetail.text=entity.Tel;
    
    [self.userTable reloadData];//重新載入數據
    
    [self relayout];//重新Layout
    
}
#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.cells count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=self.cells[indexPath.row];
    if (indexPath.row==self.cells.count-1) {
        UIImage *rightImg=[UIImage imageNamed:@"arrow_right.png"];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, 0, rightImg.size.width, rightImg.size.height);
        [btn setBackgroundImage:rightImg forState:UIControlStateNormal];
        cell.accessoryView=btn;
    }else{
       cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return cell;
}
#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     //http://maps.apple.com/?q=Ray%27s%20Pizza&ll=32.715000,-117.162500
    //http://maps.google.com/maps?daddr=Lat,Lng
    
    NSString *latlng=[NSString stringWithFormat:@"%f,%f",self.Entity.placemark.coordinate.latitude,self.Entity.placemark.coordinate.longitude];
    NSString *skipURL=[NSString stringWithFormat:@"http://maps.apple.com/?q=%@&ll=%@",self.Entity.placemark.formattedAddress,latlng];
    
    
    NSString * encodedString=(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                   (CFStringRef)skipURL,
                                                                                                   NULL,
                                                                                                   NULL,
                                                                                                   kCFStringEncodingUTF8));
    NSURL *url=[NSURL URLWithString:encodedString];
    //[[UIApplication sharedApplication] openURL:url];//使用瀏覽器打開
    
    //if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]){
    if ([[UIApplication sharedApplication] canOpenURL:url]){
        //NSURL *url=[NSURL URLWithString:encodedString];
        [[UIApplication sharedApplication] openURL:url];//使用瀏覽器打開
    }else{
       NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.google.com/maps?daddr=%f,%f",self.Entity.placemark.coordinate.latitude, self.Entity.placemark.coordinate.longitude]];
        [[UIApplication sharedApplication] openURL:url];//使用瀏覽器打開
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.cells[indexPath.row] isKindOfClass:[TKLabelLabelCell class]]) {
        TKLabelLabelCell *cell=self.cells[indexPath.row];
        CGFloat w=240-cell.labName.frame.size.width-cell.labName.frame.origin.x-2-5;
        CGSize size=[cell.labDetail.text textSize:defaultSDeviceFont withWidth:w];
        if (size.height+20>44.0f) {
            return size.height+20;
        }
    }
    return 44.0f;
}
@end
