//
//  ZY_PerformanceSenderPieceCell.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/30.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_PerformanceSenderPieceCell.h"
#import "ZY_MyPerformanceModel.h"
@interface ZY_PerformanceSenderPieceCell()
@property(strong,nonatomic)UIButton *phoneButton;
@property(strong,nonatomic)UILabel *nameLabel;
@property(strong,nonatomic)UILabel *timeLabel;
@property(strong,nonatomic)UIView *sapceView;
@property(strong,nonatomic)UILabel *originLabel;
@property(strong,nonatomic)UILabel *destinationLabel;
@property(strong,nonatomic)UILabel *orderLabel;
@property(strong,nonatomic)UIView *lineView;
@property(strong,nonatomic)UILabel *statusLabel;
@end
@implementation ZY_PerformanceSenderPieceCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.layer.cornerRadius = FitSize(5.0f);
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.phoneButton];
        [self addSubview:self.nameLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.sapceView];
        [self addSubview:self.originLabel];
        [self addSubview:self.destinationLabel];
        [self addSubview:self.orderLabel];
        [self addSubview:self.lineView];
        [self addSubview:self.statusLabel];
        
    }
    return self;
}
- (void)setSendPieceListObj:(ZY_MyPerformanceModel *)sendPieceListObj{

    
    NSString *fromAddress = [NSString stringWithFormat:@"%@",sendPieceListObj.fromprovincename];
    NSString *fromName = [NSString stringWithFormat:@"%@",sendPieceListObj.fromname];

    self.nameLabel.text = [NSString stringWithFormat:@"%@",fromName];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",sendPieceListObj.createtime];
  
    NSString *oriTotalStr = [NSString stringWithFormat:@"%@\n%@",fromAddress,fromName];
    
    NSMutableAttributedString *string = [oriTotalStr zy_changeFontArr:@[ZYFontSize(14.0f),ZYFontSize(12.0f)] ColorArr:@[kDarkColor,kGrayColor] TotalString:oriTotalStr SubStringArray:@[fromAddress,fromName] Alignment:2 Space:FitSize(3.0f)];
    self.originLabel.attributedText = string;
    
    self.orderLabel.text = [NSString stringWithFormat:@"%@",sendPieceListObj.number];
    self.statusLabel.text = [NSString stringWithFormat:@"运费：%@元  货款：%@元",sendPieceListObj.price,sendPieceListObj.modeprice];
    
    NSString *endddAddress = [NSString stringWithFormat:@"%@",sendPieceListObj.toaddress];
    NSString *endddName = [NSString stringWithFormat:@"%@",sendPieceListObj.toname];
    NSString *destinationString = [NSString stringWithFormat:@"%@\n%@",endddAddress,endddName];
    NSMutableAttributedString *destString = [destinationString zy_changeFontArr:@[ZYFontSize(14.0f),ZYFontSize(12.0f)] ColorArr:@[kDarkColor,kGrayColor] TotalString:destinationString SubStringArray:@[endddAddress,endddName] Alignment:0 Space:FitSize(3.0f)];
    self.destinationLabel.attributedText = destString;
    
}
#pragma mark-------布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    WeakSelf(self);
    CGFloat spaceX = FitSize(14.0f);
    
    [self.phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FitSize(7.0f));
        make.left.mas_equalTo(FitSize(17.0f));
        make.height.width.mas_equalTo(FitSize(32.0f));
        
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.phoneButton.mas_right).offset(FitSize(9.0f));
        make.top.height.equalTo(weakself.phoneButton);
        make.width.mas_equalTo(FitSize(160.0f));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-spaceX);
        make.top.height.equalTo(weakself.phoneButton);
        make.width.mas_equalTo(FitSize(100.0f));
    }];
    
    [self.sapceView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(weakself.phoneButton.mas_bottom).offset(FitSize(5.0f));
        make.left.width.equalTo(weakself);
        make.height.mas_equalTo(FitSize(6.0f));
    }];

    [self.originLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(FitSize(30.0f));
        make.top.equalTo(weakself.sapceView.mas_bottom);
        make.height.mas_equalTo(FitSize(77.0f));
        make.width.mas_equalTo(FitSize(60.0f));
    }];
    [self.destinationLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.mas_equalTo(-FitSize(30.0f));
        make.top.height.width.equalTo(weakself.originLabel);

    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {

         make.top.equalTo(weakself.sapceView.mas_bottom).offset(FitSize(40.0f));
        make.left.equalTo(weakself.originLabel.mas_right).offset(FitSize(10.0f));
        make.right.equalTo(weakself.destinationLabel.mas_left).offset(-FitSize(10.0f));
        make.height.mas_equalTo(FitSize(1.0f));

    }];

    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.width.equalTo(weakself.lineView);
        make.bottom.equalTo(weakself.lineView.mas_top);
        make.height.mas_equalTo(FitSize(27.0f));
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.width.height.equalTo(weakself.orderLabel);
        make.top.equalTo(weakself.lineView.mas_bottom);

    }];
}
- (void)customButtonAction:(UIButton *)sender{
    
    
    
}
#pragma mark-----懒加载
- (UIButton *)phoneButton{
    
    if (_phoneButton == nil) {
        _phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneButton setImage:[UIImage imageNamed:@"messageimg"] forState:UIControlStateNormal];
        [_phoneButton addTarget:self action:@selector(customButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneButton;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = ZYFontSize(14.0f);
        _nameLabel.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
    }
    return _nameLabel;
}
- (UILabel *)timeLabel{
    
    if (_timeLabel == nil) {
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = ZYFontSize(12.0f);
        _timeLabel.textColor = [UIColor chains_colorWithHexString:@"#b7b7b7" alpha:1.0f];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _timeLabel;
}
- (UIView *)sapceView{
    
    if (_sapceView == nil) {
        
        _sapceView = [[UIView alloc]init];
        _sapceView.backgroundColor = [UIColor chains_colorWithHexString:@"#fbfbfb" alpha:1.0f];
    }
    return _sapceView;
}
- (UIView *)lineView{
    
    if (_lineView == nil) {
        
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor chains_colorWithHexString:@"#e4e4e4" alpha:1.0f];
    }
    return _lineView;
}
- (UILabel *)originLabel{
    
    if (_originLabel == nil) {
        
        _originLabel = [[UILabel alloc]init];
        _originLabel.numberOfLines = 0;
        
    }
    return _originLabel;
}
- (UILabel *)destinationLabel{
    
    if (_destinationLabel == nil) {
        
        _destinationLabel = [[UILabel alloc]init];
        _destinationLabel.numberOfLines = 0;
    }
    return _destinationLabel;
}
- (UILabel *)orderLabel{
    
    if (_orderLabel == nil) {
        
        _orderLabel = [[UILabel alloc]init];
        _orderLabel.font = ZYFontSize(12.0f);
        _orderLabel.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
        _orderLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _orderLabel;
}
- (UILabel *)statusLabel{
    
    if (_statusLabel == nil) {
        
        _statusLabel = [[UILabel alloc]init];
        _statusLabel.font = ZYFontSize(12.0f);
        _statusLabel.textColor = [UIColor chains_colorWithHexString:kThemeColor alpha:1.0f];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _statusLabel;
}

@end
