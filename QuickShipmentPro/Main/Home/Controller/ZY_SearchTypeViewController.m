//
//  ZY_SearchTypeViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/23.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_SearchTypeViewController.h"
#import "ZY_FreightSearchViewController.h"
@interface ZY_SearchTypeViewController ()

@end

@implementation ZY_SearchTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"查询";
    [self createSearchTypeSelected];
}
#pragma mark-----创建消息中心
- (void)createSearchTypeSelected{
    
    WeakSelf(self);
    NSArray *menuArray = @[@[@"messageimg",@"运费查询"],@[@"messageimg",@"违禁品查询"],@[@"messageimg",@"邮编查询"]];
    
    [menuArray enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = [UIColor chains_colorWithHexString:kWhiteColor alpha:1.0f];
        bgView.tag = idx+1000;
        [weakself.view addSubview:bgView];
        CGFloat spaceX = FitSize(15.0f);
        CGFloat height = FitSize(44.0f);
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.width.equalTo(weakself.view);
            make.height.mas_equalTo(height);
            make.top.equalTo(@(SAFEAREATOP_HEIGHT+FitSize(10.0f)+idx*(FitSize(45.0f))));
        }];
        
        UIImageView *markImageView = [[UIImageView alloc]init];
        markImageView.contentMode = UIViewContentModeCenter;
        markImageView.image = [UIImage imageNamed:obj[0]];
        [bgView addSubview:markImageView];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.font = ZYFontSize(13.0f);
        titleLabel.textColor = [UIColor chains_colorWithHexString:kDarkGrayColor alpha:1.0f];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = [NSString stringWithFormat:@"%@",obj[1]];
        [bgView addSubview:titleLabel];
        
        UIImageView *arrowImage = [[UIImageView alloc]init];
        arrowImage.contentMode = UIViewContentModeCenter;
        arrowImage.image = [UIImage imageNamed:@"mineArrow"];
        [bgView addSubview:arrowImage];
        
        [markImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(spaceX);
            make.centerY.equalTo(bgView);
            make.height.width.mas_equalTo(FitSize(22.0f));
            
        }];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(markImageView.mas_right).offset(FitSize(12.0f));
            make.top.height.equalTo(bgView);
            make.width.mas_lessThanOrEqualTo(FitSize(160.0f));
            
        }];
        [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-spaceX);
            make.top.height.equalTo(bgView);
            make.width.mas_equalTo(FitSize(10.0f));
            
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
    if(tapView.tag == 1000){
        ZY_FreightSearchViewController *searchVC = [[ZY_FreightSearchViewController alloc]init];
        [self.navigationController pushViewController:searchVC animated:YES];
    }
    else if (tapView.tag == 1001){
        
        
        
    }
    else{
        
    
    }
}

@end
