//
//  RecordBloodSugarView.h
//  HsinchuElderly
//
//  Created by aJia on 2014/7/3.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordBloodSugarView : UIView<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UILabel *labSugar;
@property (weak, nonatomic) IBOutlet UITextField *sugarField;
@property (weak, nonatomic) IBOutlet UIPickerView *timePicker;
@property (nonatomic,readonly) NSString *bloodValue;//測量時間點
@property (nonatomic,readonly) BOOL hasValue;

- (void)defaultInitControl;
//设置选中值
- (void)setSelectedValue:(NSString*)val;
@end
