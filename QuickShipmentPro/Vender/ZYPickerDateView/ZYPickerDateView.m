//
//  ZYPickerDateView.m
//  ZYSignContractPro
//
//  Created by 飞之翼 on 2019/6/26.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZYPickerDateView.h"

#define kFirstComponent 0
#define kSubComponent 1
@interface ZYPickerDateView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(strong,nonatomic)UIPickerView * pickerView;
@property(strong,nonatomic)NSString * selectedDateString;
@property(strong,nonatomic)NSArray * arrayMonth;
@property(strong,nonatomic)NSMutableArray * arrayYear;


@end

@implementation ZYPickerDateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor chains_colorWithHexString:kBlackColor alpha:0.2f];
        [self createMainUI];
    }
    return self;
}
- (void)createMainUI{
    
    UIView * backGroudView =[[UIView alloc]init];
    backGroudView.frame = CGRectMake(0,KSCREEN_HEIGHT - FitSize(250.0f), KSCREEN_WIDTH, FitSize(250.0f));
    backGroudView.backgroundColor =[UIColor whiteColor];
    [self addSubview:backGroudView];
    
    UIButton * cancelButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(FitSize(5.0f), 0,FitSize(64.0f), FitSize(44.0f));
    cancelButton.titleLabel.font = ZYFontSize(17.0f);
    [cancelButton setTitleColor:[UIColor chains_colorWithHexString:kThemeColor alpha:1.0f] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [backGroudView addSubview:cancelButton];
    
    UILabel * titleLable =[[UILabel alloc]init];
    titleLable.text = @"选择日期";
    titleLable.frame = CGRectMake(FitSize(70.0f), 0, KSCREEN_WIDTH-FitSize(140.0f), FitSize(44.0f));
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = ZYFontSize(17.0f);
    titleLable.textColor = [UIColor chains_colorWithHexString:kThemeColor alpha:1.0f];
    [backGroudView addSubview:titleLable];
    
    UIButton * DoneButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [DoneButton setTitle:@"确定" forState:UIControlStateNormal];
    DoneButton.frame = CGRectMake(KSCREEN_WIDTH-FitSize(69.0f), 0, FitSize(64.0f),FitSize(44.0f));
    [DoneButton setTitleColor:[UIColor chains_colorWithHexString:kThemeColor alpha:1.0f] forState:UIControlStateNormal];
    [DoneButton addTarget:self action:@selector(DoneButton) forControlEvents:UIControlEventTouchUpInside];
    DoneButton.titleLabel.font = ZYFontSize(17.0f);
    [backGroudView addSubview:DoneButton];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    NSInteger year = [components year];  //当前的年份
    NSInteger month = [components month];  //当前的月份
    
    _arrayYear =[[NSMutableArray alloc]initWithCapacity:0];
    //   [[arrayYear reverseObjectEnumerator] allObjects];//数组倒序排列
    for (NSInteger k = year - 1980 ; k > 0; k --) {
        [_arrayYear addObject:[NSString stringWithFormat:@"%ld年",year-k]];
    }
    [_arrayYear addObject:[NSString stringWithFormat:@"%ld年",year]];
    
    //        for (int i= 0; i < 1; i++ ) {
    //            [_arrayYear addObject:[NSString stringWithFormat:@"%ld年",year+i]];
    //        }
    //
    _arrayMonth = [[NSArray alloc]initWithObjects:@"1月", @"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月",nil];
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, FitSize(44.0f), KSCREEN_WIDTH,FitSize(200.0f))];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    [backGroudView addSubview:self.pickerView];
    
    [self.pickerView selectRow:[_arrayYear indexOfObject:[NSString stringWithFormat:@"%ld年",year]] inComponent:0 animated:YES];
    [self.pickerView selectRow:[_arrayMonth indexOfObject:[NSString stringWithFormat:@"%ld月",month]] inComponent:1 animated:YES];
    _selectedDateString = [NSString stringWithFormat:@"%ld年%ld月",year,month];
    
    
}
- (void)cancelButtonClick {
    [self removeFromSuperview];
}
- (void)DoneButton {
    
    [self removeFromSuperview];
   
    if (self.selectedBlock) {
        self.selectedBlock(_selectedDateString);
    }
    
}
//返回几列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
//返回列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == kFirstComponent) {
        return _arrayYear.count;
    }else{
        return _arrayMonth.count;
    }
}
//显示的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component==kFirstComponent){
        NSString *provinceStr = [_arrayYear objectAtIndex:row];
        return provinceStr;
    }else{
        NSString *provinceStr = [_arrayMonth objectAtIndex:row];
        return provinceStr;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == kFirstComponent) {//刷新
        [pickerView selectRow:kFirstComponent inComponent:kSubComponent animated:YES];
        [pickerView reloadComponent:kSubComponent];
    }
    NSInteger yearComponent = [pickerView selectedRowInComponent:kFirstComponent];
    NSInteger monthComponent = [pickerView selectedRowInComponent:kSubComponent];
    NSString * yearString = [_arrayYear objectAtIndex:yearComponent];
    NSString * monthString = [_arrayMonth objectAtIndex:monthComponent];
    _selectedDateString = [NSString stringWithFormat:@"%@%@",yearString,monthString];
}
@end
