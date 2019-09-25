//
//  ZY_AddressSearchViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/14.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_AddressSearchViewController.h"

@interface ZY_AddressSearchViewController ()

@end

@implementation ZY_AddressSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"地址搜索";
    [self drawSearchUI];
}
#pragma mark----搜索模块
- (void)drawSearchUI{
    WeakSelf(self);
    UIView *searchBGView = [[UIView alloc]init];
    searchBGView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:searchBGView];
    [searchBGView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(weakself.view);
        make.top.mas_equalTo(SAFEAREATOP_HEIGHT);
        make.height.mas_equalTo(FitSize(49.0f));
        
    }];
    UITextField *searchTextfiled = [[UITextField alloc]init];
    searchTextfiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchTextfiled.font = ZYFontSize(14.0f);
    searchTextfiled.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
    searchTextfiled.placeholder = @"请搜索姓名或电话号码";
    [searchBGView addSubview:searchTextfiled];
    
    [searchTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(FitSize(12.0f));
        make.top.height.equalTo(searchBGView);
        make.width.mas_equalTo(KSCREEN_WIDTH-FitSize(24.0f));
        
    }];
    
    
    
}

@end
