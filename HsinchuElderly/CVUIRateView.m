//
//  CVUIRateView.m
//  HsinchuElderly
//
//  Created by aJia on 2014/7/10.
//  Copyright (c) 2014年 lz. All rights reserved.
//

#import "CVUIRateView.h"

@implementation CVUIRateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //增加text
        _popText=[[CVUIPopoverText alloc] initWithFrame:frame];
        [_popText.button addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_popText];
        
        CGFloat w=[[UIScreen mainScreen] bounds].size.width;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            w=320;
        }
        
        _picker= [[UIPickerView alloc] initWithFrame:CGRectMake(0,0,w, 216)];
        _picker.delegate = self;
        _picker.dataSource = self;
        _picker.showsSelectionIndicator = YES;
        _picker.backgroundColor=[UIColor clearColor];
        //[(UIView*)[[self.picker subviews] objectAtIndex:0] setAlpha:0.0f];
        //[(UIView*)[[self.picker subviews] objectAtIndex:1] setAlpha:0.0f];
        //[(UIView*)[[self.picker subviews] objectAtIndex:3] setAlpha:0.0f];
        //初始化彈跳框
        _popView=[[CVUIPopoverView alloc] initWithFrame:CGRectMake(0, 0, w, 44)];
        UIBarButtonItem *leftButton=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(buttonCancelClick)];
        UIBarButtonItem *midleButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem *fixButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *clearButton=[[UIBarButtonItem alloc] initWithTitle:@"清除" style:UIBarButtonItemStylePlain target:self action:@selector(buttonClearClick)];
        UIBarButtonItem *rightButton=[[UIBarButtonItem alloc] initWithTitle:@"確定" style:UIBarButtonItemStylePlain target:self action:@selector(buttonDoneClick)];
        [_popView.toolBar setItems:[NSArray arrayWithObjects:leftButton,midleButton,fixButton,clearButton,rightButton, nil]];
        [leftButton release];
        [rightButton release];
        [midleButton release];
        [fixButton release];
        [clearButton release];
        [_popView addChildView:_picker];
    }
    return self;
}
//顯示事件
- (void)show{
    [_popView show:self];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(showPopoverSelect:)]) {
        [self.delegate showPopoverSelect:self];
    }
}
//確定事件
-(void)buttonDoneClick{
    NSInteger row=[self.picker selectedRowInComponent:0];
    NSDictionary *dic=[self.pickerData objectAtIndex:row];
    if (!self.itemData){
        self.isChange=YES;
    }else{
        if ([self.pickerData indexOfObject:self.itemData]==[self.pickerData indexOfObject:dic]) {
            self.isChange=NO;
        }else{
            self.isChange=YES;
        }
    }
    self.itemData=dic;
    _popText.field.text=[NSString stringWithFormat:@"%@ %d次",[self key],[self.picker selectedRowInComponent:1]+1];
    [self buttonCancelClick];
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(doneChooseItem:)]) {
        [self.delegate doneChooseItem:self];
    }
}
//清空事件
-(void)buttonClearClick{
    _popText.field.text=@"";
    self.itemData=nil;
    _popText.field.text=@"";
    [self.picker selectRow:0 inComponent:1 animated:NO];
    [self buttonCancelClick];
}
//取消事件
-(void)buttonCancelClick{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(closeSelect:)]) {
        [self.delegate closeSelect:self];
    }
    [_popView hide];
}
#pragma mark -
#pragma mark 屬性重寫
-(void)setPickerData:(NSArray *)data{
    if (_pickerData!=data) {
        [_pickerData release];
        _pickerData=[data retain];
    }
    if (!self.bindName) {
        self.bindName=@"key";
    }
    if (!self.bindValue) {
        self.bindName=@"value";
    }
    self.picker.userInteractionEnabled=YES;//以防萬一
    [self unBindSource];
}
-(NSInteger)rateCount{
   return  [self.picker selectedRowInComponent:1]+1;
}
-(NSString*)key{
    if ([self.itemData count]>0&&[self.bindName length]>0&&[self.itemData objectForKey:self.bindName]!=nil) {
        return [self.itemData objectForKey:self.bindName];
    }
    return @"";
}
-(NSString*)value{
    if ([self.itemData count]>0&&[self.bindValue length]>0&&[self.itemData objectForKey:self.bindValue]!=nil) {
        return [self.itemData objectForKey:self.bindValue];
    }
    return @"";
}
- (void) layoutSubviews{
    [super layoutSubviews];
    _popText.frame=self.bounds;
}
#pragma mark -
#pragma mark UIPickerView DataSource Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pv numberOfRowsInComponent:(NSInteger)component
{
    if (component==0) {
        if ([self.pickerData count]==0) {
            self.picker.userInteractionEnabled=NO;
        }
        return [self.pickerData count];
    }
    return 5;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    
    UILabel *myView = nil;
    
    if (component == 0) {
        NSDictionary *dic=[self.pickerData objectAtIndex:row];
        NSString *val=[dic objectForKey:self.bindName];
        if ([self.bindName length]==0) {
            val=@"";
        }
        myView = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.bounds.size.width/2, 40)] autorelease];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.text = val;
        
        myView.font = defaultBDeviceFont;         //用label来设置字体大小
        
        myView.backgroundColor = [UIColor clearColor];
        
    }else {
        
        myView = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.bounds.size.width/2, 40)] autorelease];
        
        myView.text = [NSString stringWithFormat:@"%d次",row+1];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.font = defaultBDeviceFont;
        
        myView.backgroundColor = [UIColor clearColor];
        
    }
    
    return myView;
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
}

#pragma mark Picker Delegate Methods
/***
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==0) {
        NSDictionary *dic=[self.pickerData objectAtIndex:row];
        if ([self.bindName length]==0) {
            return @"";
        }
        return [dic objectForKey:self.bindName];
    }
    return [NSString stringWithFormat:@"%d次",row+1];
}
 ***/
#pragma mark -
#pragma mark 私有方法
-(void)findByName:(NSString*)search searchName:(NSString*)name{
    if ([search length]>0&&[name length]>0&&_pickerData&&[_pickerData count]>0) {
        NSString *str=[NSString stringWithFormat:@"SELF.%@",name];
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"%@ LIKE[cd] %@",str,search];
        NSArray *arr=[_pickerData filteredArrayUsingPredicate:predicate];
        if ([arr count]>0) {
            [self setIndex:[_pickerData indexOfObject:[arr objectAtIndex:0]]];
        }else{
            predicate=[NSPredicate predicateWithFormat:@"%@ CONTAINS %@",search,str];
            arr=[self.pickerData filteredArrayUsingPredicate:predicate];
            if ([arr count]>0) {
                [self setIndex:[_pickerData indexOfObject:[arr objectAtIndex:0]]];
            }
        }
    }
}
-(void)unBindSource{
    [_picker reloadComponent:0];
    _popText.field.text=@"";
    self.itemData=nil;
    if ([self.pickerData count]>0) {
        [self.picker selectRow:0 inComponent:0 animated:YES];
    }
}
#pragma mark -
#pragma mark 公有方法
-(void)findBindName:(NSString*)search{
    [self findByName:search searchName:self.bindName];
}
-(void)findBindValue:(NSString*)search{
    [self findByName:search searchName:self.bindValue];
}
//設定選中項目
-(void)setIndex:(NSInteger)i{
    if (i>=0&&i<[self.pickerData count]) {
        [self.picker selectRow:i inComponent:0 animated:NO];
        self.itemData=[self.pickerData objectAtIndex:i];
        _popText.field.text=[self key];
    }
}
-(void)setSelectedValue:(NSString*)value component:(NSInteger)comp{
    if (comp==0) {
        if (_pickerData&&[_pickerData count]>0) {
            NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF.%@ ==%@",self.bindValue,value];
            NSArray *arr=[_pickerData filteredArrayUsingPredicate:predicate];
            if ([arr count]>0) {
                [self setIndex:[_pickerData indexOfObject:[arr objectAtIndex:0]]];
            }
        }
    }else{
        [self.picker selectRow:[value integerValue]-1 inComponent:1 animated:NO];
    }
   
}
//如:soure=["1","2","3"];
-(void)setDataSourceForArray:(NSArray*)source{
    NSMutableArray *arr=[NSMutableArray array];
    for (id k in source) {
        [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:k,@"key", nil]];
    }
    [self setDataSourceForArray:arr dataTextName:@"key" dataValueName:@"key"];
}
//如:soure with dictionary;
-(void)setDataSourceForArray:(NSArray*)source dataTextName:(NSString*)textName dataValueName:(NSString*)valueName{
    self.bindName=textName;
    self.bindValue=valueName;
    self.pickerData=source;
    
}
-(void)setDataSourceForDictionary:(NSDictionary*)source{
    [self setDataSourceForDictionary:source dataTextName:@"key" dataValueName:@"value"];
}
-(void)setDataSourceForDictionary:(NSDictionary*)source dataTextName:(NSString*)textName dataValueName:(NSString*)valueName
{
    self.bindName=textName;
    self.bindValue=valueName;
    NSMutableArray *arr=[NSMutableArray array];
    for (id k in source.allKeys) {
        [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:k,self.bindName,[source objectForKey:k], self.bindValue,nil]];
    }
    self.pickerData=arr;
}
@end
