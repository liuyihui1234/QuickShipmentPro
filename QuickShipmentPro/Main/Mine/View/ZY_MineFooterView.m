//
//  ZY_MineFooterView.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/10.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_MineFooterView.h"
@interface ZY_MineFooterView()
@property(strong,nonatomic)UIButton *logoutButton;
@property(strong,nonatomic)UILabel *messageLabel;

@end
@implementation ZY_MineFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor chains_colorWithHexString:kBackgroundColor alpha:1.0f];
        [self addSubview:self.logoutButton];
        [self addSubview:self.messageLabel];
    }
    return self;
}
#pragma mark-------布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    WeakSelf(self);
    CGFloat spaceX = FitSize(36.0f);
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself);
        make.top.mas_equalTo(spaceX);
        make.height.mas_equalTo(FitSize(48.0f));
        make.width.mas_equalTo(FitSize(350.0f));
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.logoutButton.mas_bottom).offset(FitSize(14.0f));
        make.centerX.width.equalTo(weakself.logoutButton);
        make.height.mas_equalTo(FitSize(20.0f));
        
    }];
}
#pragma mark----退出事件
- (void)logoutButtonAction:(UIButton *)sender{
    
    if (self.logoutClickBlock) {
        self.logoutClickBlock(sender);
    }
    
}
#pragma mark---懒加载
- (UIButton *)logoutButton{
    
    if (_logoutButton == nil) {
        
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoutButton.backgroundColor = [UIColor whiteColor];
        _logoutButton.layer.cornerRadius = FitSize(3.0f);
        _logoutButton.titleLabel.font = ZYFontSize(16.0f);
        [_logoutButton setTitleColor:[UIColor chains_colorWithHexString:kGrayColor alpha:1.0f] forState:UIControlStateNormal];
        [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutButton addTarget:self action:@selector(logoutButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}
- (UILabel *)messageLabel{
    
    if (_messageLabel == nil) {
        
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.font = ZYFontSize(11.0f);
        _messageLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
        _messageLabel.text = @"Copyright 2019深圳德邦物联网有限公司All right reserced";
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _messageLabel;
}

@end
