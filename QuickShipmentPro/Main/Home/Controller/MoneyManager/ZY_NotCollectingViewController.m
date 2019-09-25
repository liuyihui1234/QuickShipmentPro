//
//  ZY_NotCollectingViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/12.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_NotCollectingViewController.h"
#import "ZY_PaymentInfoModel.h"
#import "ZY_PaymentAdrInfoView.h"

@interface ZY_NotCollectingViewController ()

@end

@implementation ZY_NotCollectingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createMainUI];
    [self drawToolBarView];
}
#pragma mark------创建模块
- (void)createMainUI{
    WeakSelf(self);
    
    ZY_PaymentInfoModel *model = [[ZY_PaymentInfoModel alloc]init];
    model.number = @"TT6600039908311";
    model.sendName = @"张家明";
    model.sendPhone = @"15838348055";
    model.sendAddress = @"广东省广州市花都区田美村";
    model.receiveName = @"果果 ";
    model.receivePhone = @"15838348055";
    model.receiveAddress = @"河南省郑州市郑东新区";
    
    ZY_PaymentAdrInfoView *payMentView = [[ZY_PaymentAdrInfoView alloc]init];
    //payMentView.frame = CGRectMake(FitSize(12.0), FitSize(11.0f), KSCREEN_WIDTH-FitSize(24.0f), FitSize(163.0f))
    payMentView.paymentInfoObj = model;
    [self.view addSubview:payMentView];
    
    UIView *messageBGView = [[UIView alloc]init];
    messageBGView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:messageBGView];
    
    [payMentView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(weakself.view);
        make.top.mas_equalTo(FitSize(11.0f));
        make.width.mas_equalTo(KSCREEN_WIDTH-FitSize(24.0f));
        make.height.mas_equalTo(FitSize(163.0f));
    }];
    [messageBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(weakself.view);
        make.top.equalTo(payMentView.mas_bottom).offset(FitSize(10.0f));
        make.height.mas_equalTo(FitSize(350.0f));
        
    }];

    CGFloat spaceX = FitSize(12.0f);
    CGFloat cusHeight = FitSize(59.0f);
    
    ZYChoiceGoodsInfoView *goodsMesView = [[ZYChoiceGoodsInfoView alloc]init];
    [goodsMesView changeShowMessgeWithImage:@"tuojiwu" title:@"托寄物信息" message:@"文件/kg"];
    [messageBGView addSubview:goodsMesView];
    
    ZYChoiceGoodsInfoView *payTypeView = [[ZYChoiceGoodsInfoView alloc]init];
    [payTypeView changeShowMessgeWithImage:@"fukuanfangshi" title:@"付款方式" message:@"寄付现结"];
    [messageBGView addSubview:payTypeView];
    
    ZYChoiceGoodsInfoView *collMoneyView = [[ZYChoiceGoodsInfoView alloc]init];
    [collMoneyView changeShowMessgeWithImage:@"managerimg" title:@"代收货款" message:@"0.00"];
    [messageBGView addSubview:collMoneyView];
    
    ZYChoiceGoodsInfoView *valuationView = [[ZYChoiceGoodsInfoView alloc]init];
    [valuationView changeShowMessgeWithImage:@"baojiaimg" title:@"保价" message:@"无"];
    [messageBGView addSubview:valuationView];
    
    ZYChoiceGoodsInfoView *addValueView = [[ZYChoiceGoodsInfoView alloc]init];
    [addValueView changeShowMessgeWithImage:@"zengzhifuwu" title:@"增值服务" message:@"无"];
    [messageBGView addSubview:addValueView];
    
    ZYChoiceGoodsInfoView *remarkView = [[ZYChoiceGoodsInfoView alloc]init];
    [remarkView changeShowMessgeWithImage:@"beizhuimg" title:@"备注" message:@"无"];
    [messageBGView addSubview:remarkView];
    
    [goodsMesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceX);
        make.top.mas_equalTo(FitSize(16.0f));
        make.width.mas_equalTo(KSCREEN_WIDTH-FitSize(24.0f));
        make.height.mas_equalTo(cusHeight);
    }];
    
    [payTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(goodsMesView);
        make.top.equalTo(goodsMesView.mas_bottom).offset(FitSize(17.0f));
        make.width.mas_equalTo(FitSize(160.0f));
    }];
    [collMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.equalTo(payTypeView);
        make.right.mas_equalTo(-spaceX);
       
    }];
    
    [valuationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(payTypeView);
        make.top.equalTo(payTypeView.mas_bottom).offset(FitSize(17.0f));
        
    }];
    
    [addValueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.equalTo(valuationView);
        make.right.equalTo(collMoneyView);
        
    }];
    [remarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(valuationView);
        make.top.equalTo(valuationView.mas_bottom).offset(FitSize(17.0f));
        
    }];
}
#pragma mark----创建底部操作栏
- (void)drawToolBarView{
    
    WeakSelf(self);
    UIView *cusToolBar = [[UIView alloc]init];
    cusToolBar.backgroundColor = [UIColor chains_colorWithHexString:kWhiteColor alpha:1.0f];
    [self.view addSubview:cusToolBar];
    
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customButton.backgroundColor = [UIColor chains_colorWithHexString:kThemeColor alpha:1.0f];
    [customButton setTitle:@"确认待收" forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor chains_colorWithHexString:kWhiteColor alpha:1.0f] forState:UIControlStateNormal];
    customButton.titleLabel.font = ZYFontSize(14.0f);
    [customButton addTarget:self action:@selector(customButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cusToolBar addSubview:customButton];
    
    [cusToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.width.equalTo(weakself.view);
        make.height.equalTo(@(FitSize(49.0f)+SAFEAREABOTTOM_HEIGHT));
    }];
    
    [customButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-FitSize(12.0f)));
        make.top.mas_equalTo(FitSize(7.5f));
        make.width.mas_equalTo(FitSize(98.0f));
        make.height.mas_equalTo(FitSize(34.0f));
    }];
}
- (void)customButtonAction:(UIButton *)sender{
    
    
    
    
}
@end
