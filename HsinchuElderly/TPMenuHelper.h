//
//  TPMenuHelper.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIPopoverListView.h"

@protocol TPMenuHelperDelegate <NSObject>
- (void)chooseMenuItem:(id)item index:(NSInteger)index;
@end

@interface TPMenuHelper : NSObject<UIPopoverListViewDataSource, UIPopoverListViewDelegate>
@property (nonatomic,strong) NSMutableArray *sources;
@property (nonatomic,copy) NSString *bindKey;
@property (nonatomic,copy) NSString *bindValue;
@property (nonatomic,assign) NSInteger operType;
@property (nonatomic,assign) id<TPMenuHelperDelegate> delegate;
- (void)showMenuWithTitle:(NSString*)title frame:(CGRect)frame;
- (void)reloadSourceWithArray:(NSArray*)source;
@end
