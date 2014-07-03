//
//  ShrinkPickerView.h
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShrinkPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;


@property (nonatomic,readonly) NSString *shrinkValue;//收縮值
@property (nonatomic,readonly) NSString *diastolicValue;//舒张值
@property (nonatomic,readonly) NSString *pulseValue;//脉搏值

@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
- (void)defaultSelectedPicker;
//设置选中值
- (void)setSelectedValue:(NSString*)val component:(NSInteger)row;
@end
