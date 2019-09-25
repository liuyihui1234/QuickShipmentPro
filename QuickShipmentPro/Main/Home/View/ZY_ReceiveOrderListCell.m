//
//  ZY_ReceiveOrderListCell.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/27.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_ReceiveOrderListCell.h"
#import "ZY_ReceiveOrderListModel.h"
@interface ZY_ReceiveOrderListCell()
@property(strong,nonatomic)UIImageView *iconImageView;
@property(strong,nonatomic)UILabel *nameLabel;
@property(strong,nonatomic)UILabel *timeLabel;
@property(strong,nonatomic)UIView *messageBGView;
@property(strong,nonatomic)UILabel *phoneLabel;
@property(strong,nonatomic)UILabel *addressLabel;
@property(strong,nonatomic)UIButton *locationButton;
@property(strong,nonatomic)UIButton *customButton;
@end
@implementation ZY_ReceiveOrderListCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = FitSize(5.0f);
        [self addSubview:self.iconImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.messageBGView];
        [self addSubview:self.timeLabel];
        [self addSubview:self.customButton];
        [self.messageBGView addSubview:self.phoneLabel];
        [self.messageBGView addSubview:self.addressLabel];
        [self.messageBGView addSubview:self.locationButton];
    
    }
    return self;
}
- (void)setReceiveOrderListObj:(ZY_ReceiveOrderListModel *)receiveOrderListObj{

    self.nameLabel.text = [NSString stringWithFormat:@"%@",receiveOrderListObj.fromname];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",receiveOrderListObj.appointmenttime];
   

    NSString *phoneSting = [NSString stringWithFormat:@"  %@",receiveOrderListObj.fromtel];

    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:phoneSting];
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    attchImage.image = [UIImage imageNamed:@"telphone"];
    attchImage.bounds = CGRectMake(0,-FitSize(5.0f),FitSize(20.0f),FitSize(20.0f));
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
    [attriStr insertAttributedString:stringImage atIndex:0];
    self.phoneLabel.attributedText = attriStr;
    
    NSString *addressSting = [NSString stringWithFormat:@"  %@",receiveOrderListObj.fromaddress];
    
    NSMutableAttributedString *addressattriStr = [[NSMutableAttributedString alloc] initWithString:addressSting];
    NSTextAttachment *addressattchImage = [[NSTextAttachment alloc] init];
    addressattchImage.image = [UIImage imageNamed:@"daiqujianadreimg"];
    addressattchImage.bounds = CGRectMake(0,-FitSize(5.0f),FitSize(20.0f),FitSize(20.0f));
    NSAttributedString *addressattchstringImage = [NSAttributedString attributedStringWithAttachment:addressattchImage];
    [addressattriStr insertAttributedString:addressattchstringImage atIndex:0];
    self.addressLabel.attributedText = addressattriStr;
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
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(weakself.nameLabel);
        make.right.mas_equalTo(-spaceX);
        make.width.mas_equalTo(FitSize(125.0f));
    }];
    [self.messageBGView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.width.equalTo(weakself);
        make.top.equalTo(weakself.iconImageView.mas_bottom).offset(FitSize(5.0f));
        make.height.mas_equalTo(FitSize(90.0f));
        
    }];
    [self.customButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(-spaceX);
        make.top.equalTo(weakself.messageBGView.mas_bottom).offset(FitSize(9.0f));
        make.height.mas_equalTo(FitSize(27.0f));
        make.width.mas_equalTo(FitSize(68.0f));
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
#pragma mark-----懒加载
- (UIImageView *)iconImageView{
    
    if (_iconImageView == nil) {
        
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.layer.cornerRadius = FitSize(18.0f);
        _iconImageView.clipsToBounds = YES;
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
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}
- (UIButton *)customButton{
    
    if (_customButton == nil) {
        
        _customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _customButton.layer.borderColor = [UIColor chains_colorWithHexString:kThemeColor alpha:1.0f].CGColor;
        _customButton.layer.borderWidth = FitSize(1.0f);
        _customButton.titleLabel.font = ZYFontSize(14.0f);
        [_customButton setTitleColor:[UIColor chains_colorWithHexString:kThemeColor alpha:1.0f] forState:UIControlStateNormal];
        [_customButton addTarget:self action:@selector(customButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _customButton.tag = 2000;
        [_customButton setTitle:@"接单" forState:UIControlStateNormal];
    }
    return _customButton;
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
