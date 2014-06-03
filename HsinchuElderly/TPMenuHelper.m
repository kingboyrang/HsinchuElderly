//
//  TPMenuHelper.m
//  HsinchuElderly
//
//  Created by aJia on 2014/5/10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "TPMenuHelper.h"

@implementation TPMenuHelper
- (void)showMenuWithTitle:(NSString*)title frame:(CGRect)frame{
    UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:frame];
    poplistview.delegate = self;
    poplistview.datasource = self;
    poplistview.listView.scrollEnabled = YES;
    [poplistview setTitle:title];
    [poplistview show];
    [poplistview reloadSource];
    
}
- (void)reloadSourceWithArray:(NSArray*)source{
    NSMutableArray *arr=[NSMutableArray array];
    if (source&&[self.sources count]>0) {
        [arr addObjectsFromArray:source];
    }
    self.sources=arr;
    //[];
}
#pragma mark - UIPopoverListViewDataSource

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:identifier];
    
    int row = indexPath.row;
    NSDictionary *item=self.sources[row];
    cell.textLabel.font=default18DeviceFont;
    cell.textLabel.text = [item objectForKey:self.bindKey];
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return [self.sources count];
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s : %d", __func__, indexPath.row);
    if (self.delegate&&[self.delegate respondsToSelector:@selector(chooseMenuItem:index:)]) {
        [self.delegate chooseMenuItem:self.sources[indexPath.row] index:self.operType];
    }
    // your code here
}
- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

@end
