//
//  ZY_PickUpListCell.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/27.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_PickUpListCell.h"
#import "ZY_PickUpModel.h"
@interface ZY_PickUpListCell()<ZKTimerListener>
@property(strong,nonatomic)UIImageView *iconImageView;
@property(strong,nonatomic)UILabel *nameLabel;
@property(strong,nonatomic)UILabel *countdownLabel;
@property(strong,nonatomic)UIView *messageBGView;
@property(strong,nonatomic)UILabel *phoneLabel;
@property(strong,nonatomic)UILabel *addressLabel;
@property(strong,nonatomic)UILabel *timeLabel;
@property(strong,nonatomic)UIButton *locationButton;
@property(strong,nonatomic)UIButton *editMesButton;
@property(strong,nonatomic)UIButton *sureButton;

@end

@implementation ZY_PickUpListCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [TIMER_SERVICE_INSTANCE addListener:self];
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = FitSize(5.0f);
        [self addSubview:self.iconImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.countdownLabel];
        [self addSubview:self.messageBGView];
        [self addSubview:self.timeLabel];
        [self addSubview:self.editMesButton];
        [self addSubview:self.sureButton];
        [self.messageBGView addSubview:self.phoneLabel];
        [self.messageBGView addSubview:self.addressLabel];
        [self.messageBGView addSubview:self.locationButton];
        
    }
    return self;
}
- (void)setPickUpListObj:(ZY_PickUpModel *)pickUpListObj{
    
    _pickUpListObj = pickUpListObj;
    self.nameLabel.text = [NSString stringWithFormat:@"%@",pickUpListObj.fromname];
    [self didOnTimer:TIMER_SERVICE_INSTANCE];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",pickUpListObj.appointmenttime];
    
    NSString *phoneSting = [NSString stringWithFormat:@"  %@",pickUpListObj.fromtel];
    
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:phoneSting];
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    attchImage.image = [UIImage imageNamed:@"managerimg"];
    attchImage.bounds = CGRectMake(0,-FitSize(3.0f),FitSize(20.0f),FitSize(20.0f));
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
    [attriStr insertAttributedString:stringImage atIndex:0];
    self.phoneLabel.attributedText = attriStr;
    
    NSString *addressSting = [NSString stringWithFormat:@"  %@",pickUpListObj.fromaddress];
    
    NSMutableAttributedString *addressattriStr = [[NSMutableAttributedString alloc] initWithString:addressSting];
    NSTextAttachment *addressattchImage = [[NSTextAttachment alloc] init];
    addressattchImage.image = [UIImage imageNamed:@"managerimg"];
    addressattchImage.bounds = CGRectMake(0,-FitSize(3.0f),FitSize(20.0f),FitSize(20.0f));
    NSAttributedString *addressattchstringImage = [NSAttributedString attributedStringWithAttachment:addressattchImage];
    [addressattriStr insertAttributedString:addressattchstringImage atIndex:0];
    self.addressLabel.attributedText = addressattriStr;
    
}
- (void)didOnTimer:(ZKTimerService *)service{
    NSInteger leftTimeInterval = _pickUpListObj.timeInterval - service.timeInterval;
    if (leftTimeInterval <= 0) {
        self.countdownLabel.text = @"订单已失效";
    } else {
        NSInteger hours = leftTimeInterval / 3600;
        NSInteger minutes = leftTimeInterval / 60 % 60;
        NSInteger seconds = leftTimeInterval % 60;
        self.countdownLabel.text = [NSString stringWithFormat:@"剩余时间：%02zd:%02zd:%02zd", hours, minutes, seconds];
    }
}
- (void)customButtonAction:(UIButton *)sender{
    
    if (self.customButtonBlock) {
        self.customButtonBlock(sender.tag);
    }
    
}

#pragma mark-------布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    WeakSelf(self);
    CGFloat spaceX = FitSize(14.0f);
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FitSize(5.0f));
        make.left.mas_equalTo(spaceX);
        make.height.width.mas_equalTo(FitSize(36.0f));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(weakself.iconImageView);
        make.left.equalTo(weakself.iconImageView.mas_right).offset(FitSize(8.0f));
        make.width.mas_equalTo(FitSize(200.0f));
    }];
    [self.countdownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(weakself.nameLabel);
        make.right.mas_equalTo(-spaceX);
        make.width.mas_equalTo(FitSize(120.0f));
    }];
    [self.messageBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.equalTo(weakself);
        make.top.equalTo(weakself.iconImageView.mas_bottom).offset(FitSize(5.0f));
        make.height.mas_equalTo(FitSize(90.0f));
        
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.iconImageView);
        make.top.equalTo(weakself.messageBGView.mas_bottom).offset(FitSize(9.0f));
        make.height.mas_equalTo(FitSize(27.0f));
        make.width.mas_equalTo(FitSize(120.0f));
    }];
    [self.editMesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-spaceX);
        make.top.height.equalTo(weakself.timeLabel);
        make.width.mas_equalTo(FitSize(79.0f));
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.editMesButton.mas_left).offset(-FitSize(20.0f));
        make.top.height.width.equalTo(weakself.editMesButton);
    }];
    
    [self.phoneLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceX);
        make.top.mas_equalTo(FitSize(18.0f));
        make.height.mas_equalTo(FitSize(20.0f));
        make.width.mas_equalTo(FitSize(290.0f));
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.phoneLabel.mas_bottom).offset(FitSize(12.0f));
        make.left.width.height.equalTo(weakself.phoneLabel);
    }];
    [self.locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-spaceX);
        make.centerY.equalTo(weakself.messageBGView);
        make.height.width.mas_equalTo(FitSize(25.0f));
        
    }];
    
}
- (void)dealloc{
    [TIMER_SERVICE_INSTANCE removeListener:self];
}
#pragma mark-----懒加载
- (UIImageView *)iconImageView{
    
    if (_iconImageView == nil) {
        
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.image = [UIImage imageNamed:@"touxiang"];
    }
    
    return _iconImageView;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = ZYFontSize(15.0f);
        _nameLabel.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
    }
    return _nameLabel;
}
- (UILabel *)countdownLabel{
    if (_countdownLabel == nil) {
        _countdownLabel = [[UILabel alloc]init];
        _countdownLabel.font = ZYFontSize(11.0f);
        _countdownLabel.textColor = [UIColor chains_colorWithHexString:kThemeColor alpha:1.0f];
        _countdownLabel.textAlignment = NSTextAlignmentRight;
    }
    return _countdownLabel;
}
- (UIView *)messageBGView{
    
    if (_messageBGView == nil) {
        _messageBGView = [[UIView alloc]init];
        _messageBGView.backgroundColor = [UIColor chains_colorWithHexString:@"#fbfbfb" alpha:1.0f];
    }
    return _messageBGView;
}
- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = ZYFontSize(13.0f);
        _timeLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
    }
    return _timeLabel;
}
- (UIButton *)editMesButton{
    
    if (_editMesButton == nil) {
        
        _editMesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _editMesButton.layer.borderColor = [UIColor chains_colorWithHexString:kThemeColor alpha:1.0f].CGColor;
        _editMesButton.layer.borderWidth = FitSize(1.0f);
        _editMesButton.titleLabel.font = ZYFontSize(14.0f);
        [_editMesButton setTitleColor:[UIColor chains_colorWithHexString:kThemeColor alpha:1.0f] forState:UIControlStateNormal];
        [_editMesButton addTarget:self action:@selector(customButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_editMesButton setTitle:@"修改信息" forState:UIControlStateNormal];
        _editMesButton.tag = 2000;
    }
    return _editMesButton;
}
- (UIButton *)sureButton{
    
    if (_sureButton == nil) {
        
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.backgroundColor = [UIColor chains_colorWithHexString:kThemeColor alpha:1.0f];
        _sureButton.titleLabel.font = ZYFontSize(14.0f);
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(customButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_sureButton setTitle:@"确认取件" forState:UIControlStateNormal];
        _sureButton.tag = 3000;
    }
    return _sureButton;
}
- (UILabel *)phoneLabel{
    if (_phoneLabel == nil) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.font = ZYFontSize(13.0f);
        _phoneLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
    }
    return _phoneLabel;
}
- (UILabel *)addressLabel{
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.font = ZYFontSize(13.0f);
        _addressLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
    }
    return _addressLabel;
}
- (UIButton *)locationButton{
    
    if (_locationButton == nil) {
        
        _locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_locationButton setImage:[UIImage imageNamed:@"dibiaoimg"] forState:UIControlStateNormal];
        [_locationButton addTarget:self action:@selector(customButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _locationButton.tag = 1000;
    }
    return _locationButton;
}
@end
