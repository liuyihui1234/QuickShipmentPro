//
//  ZY_ComplaintsRecordCell.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/13.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_ComplaintsRecordCell.h"
#import "ZY_ComplaintsRecordModel.h"

@interface ZY_ComplaintsRecordCell()
@property(strong,nonatomic)UILabel *timeLabel;
@property(strong,nonatomic)UIView *firBGView;
@property(strong,nonatomic)UIView *seondBGView;
@property(strong,nonatomic)UILabel *nameLabel;
@property(strong,nonatomic)UILabel *telLabel;
@property(strong,nonatomic)UILabel *messageLabel;
@property(strong,nonatomic)UILabel *statusLabel;
@property(strong,nonatomic)UIButton *sureButton;
@end

@implementation ZY_ComplaintsRecordCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor chains_colorWithHexString:kBackgroundColor alpha:1.0f];
        self.layer.cornerRadius = FitSize(3.0f);
        self.clipsToBounds = YES;
        [self addSubview:self.timeLabel];
        [self addSubview:self.firBGView];
        [self addSubview:self.seondBGView];
        [self.firBGView addSubview:self.nameLabel];
        [self.firBGView addSubview:self.telLabel];
        [self.firBGView addSubview:self.messageLabel];
        [self.seondBGView addSubview:self.statusLabel];
        [self.seondBGView addSubview:self.sureButton];
    }
    return self;
}
#pragma mark----赋值
- (void)setComplaintsRecordObj:(ZY_ComplaintsRecordModel *)complaintsRecordObj{
    
    NSString *timeStr = [NSString stringWithFormat:@"%@",[ZYTools changeCreateTimeFormat:[NSString stringWithFormat:@"%@",complaintsRecordObj.crttime]]];
    
    self.timeLabel.text = timeStr;
    
    self.nameLabel.text = [NSString stringWithFormat:@"姓名：%@",complaintsRecordObj.customername];
    self.telLabel.text = [NSString stringWithFormat:@"电话：%@",complaintsRecordObj.phone];
    self.messageLabel.text = [NSString stringWithFormat:@"%@",complaintsRecordObj.remark];
    NSString *statusStr = [complaintsRecordObj.status integerValue] == 1 ? @"待处理" : @"已处理";
    self.statusLabel.text = [NSString stringWithFormat:@"%@",statusStr];
}
#pragma mark-------布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    WeakSelf(self);
    CGFloat spaceX = FitSize(19.0f);
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.width.equalTo(weakself);
        make.height.mas_equalTo(FitSize(38.0f));
        
        
    }];
    [self.firBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(weakself.timeLabel);
        make.top.equalTo(weakself.timeLabel.mas_bottom);
        make.height.mas_equalTo(FitSize(107.0f));
    }];
    [self.seondBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.equalTo(weakself.firBGView);
        make.top.equalTo(weakself.firBGView.mas_bottom);
        make.height.mas_equalTo(FitSize(59.0f));
        
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(spaceX);
        make.top.mas_equalTo(FitSize(5.0f));
        make.height.mas_equalTo(FitSize(23.0f));
        make.width.mas_equalTo(FitSize(300.0f));
        
    }];
    
    [self.telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.height.equalTo(weakself.nameLabel);
        make.top.equalTo(weakself.nameLabel.mas_bottom).offset(FitSize(5.0f));
        
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.equalTo(weakself.nameLabel);
        make.top.equalTo(weakself.telLabel.mas_bottom).offset(FitSize(5.0f));
        make.height.mas_equalTo(FitSize(45.0f));
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(spaceX);
        make.bottom.mas_equalTo(-FitSize(14.0f));
        make.height.mas_equalTo(FitSize(27.0f));
        make.width.mas_equalTo(FitSize(80.0f));
    }];
    
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-FitSize(15.0f));
        make.bottom.height.equalTo(weakself.statusLabel);
        make.width.mas_equalTo(FitSize(74.0f));
    }];
    
}

- (void)sureButtonAction:(UIButton *)sender{
    
    
    
}
#pragma mark-----懒加载
- (UILabel *)timeLabel{
    
    if (_timeLabel == nil) {
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = ZYFontSize(11.0f);
        _timeLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _timeLabel;
}
- (UIView *)firBGView{
    
    
    if (_firBGView == nil) {
        
        _firBGView = [[UIView alloc]init];
        _firBGView.backgroundColor = [UIColor whiteColor];
        _firBGView.layer.cornerRadius = FitSize(5.0f);
        
    }
    return _firBGView;
}
- (UIView *)seondBGView{
    
    
    if (_seondBGView == nil) {
        
        _seondBGView = [[UIView alloc]init];
        _seondBGView.backgroundColor = [UIColor chains_colorWithHexString:@"#e8e8e8" alpha:1.0f];
        
        
    }
    return _seondBGView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = ZYFontSize(14.0f);
        _nameLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
        
    }
    return _nameLabel;
}
- (UILabel *)telLabel{
    
    if (_telLabel == nil) {
        
        _telLabel = [[UILabel alloc]init];
        _telLabel.font = ZYFontSize(14.0f);
        _telLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
        
    }
    
    return _telLabel;
}
- (UILabel *)messageLabel{
    
    if (_messageLabel == nil) {
        
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.font = ZYFontSize(13.0f);
        _messageLabel.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}
- (UILabel *)statusLabel{
    
    if (_statusLabel == nil) {
        
        _statusLabel = [[UILabel alloc]init];
        _statusLabel.font = ZYFontSize(14.0f);
        _statusLabel.textColor = [UIColor chains_colorWithHexString:kDarkGrayColor alpha:1.0f];
        
    }
    return _statusLabel;
}
- (UIButton *)sureButton{
    
    if (_sureButton == nil) {
        
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.layer.borderColor = [UIColor chains_colorWithHexString:kThemeColor alpha:1.0f].CGColor;
        _sureButton.layer.borderWidth = FitSize(1.0f);
        _sureButton.titleLabel.font = ZYFontSize(14.0f);
        [_sureButton setTitleColor:[UIColor chains_colorWithHexString:kThemeColor alpha:1.0f] forState:UIControlStateNormal];
        [_sureButton setTitle:@"确认处理" forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}
@end
