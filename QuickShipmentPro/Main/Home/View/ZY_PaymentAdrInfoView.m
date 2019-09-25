//
//  ZY_PaymentAdrInfoView.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/12.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_PaymentAdrInfoView.h"
#import "ZY_PaymentInfoModel.h"
@interface ZY_PaymentAdrInfoView()
@property(strong,nonatomic)UILabel *orderLabel;
@property(strong,nonatomic)UIImageView *sendImageView;
@property(strong,nonatomic)UILabel *pointLabel;
@property(strong,nonatomic)UIImageView *receiveImageView;
@property(strong,nonatomic)UILabel *sendNameLabel;
@property(strong,nonatomic)UILabel *sendPhoneLabel;
@property(strong,nonatomic)UILabel *sendAddressLabel;
@property(strong,nonatomic)UIView *lineView;
@property(strong,nonatomic)UILabel *receiveNameLabel;
@property(strong,nonatomic)UILabel *receivePhoneLabel;
@property(strong,nonatomic)UILabel *receiveAddressLabel;
@end

@implementation ZY_PaymentAdrInfoView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = FitSize(5.0f);
        [self addSubview:self.orderLabel];
        [self addSubview:self.sendImageView];
        [self addSubview:self.pointLabel];
        [self addSubview:self.receiveImageView];
        [self addSubview:self.sendNameLabel];
        [self addSubview:self.sendPhoneLabel];
        [self addSubview:self.sendAddressLabel];
        [self addSubview:self.lineView];
        [self addSubview:self.receiveNameLabel];
        [self addSubview:self.receivePhoneLabel];
        [self addSubview:self.receiveAddressLabel];
    }
    return self;
}
- (void)setPaymentInfoObj:(ZY_PaymentInfoModel *)paymentInfoObj{
 
    self.orderLabel.text = [NSString stringWithFormat:@"快递单号：%@",paymentInfoObj.number];
 
    NSString *sendNameStr = [NSString stringWithFormat:@"%@",paymentInfoObj.sendName];
    NSString *destinationString = [NSString stringWithFormat:@"姓名：%@",sendNameStr];
    
    NSMutableAttributedString *destString = [destinationString zy_changeFontArr:@[ZYFontSize(13.0f)] ColorArr:@[@"#1b2337"] TotalString:destinationString SubStringArray:@[sendNameStr] Alignment:0 Space:0.0f];
    self.sendNameLabel.attributedText = destString;
 
    NSString *sendphoneStr = [NSString stringWithFormat:@"%@",paymentInfoObj.sendPhone];
    NSString *phoneTotalString = [NSString stringWithFormat:@"电话：%@",sendphoneStr];
    NSMutableAttributedString *phoneString = [phoneTotalString zy_changeFontArr:@[ZYFontSize(13.0f)] ColorArr:@[@"#1b2337"] TotalString:phoneTotalString SubStringArray:@[sendphoneStr] Alignment:0 Space:0.0f];
    self.sendPhoneLabel.attributedText = phoneString;
    
    NSString *sendaddressStr = [NSString stringWithFormat:@"%@",paymentInfoObj.sendAddress];
    NSString *addressTotalString = [NSString stringWithFormat:@"地址：%@",sendaddressStr];
    NSMutableAttributedString *addressString = [addressTotalString zy_changeFontArr:@[ZYFontSize(13.0f)] ColorArr:@[@"#1b2337"] TotalString:addressTotalString SubStringArray:@[sendaddressStr] Alignment:0 Space:0.0f];
    self.sendAddressLabel.attributedText = addressString;
    
    NSString *receivenameStr = [NSString stringWithFormat:@"%@",paymentInfoObj.receiveName];
    NSString *receivenameString = [NSString stringWithFormat:@"姓名：%@",receivenameStr];
    NSMutableAttributedString *receiveNameAtt = [receivenameString zy_changeFontArr:@[ZYFontSize(13.0f)] ColorArr:@[@"#1b2337"] TotalString:receivenameString SubStringArray:@[receivenameStr] Alignment:0 Space:0.0f];
    self.receiveNameLabel.attributedText = receiveNameAtt;

    NSString *receivephoneStr = [NSString stringWithFormat:@"%@",paymentInfoObj.receivePhone];
    NSString *receivephoneString = [NSString stringWithFormat:@"电话：%@",receivephoneStr];
    NSMutableAttributedString *receivephoneAtt = [receivephoneString zy_changeFontArr:@[ZYFontSize(13.0f)] ColorArr:@[@"#1b2337"] TotalString:receivephoneString SubStringArray:@[receivephoneStr] Alignment:0 Space:0.0f];
    self.receivePhoneLabel.attributedText = receivephoneAtt;
    
    NSString *receiveaddressStr = [NSString stringWithFormat:@"%@",paymentInfoObj.receiveAddress];
    NSString *receiveaddressString = [NSString stringWithFormat:@"地址：%@",receiveaddressStr];
    NSMutableAttributedString *receiveaddressAtt = [receiveaddressString zy_changeFontArr:@[ZYFontSize(13.0f)] ColorArr:@[@"#1b2337"] TotalString:receiveaddressString SubStringArray:@[receiveaddressStr] Alignment:0 Space:0.0f];
    self.receiveAddressLabel.attributedText = receiveaddressAtt;
}
#pragma mark-------布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    WeakSelf(self);
    CGFloat spaceX = FitSize(14.0f);
    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself);
        make.left.mas_equalTo(spaceX);
        make.height.mas_equalTo(FitSize(38.0f));
        make.width.mas_equalTo(FitSize(280.0f));
    }];
    [self.sendImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.orderLabel.mas_bottom).offset(FitSize(5.0f));
        make.left.equalTo(weakself.orderLabel);
        make.height.width.mas_equalTo(FitSize(17.0f));
    }];
    [self.receiveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.sendImageView.mas_bottom).offset(FitSize(48.0f));
        make.left.width.height.equalTo(weakself.sendImageView);
       
    }];
    [self.pointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.sendImageView.mas_bottom).offset(FitSize(5.0f));
        make.left.width.equalTo(weakself.sendImageView);
        make.bottom.equalTo(weakself.receiveImageView.mas_top).offset(-FitSize(5.0f));
    }];
    
    [self.sendNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(weakself.sendImageView);
        make.left.equalTo(weakself.sendImageView.mas_right).offset(FitSize(17.0f));
        make.width.mas_equalTo(FitSize(100.0f));
    }];
    [self.sendPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(weakself.sendNameLabel);
        make.left.equalTo(weakself.sendNameLabel.mas_right);
        make.width.mas_equalTo(FitSize(180.0f));
    }];
    [self.sendAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.sendNameLabel.mas_bottom).offset(FitSize(12.0f));
        make.left.height.equalTo(weakself.sendNameLabel);
        make.width.mas_equalTo(FitSize(280.0f));
     
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.width.equalTo(weakself.sendAddressLabel);
        make.top.mas_equalTo(weakself.sendAddressLabel.mas_bottom).offset(FitSize(10.0f));
        make.height.mas_equalTo(FitSize(0.5f));
    }];
    
    [self.receiveNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(weakself.receiveImageView);
        make.left.width.equalTo(weakself.sendNameLabel);
    }];
    [self.receivePhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(weakself.receiveNameLabel);
        make.left.equalTo(weakself.receiveNameLabel.mas_right);
        make.width.equalTo(weakself.sendPhoneLabel);
    }];
    [self.receiveAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.receiveNameLabel.mas_bottom).offset(FitSize(12.0f));
        make.left.height.width.equalTo(weakself.sendAddressLabel);
    }];
}
#pragma mark-----懒加载
- (UILabel *)orderLabel{
    if (_orderLabel == nil) {
        _orderLabel = [[UILabel alloc]init];
        _orderLabel.font = ZYFontSize(12.0f);
        _orderLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
    }
    return _orderLabel;
}
- (UIImageView *)sendImageView{
    
    if (_sendImageView == nil) {
        
        _sendImageView = [[UIImageView alloc]init];
        _sendImageView.contentMode = UIViewContentModeCenter;
        _sendImageView.image = [UIImage imageNamed:@"jijianimg"];
    }
    return _sendImageView;
}
- (UILabel *)pointLabel{
    if (_pointLabel == nil) {
        _pointLabel = [[UILabel alloc]init];
        _pointLabel.font = ZYFontSize(15.0f);
        _pointLabel.textColor = [UIColor chains_colorWithHexString:kThemeColor alpha:1.0f];
        _pointLabel.numberOfLines = 0;
        _pointLabel.textAlignment = NSTextAlignmentCenter;
        _pointLabel.text = @"·\n·\n";
    }
    return _pointLabel;
}
- (UIImageView *)receiveImageView{
    
    if (_receiveImageView == nil) {
        
        _receiveImageView = [[UIImageView alloc]init];
        _receiveImageView.contentMode = UIViewContentModeCenter;
        _receiveImageView.image = [UIImage imageNamed:@"shoujianimg"];
    }
    return _receiveImageView;
}
- (UILabel *)sendNameLabel{
    if (_sendNameLabel == nil) {
        _sendNameLabel = [[UILabel alloc]init];
        _sendNameLabel.font = ZYFontSize(13.0f);
        _sendNameLabel.textColor = [UIColor chains_colorWithHexString:kDarkGrayColor alpha:1.0f];
    }
    return _sendNameLabel;
}
- (UILabel *)sendPhoneLabel{
    if (_sendPhoneLabel == nil) {
        _sendPhoneLabel = [[UILabel alloc]init];
        _sendPhoneLabel.font = ZYFontSize(13.0f);
        _sendPhoneLabel.textColor = [UIColor chains_colorWithHexString:kDarkGrayColor alpha:1.0f];
    }
    return _sendPhoneLabel;
}
- (UILabel *)sendAddressLabel{
    if (_sendAddressLabel == nil) {
        _sendAddressLabel = [[UILabel alloc]init];
        _sendAddressLabel.font = ZYFontSize(13.0f);
        _sendAddressLabel.textColor = [UIColor chains_colorWithHexString:kDarkGrayColor alpha:1.0f];
    }
    return _sendAddressLabel;
}

- (UILabel *)receiveNameLabel{
    if (_receiveNameLabel == nil) {
        _receiveNameLabel = [[UILabel alloc]init];
        _receiveNameLabel.font = ZYFontSize(13.0f);
        _receiveNameLabel.textColor = [UIColor chains_colorWithHexString:kDarkGrayColor alpha:1.0f];
    }
    return _receiveNameLabel;
}
- (UILabel *)receivePhoneLabel{
    if (_receivePhoneLabel == nil) {
        _receivePhoneLabel = [[UILabel alloc]init];
        _receivePhoneLabel.font = ZYFontSize(13.0f);
        _receivePhoneLabel.textColor = [UIColor chains_colorWithHexString:kDarkGrayColor alpha:1.0f];
    }
    return _receivePhoneLabel;
}
- (UILabel *)receiveAddressLabel{
    if (_receiveAddressLabel == nil) {
        _receiveAddressLabel = [[UILabel alloc]init];
        _receiveAddressLabel.font = ZYFontSize(13.0f);
        _receiveAddressLabel.textColor = [UIColor chains_colorWithHexString:kDarkGrayColor alpha:1.0f];
    }
    return _receiveAddressLabel;
}
- (UIView *)lineView{
    
    if (_lineView == nil) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor chains_colorWithHexString:@"#e6e6e6" alpha:1.0f];
    }
    return _lineView;
}
@end
