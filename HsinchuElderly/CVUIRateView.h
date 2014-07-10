//
//  CVUIRateView.h
//  HsinchuElderly
//
//  Created by aJia on 2014/7/10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CVUIPopoverView.h"
#import "CVUIPopoverText.h"

@protocol CVUIRateViewDelegate <NSObject>
@optional
-(void)doneChooseItem:(id)sender;
-(void)closeSelect:(id)sender;
-(void)showPopoverSelect:(id)sender;
@end

@interface CVUIRateView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong) NSArray *pickerData;
@property(nonatomic,retain) NSDictionary *itemData;
@property(nonatomic,retain) UIPickerView *picker;
@property(nonatomic,retain) CVUIPopoverView *popView;
@property(nonatomic,retain) CVUIPopoverText *popText;
@property(nonatomic,readonly) NSString *key;
@property(nonatomic,readonly) NSString *value;
@property(nonatomic,readonly) NSInteger rateCount;//取得频率次数
@property(nonatomic,assign) BOOL isChange;//前一次與目前選中項目是否發生改變

@property(nonatomic,copy) NSString *bindName;//绑定的key字串
@property(nonatomic,copy) NSString *bindValue;//绑定的value字串
@property(nonatomic,assign) id<CVUIRateViewDelegate> delegate;

- (void)show;
//設置第幾項被選中
-(void)findBindName:(NSString*)search;
-(void)findBindValue:(NSString*)search;
-(void)setIndex:(NSInteger)i;
-(void)setSelectedValue:(NSString*)value component:(NSInteger)comp;
//設定資料來源
-(void)setDataSourceForArray:(NSArray*)source;
-(void)setDataSourceForArray:(NSArray*)source dataTextName:(NSString*)textName dataValueName:(NSString*)valueName;
-(void)setDataSourceForDictionary:(NSDictionary*)source;
-(void)setDataSourceForDictionary:(NSDictionary*)source dataTextName:(NSString*)textName dataValueName:(NSString*)valueName;


@end
