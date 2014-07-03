//
//  RecordTopView.h
//  HsinchuElderly
//
//  Created by aJia on 2014/6/13.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RecordTopViewDelegate <NSObject>
- (void)selectedButton:(UIButton*)btn type:(NSInteger)type;
@end

@interface RecordTopView : UIView{
    NSInteger _prevTag;
}
//@property (nonatomic,strong) UIButton *drugButton;//用藥
@property (nonatomic,strong) UIButton *bloodButton;//血壓
@property (nonatomic,strong) UIButton *bloodSugarButton;//血糖
@property (nonatomic,assign) NSInteger selectedIndex;//选中的值
@property (nonatomic,assign) id<RecordTopViewDelegate> delegate;
@end
