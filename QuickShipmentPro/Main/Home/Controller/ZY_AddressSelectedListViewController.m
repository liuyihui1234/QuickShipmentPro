//
//  ZY_AddressSelectedListViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/14.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_AddressSelectedListViewController.h"
#import "ZY_AddressSearchViewController.h"
#import "ZY_AddNewAddressViewController.h"
@interface ZY_AddressSelectedListViewController ()

@end

@implementation ZY_AddressSelectedListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"地址选择";
    [self drawNavUI];
    [self drawButtonUI];
}
#pragma mark----设置导航
- (void)drawNavUI{
    
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"searchaddress"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];
    self.navigationItem.rightBarButtonItem = itemRight;
    
}
#pragma mark------地址选择
- (void)drawButtonUI{
    WeakSelf(self);
    UIButton *addressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addressButton.backgroundColor = [UIColor chains_colorWithHexString:@"#000000" alpha:1.0f];
    addressButton.titleLabel.font = ZYFontSize(19.0f);
    addressButton.layer.cornerRadius = FitSize(24.0f);
    addressButton.tag = 8888;
    
    [addressButton setTitle:@"+ 新地址" forState:UIControlStateNormal];
    [addressButton addTarget:self action:@selector(addressButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addressButton];

    [addressButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakself.view);
        make.bottom.mas_equalTo(-SAFEAREABOTTOM_HEIGHT-FitSize(40.0f));
        make.height.mas_equalTo(FitSize(48.0f));
        make.width.mas_equalTo(FitSize(170.0f));
        
        
    }];
    
}
#pragma mark-----搜索按钮事件
- (void)searchAction:(UIButton *)sender{
    
    ZY_AddressSearchViewController *searchAddVC = [[ZY_AddressSearchViewController alloc]init];
    [self.navigationController pushViewController:searchAddVC animated:YES];
    
}
#pragma mark-----新增地址按钮事件
- (void)addressButtonAction:(UIButton *)sender{
    
    ZY_AddNewAddressViewController *newAddVC = [[ZY_AddNewAddressViewController alloc]init];
    newAddVC.selectedType = self.selectedType;
    [self.navigationController pushViewController:newAddVC animated:YES];
    
}
@end
