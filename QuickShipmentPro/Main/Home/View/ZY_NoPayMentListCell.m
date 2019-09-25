//
//  ZY_NoPayMentListCell.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/10.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_NoPayMentListCell.h"
#import "ZY_LoansSettlementModel.h"
@interface ZY_NoPayMentListCell()
@property(strong,nonatomic)UIButton *selectButton;
@property(strong,nonatomic)UIImageView *iconImageView;
@property(strong,nonatomic)UILabel *nameLabel;
@property(strong,nonatomic)UIView *orderBGView;
@property(strong,nonatomic)UIView *lineView;
@property(strong,nonatomic)UILabel *orderLabel;
@property(strong,nonatomic)UILabel *timeLabel;
@property(strong,nonatomic)UIView *messageBGView;
@property(strong,nonatomic)UILabel *phoneLabel;
@property(strong,nonatomic)UILabel *addressLabel;
@property(strong,nonatomic)UIButton *locationButton;

@end
@implementation ZY_NoPayMentListCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = FitSize(5.0f);
        self.clipsToBounds = YES;
        [self addSubview:self.selectButton];
        [self addSubview:self.iconImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.orderBGView];
        [self addSubview:self.lineView];
        [self addSubview:self.messageBGView];
        [self.orderBGView addSubview:self.orderLabel];
        [self.orderBGView addSubview:self.timeLabel];
        [self.messageBGView addSubview:self.phoneLabel];
        [self.messageBGView addSubview:self.addressLabel];
        [self.messageBGView addSubview:self.locationButton];
    }
    return self;
}
- (void)setLocansSettlementObj:(ZY_LoansSettlementModel *)locansSettlementObj{
    self.selectButton.selected = locansSettlementObj.isSelected;
    self.nameLabel.text = [NSString stringWithFormat:@"%@",locansSettlementObj.fromname];
    self.orderLabel.text = [NSString stringWithFormat:@"快递单号：%@",locansSettlementObj.number];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",locansSettlementObj.createtime];
    
    NSString *phoneSting = [NSString stringWithFormat:@" %@",locansSettlementObj.fromtel];
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:phoneSting];
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    attchImage.image = [UIImage imageNamed:@"telphone"];
    attchImage.bounds = CGRectMake(0,-FitSize(5.0f),FitSize(20.0f),FitSize(20.0f));
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
    [attriStr insertAttributedString:stringImage atIndex:0];
    self.phoneLabel.attributedText = attriStr;
    
    NSString *addressSting = [NSString stringWithFormat:@" %@",locansSettlementObj.fromaddress];
    
    NSMutableAttributedString *addressattriStr = [[NSMutableAttributedString alloc] initWithString:addressSting];
    NSTextAttachment *addressattchImage = [[NSTextAttachment alloc] init];
    addressattchImage.image = [UIImage imageNamed:@"daiqujianadreimg"];
    addressattchImage.bounds = CGRectMake(0,-FitSize(5.0f),FitSize(20.0f),FitSize(20.0f));
    NSAttributedString *addressattchstringImage = [NSAttributedString attributedStringWithAttachment:addressattchImage];
    [addressattriStr insertAttributedString:addressattchstringImage atIndex:0];
    self.addressLabel.attributedText = addressattriStr;
}
- (void)customButtonAction:(UIButton *)sender{
    
    if (self.locationNavButtonBlock) {
        self.locationNavButtonBlock(sender);
    }
}
#pragma mark-------布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    WeakSelf(self);
    CGFloat spaceX = FitSize(14.0f);
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakself);
        make.height.mas_equalTo(FitSize(44.0f));
        make.width.mas_equalTo(FitSize(34.0f));
        
    }];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FitSize(5.0f));
        make.left.equalTo(weakself.selectButton.mas_right);
        make.height.width.mas_equalTo(FitSize(36.0f));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(weakself.iconImageView);
        make.left.equalTo(weakself.iconImageView.mas_right).offset(FitSize(8.0f));
        make.width.mas_equalTo(FitSize(200.0f));
    }];
    [self.orderBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.selectButton.mas_bottom);
        make.left.width.equalTo(weakself);
        make.height.mas_equalTo(FitSize(30.5f));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(weakself.orderBGView);
        make.top.equalTo(weakself.orderBGView.mas_bottom);
        make.height.mas_equalTo(FitSize(0.5f));
        
    }];
    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(weakself.orderBGView);
        make.left.mas_equalTo(spaceX);
        make.width.mas_equalTo(FitSize(260.0f));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(weakself.orderBGView);
        make.right.mas_equalTo(-spaceX);
        make.width.mas_equalTo(FitSize(100.0f));
    }];
    [self.messageBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.equalTo(weakself);
        make.top.equalTo(weakself.lineView.mas_bottom);
        make.height.mas_equalTo(FitSize(90.0f));
        
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
- (void)selectedButtonAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (self.selectedGoodsButtonBlock) {
        self.selectedGoodsButtonBlock(sender.selected);
    }
}
#pragma mark-----懒加载
- (UIButton *)selectButton{
    
    if (_selectButton == nil) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:[UIImage imageNamed:@"paynoseleled"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"payseleled"] forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(selectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _selectButton;
}
- (UIImageView *)iconImageView{
    
    if (_iconImageView == nil) {
        
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.image = [UIImage imageNamed:@"touxiang"];
    }
    
    return _iconImageView;
}
- (UIView *)orderBGView{
    
    if (_orderBGView == nil) {
        _orderBGView = [[UIView alloc]init];
        _orderBGView.backgroundColor = [UIColor chains_colorWithHexString:@"#fbfbfb" alpha:1.0f];
    }
    return _orderBGView;
}
- (UIView *)lineView{
    
    if (_lineView == nil) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor chains_colorWithHexString:@"#ebebeb" alpha:1.0f];
    }
    return _lineView;
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
- (UILabel *)orderLabel{
    if (_orderLabel == nil) {
        _orderLabel = [[UILabel alloc]init];
        _orderLabel.font = ZYFontSize(12.0f);
        _orderLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
        
    }
    return _orderLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = ZYFontSize(12.0f);
        _timeLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
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
