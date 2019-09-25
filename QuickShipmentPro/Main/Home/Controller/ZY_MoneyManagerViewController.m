//
//  ZY_MoneyManagerViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/23.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_MoneyManagerViewController.h"
#import "ZY_MyPerformanceViewController.h"//我的业绩
#import "ZY_LoanSettlementViewController.h"//贷款结算
#import "ZY_PaymentListViewController.h"//代收货款
#import "ZY_GiveRewardViewController.h"//打赏
@implementation ZY_MoneyManagerViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"资金管理";
    [self drawMainUI];
}
- (void)drawMainUI{
    
    WeakSelf(self);
    NSArray *menuArray = @[@[@"qujianimg",@"  我的业绩"],@[@"qujianimg",@"  货款结算"],@[@"qujianimg",@"  待收货款"],@[@"qujianimg",@"  打赏"]];
    [menuArray enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.cornerRadius = FitSize(3.0f);
        bgView.tag = idx + 400;
        [weakself.view addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FitSize(12.0f));
            make.top.equalTo(@(SAFEAREATOP_HEIGHT+FitSize(23.0f)+idx*FitSize(67.0f)));
            make.height.mas_equalTo(FitSize(44.0f));
            make.width.mas_equalTo(KSCREEN_WIDTH-FitSize(24.0f));
            
        }];
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.font = ZYFontSize(14.0f);
        titleLabel.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        
        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:obj[1]];
        /**
         添加图片到指定的位置
         */
        NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
        // 表情图片
        attchImage.image = [UIImage imageNamed:obj[0]];
        
        CGFloat width;
        if (idx == 0) {
            width = 17.0f;
        }
        else{
            width = 20.0f;
        }
        // 设置图片大小
        attchImage.bounds = CGRectMake(0,-FitSize(5.0f),FitSize(width),FitSize(20.0f));
        NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
        [attriStr insertAttributedString:stringImage atIndex:0];
        titleLabel.attributedText = attriStr;
        [bgView addSubview:titleLabel];

        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(FitSize(15.0f)));
            make.top.height.equalTo(bgView);
            make.width.lessThanOrEqualTo(@(FitSize(260.0f)));
            
        }];
        //单击的手势
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        tapRecognize.numberOfTapsRequired = 1;
        [tapRecognize setEnabled :YES];
        [tapRecognize delaysTouchesBegan];
        [bgView addGestureRecognizer:tapRecognize];
    }];
}
#pragma mark-----手势事件
- (void)handleTap:(UITapGestureRecognizer *)tap{
    
    UIView *tapView = [tap view];
    if(tapView.tag == 400){
        //我的业绩
        ZY_MyPerformanceViewController *myPerformVC = [[ZY_MyPerformanceViewController alloc]init];
        [self.navigationController pushViewController:myPerformVC animated:YES];
    }
    else if (tapView.tag == 401){
        //贷款结算
        ZY_LoanSettlementViewController *loanSetVC = [[ZY_LoanSettlementViewController alloc]init];
        [self.navigationController pushViewController:loanSetVC animated:YES];
    }
    else if (tapView.tag == 402){
        //代收货款
        ZY_PaymentListViewController *paymentVC = [[ZY_PaymentListViewController alloc]init];
        [self.navigationController pushViewController:paymentVC animated:YES];
    }
    else{
        //打赏
        ZY_GiveRewardViewController *giveRewardVC = [[ZY_GiveRewardViewController alloc]init];
        [self.navigationController pushViewController:giveRewardVC animated:YES];
    }
}
@end
