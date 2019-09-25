//
//  ZY_MessageCenterViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/23.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_MessageCenterViewController.h"

@interface ZY_MessageCenterViewController ()

@end

@implementation ZY_MessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息中心";
    [self createMeesgaeCenter];
}

#pragma mark-----创建消息中心
- (void)createMeesgaeCenter{
    
    WeakSelf(self);
    NSArray *menuArray = @[@[@"messageimg",@"消息通知"],@[@"messageimg",@"消息通知"],@[@"messageimg",@"消息通知"],@[@"messageimg",@"消息通知"]];
    
    __block UIView *bgView;
    [menuArray enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        bgView = [[UIView alloc]init];
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
        titleLabel.font = ZYFontSize(12.0f);
        titleLabel.textColor = [UIColor chains_colorWithHexString:kDarkGrayColor alpha:1.0f];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = [NSString stringWithFormat:@"%@",obj[1]];
        [bgView addSubview:titleLabel];
        
        UIImageView *arrowImage = [[UIImageView alloc]init];
        arrowImage.contentMode = UIViewContentModeCenter;
        arrowImage.image = [UIImage imageNamed:@"mineArrow"];
        [bgView addSubview:arrowImage];
        
        UILabel *rightLabel = [[UILabel alloc]init];
        rightLabel.font = ZYFontSize(11.0f);
        rightLabel.textColor = [UIColor whiteColor];
        rightLabel.backgroundColor = [UIColor chains_colorWithHexString:kThemeColor alpha:1.0f];
        rightLabel.layer.cornerRadius = FitSize(7.5f);
        rightLabel.clipsToBounds = YES;
        rightLabel.textAlignment = NSTextAlignmentCenter;
        NSInteger number;
        
        if (idx == 0) {
            number = 1000;
        }
        else if (idx == 1){
            number = 1;
        }
        else{
            
            number = 10;
        }
        rightLabel.text = [NSString stringWithFormat:@"%ld",number];
        [bgView addSubview:rightLabel];
        
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
        CGFloat customWidth;
        
        if (number<10) {
            customWidth = FitSize(15.0f);
        }
        else{
            NSString *str = [NSString stringWithFormat:@"%ld",number];
            CGSize size = [str getSpaceLabelHeight:0.0f withFont:ZYFontSize(11.0f) withMaxSize:CGSizeMake(FitSize(160.0f),FitSize(15.0f))];
            customWidth = size.width + 10.0f;
        }
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(arrowImage.mas_left).offset(-FitSize(3.0f));
            make.centerY.equalTo(bgView);
            make.height.equalTo(@(FitSize(15.0f)));
            make.width.equalTo(@(customWidth));
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
        
        
    }
    else if (tapView.tag == 1001){
        
    }
    else{
        
        
        
    }
}

@end
