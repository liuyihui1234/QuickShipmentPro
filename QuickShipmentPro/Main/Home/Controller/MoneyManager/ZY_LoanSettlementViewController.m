//
//  ZY_LoanSettlementViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/30.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_LoanSettlementViewController.h"
#import "ZY_HavePayViewController.h"//已支付
#import "ZY_NoPaymentViewController.h"//未支付
@interface ZY_LoanSettlementViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)HMSegmentedControl *segmentControl;
@property(nonatomic,strong)NSArray *selectTitleDatas;
@property(nonatomic,strong)ZY_HavePayViewController *havedPaymentVC;
@property(nonatomic,strong)ZY_NoPaymentViewController *notPaymentVC;

@end

@implementation ZY_LoanSettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"贷款结算";
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
    [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.height.equalTo(bgView);
        make.width.mas_equalTo(FitSize(138.0f));
        
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
        if (self.notPaymentVC.view.superview) {
            return;
        }
        [self addChildViewController:self.notPaymentVC];
        [self.scrollView addSubview:self.notPaymentVC.view];
        [self.havedPaymentVC removeFromParentViewController];
    }
    else{
        if (self.havedPaymentVC.view.superview) {
            return;
        }
        [self addChildViewController:self.havedPaymentVC];
        [self.scrollView addSubview:self.havedPaymentVC.view];
        [self.notPaymentVC removeFromParentViewController];
    }
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
        
        _selectTitleDatas = [NSArray arrayWithObjects:@"未支付",@"已支付" ,nil];
    }
    return _selectTitleDatas;
}
- (ZY_NoPaymentViewController *)notPaymentVC{
    
    if (_notPaymentVC == nil) {
        WeakSelf(self);
        _notPaymentVC = [[ZY_NoPaymentViewController alloc]init];
        _notPaymentVC.view.frame = CGRectMake(0.0f, 0.0f, weakself.scrollView.frame.size.width,weakself.scrollView.frame.size.height);
        //        _ZY_PerformanceOneViewController.queryOrderDetailClickBlock = ^(NSString * _Nonnull orderNo) {
        //
        //            ZY_OrderDetailViewController *checkVC = [[ZY_OrderDetailViewController alloc]init];
        //            checkVC.orderNo = [NSString stringWithFormat:@"%@",orderNo];
        //            [weakself.navigationController pushViewController:checkVC animated:YES];
        //
        //        };
    }
    return _notPaymentVC;
}


- (ZY_HavePayViewController *)havedPaymentVC{
    
    if (_havedPaymentVC == nil) {
        WeakSelf(self);
        _havedPaymentVC = [[ZY_HavePayViewController alloc]init];
        _havedPaymentVC.view.frame = CGRectMake(KSCREEN_WIDTH, 0.0f, weakself.scrollView.frame.size.width,weakself.scrollView.frame.size.height);
        //        _ZY_PerformanceOneViewController.queryOrderDetailClickBlock = ^(NSString * _Nonnull orderNo) {
        //
        //            ZY_OrderDetailViewController *checkVC = [[ZY_OrderDetailViewController alloc]init];
        //            checkVC.orderNo = [NSString stringWithFormat:@"%@",orderNo];
        //            [weakself.navigationController pushViewController:checkVC animated:YES];
        //
        //        };
    }
    return _havedPaymentVC;
}

@end
