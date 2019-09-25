//
//  ZY_MyPerformanceViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/30.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_MyPerformanceViewController.h"
#import "ZY_PerformanceOneViewController.h"
#import "ZY_PerformanceTwoViewController.h"
#import "ZYPickerDateView.h"
@interface ZY_MyPerformanceViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)HMSegmentedControl *segmentControl;
@property(nonatomic,strong)NSArray *selectTitleDatas;
@property(nonatomic,strong)ZY_PerformanceOneViewController *onePerformanceVC;
@property(nonatomic,strong)ZY_PerformanceTwoViewController *performanceTwoVC;
@end

@implementation ZY_MyPerformanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的业绩";
    [self drawMainUI];
    [self.view addSubview:self.scrollView];
    [self changeViewToIndex:0];
}
#pragma mark----创建主模块
- (void)drawMainUI{
    WeakSelf(self);
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(weakself.view);
        make.top.mas_equalTo(SAFEAREATOP_HEIGHT);
        make.height.mas_equalTo(FitSize(40.0f));
    }];
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:self.selectTitleDatas];
    segmentedControl.backgroundColor = [UIColor clearColor];
    segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor chains_colorWithHexString:kDarkColor alpha:1.0f], NSFontAttributeName:ZYFontSize(13.0f)};
    segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor chains_colorWithHexString:kThemeColor alpha:1.0f], NSFontAttributeName:ZYFontSize(13.0f)};
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    segmentedControl.selectionIndicatorHeight = FitSize(2.0f);
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.selectionIndicatorColor = [UIColor chains_colorWithHexString:kThemeColor alpha:1.0f];
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    self.segmentControl = segmentedControl;
    [bgView addSubview:segmentedControl];
    
    UIButton *calendarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [calendarButton setImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateNormal];
    [calendarButton addTarget:self action:@selector(calendarAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:calendarButton];
    
    [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.height.equalTo(bgView);
        make.width.mas_equalTo(FitSize(138.0f));
    
    }];
    [calendarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-FitSize(5.0f));
        make.top.height.equalTo(bgView);
        make.width.mas_equalTo(FitSize(37.0f));
    }];
}
#pragma mark----selected选择控制器
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl{
    
    NSInteger index = segmentedControl.selectedSegmentIndex;
    [self changeViewToIndex:index];
}
#pragma mark-----scrollView滑动的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    [self.segmentControl setSelectedSegmentIndex:page animated:YES];
    [self changeViewToIndex:page];
}
#pragma mark-----改变试图
- (void)changeViewToIndex:(NSInteger)index{
    
    [self.scrollView setContentOffset:CGPointMake(KSCREEN_WIDTH*index,0.0f) animated:YES];
    if (index == 0) {
        
        if (self.onePerformanceVC.view.superview) {
            return;
        }
        [self addChildViewController:self.onePerformanceVC];
        [self.scrollView addSubview:self.onePerformanceVC.view];
        [self.performanceTwoVC removeFromParentViewController];
    }
    else{
        if (self.performanceTwoVC.view.superview) {
            return;
        }
        [self addChildViewController:self.performanceTwoVC];
        [self.scrollView addSubview:self.performanceTwoVC.view];
        [self.onePerformanceVC removeFromParentViewController];
    }
}
#pragma mark-----日期按钮点击事件
- (void)calendarAction:(UIButton *)sender{
    
    ZYPickerDateView *pickerView =[[ZYPickerDateView alloc]initWithFrame:CGRectMake(0.0, 0.0f, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
    [self.view addSubview:pickerView];
    pickerView.selectedBlock = ^(NSString * selectedDate){
        
        NSLog(@"%@",selectedDate);
        
    };
}
#pragma mark---------懒加载
- (UIScrollView *)scrollView{
    
    if (_scrollView == nil) {
        
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.backgroundColor = [UIColor chains_colorWithHexString:kBackgroundColor alpha:1.0f];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(KSCREEN_WIDTH *2,0);
        _scrollView.frame = CGRectMake(0.0f, SAFEAREATOP_HEIGHT+FitSize(40.0f), KSCREEN_WIDTH, KSCREEN_HEIGHT-SAFEAREATOP_HEIGHT-FitSize(42.0f));
        
    }
    
    return _scrollView;
}
- (NSArray *)selectTitleDatas{
    
    if (_selectTitleDatas == nil) {
        
        _selectTitleDatas = [NSArray arrayWithObjects:@"收件 0",@"派件 0" ,nil];
    }
    return _selectTitleDatas;
}
- (ZY_PerformanceOneViewController *)onePerformanceVC{
    
    if (_onePerformanceVC == nil) {
        WeakSelf(self);
        _onePerformanceVC = [[ZY_PerformanceOneViewController alloc]init];
        _onePerformanceVC.view.frame = CGRectMake(0.0f, 0.0f, weakself.scrollView.frame.size.width,weakself.scrollView.frame.size.height);
//        _ZY_PerformanceOneViewController.queryOrderDetailClickBlock = ^(NSString * _Nonnull orderNo) {
//            
//            ZY_OrderDetailViewController *checkVC = [[ZY_OrderDetailViewController alloc]init];
//            checkVC.orderNo = [NSString stringWithFormat:@"%@",orderNo];
//            [weakself.navigationController pushViewController:checkVC animated:YES];
//            
//        };
    }
    return _onePerformanceVC;
}
- (ZY_PerformanceTwoViewController *)performanceTwoVC{
    
    if (_performanceTwoVC == nil) {
        WeakSelf(self);
        _performanceTwoVC = [[ZY_PerformanceTwoViewController alloc]init];
        _performanceTwoVC.view.frame = CGRectMake(KSCREEN_WIDTH, 0.0f, weakself.scrollView.frame.size.width,weakself.scrollView.frame.size.height);
        //        _ZY_PerformanceOneViewController.queryOrderDetailClickBlock = ^(NSString * _Nonnull orderNo) {
        //
        //            ZY_OrderDetailViewController *checkVC = [[ZY_OrderDetailViewController alloc]init];
        //            checkVC.orderNo = [NSString stringWithFormat:@"%@",orderNo];
        //            [weakself.navigationController pushViewController:checkVC animated:YES];
        //
        //        };
    }
    return _performanceTwoVC;
}

@end
