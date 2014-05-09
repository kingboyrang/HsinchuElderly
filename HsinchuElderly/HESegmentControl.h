//
//  HESegmentControl.h
//  HsinchuElderly
//
//  Created by aJia on 2014/5/9.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HESegmentControl : UIView
@property (nonatomic,assign) NSInteger selectedIndex;
- (void)insertSegmentWithTitle:(NSString*)title withIndex:(NSInteger)index;
- (void)setTitle:(NSString*)title withIndex:(NSInteger)index;
- (void)setSelectedSegmentIndex:(NSInteger)index;
@end
