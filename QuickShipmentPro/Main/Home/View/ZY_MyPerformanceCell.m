//
//  ZY_MyPerformanceCell.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/30.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_MyPerformanceCell.h"
#import "ZY_MyPerformanceModel.h"

@interface ZY_MyPerformanceCell()
@property(strong,nonatomic)UILabel *orderLabel;
@property(strong,nonatomic)UIView *sapceView;
@property(strong,nonatomic)UILabel *originLabel;
@property(strong,nonatomic)UILabel *destinationLabel;
@property(strong,nonatomic)UILabel *moneyLabel;
@property(strong,nonatomic)UIView *lineView;
@property(strong,nonatomic)UILabel *statusLabel;
@end
@implementation ZY_MyPerformanceCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.layer.cornerRadius = FitSize(5.0f);
        self.backgroundColor = [UIColor whiteColor];
       
        [self addSubview:self.orderLabel];
        [self addSubview:self.sapceView];
        [self addSubview:self.originLabel];
        [self addSubview:self.lineView];
        [self addSubview:self.destinationLabel];
        [self addSubview:self.moneyLabel];
        [self addSubview:self.statusLabel];

    }
    return self;
}

- (void)setMyperformanceObj:(ZY_MyPerformanceModel *)myperformanceObj{
    
    self.orderLabel.text = [NSString stringWithFormat:@"运单号：%@",myperformanceObj.number];
    
    NSString *fromAddress = [NSString stringWithFormat:@"%@",myperformanceObj.fromprovincename];
    NSString *fromName = [NSString stringWithFormat:@"%@",myperformanceObj.fromname];
    
    NSString *oriTotalStr = [NSString stringWithFormat:@"%@\n%@",fromAddress,fromName];
    
    NSMutableAttributedString *string = [oriTotalStr zy_changeFontArr:@[ZYFontSize(14.0f),ZYFontSize(12.0f)] ColorArr:@[kDarkColor,kGrayColor] TotalString:oriTotalStr SubStringArray:@[fromAddress,fromName] Alignment:2 Space:FitSize(3.0f)];
    self.originLabel.attributedText = string;
    self.moneyLabel.text = [NSString stringWithFormat:@"运费：%@元",myperformanceObj.price];
    NSString *enddAddress = [NSString stringWithFormat:@"%@",myperformanceObj.toprovincename];
    NSString *enddName = [NSString stringWithFormat:@"%@",myperformanceObj.toname];
    
    NSString *destinationString = [NSString stringWithFormat:@"%@\n%@",enddAddress,enddName];
    NSMutableAttributedString *destString = [destinationString zy_changeFontArr:@[ZYFontSize(14.0f),ZYFontSize(12.0f)] ColorArr:@[kDarkColor,kGrayColor] TotalString:destinationString SubStringArray:@[enddAddress,enddName] Alignment:0 Space:FitSize(3.0f)];
    self.destinationLabel.attributedText = destString;
}
#pragma mark-------布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    WeakSelf(self);
    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(FitSize(10.0f));
        make.top.equalTo(weakself);
        make.width.mas_equalTo(FitSize(220.0f));
        make.height.mas_equalTo(FitSize(44.0f));
    }];
    [self.sapceView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.orderLabel.mas_bottom);
        make.left.width.equalTo(weakself);
        make.height.mas_equalTo(FitSize(6.0f));
    }];
    
    [self.originLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(FitSize(30.0f));
        make.top.equalTo(weakself.sapceView.mas_bottom);
        make.height.mas_equalTo(FitSize(75.0f));
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
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.equalTo(weakself.lineView);
        make.bottom.equalTo(weakself.lineView.mas_top);
        make.height.mas_equalTo(FitSize(20.0f));
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.height.equalTo(weakself.moneyLabel);
        make.top.equalTo(weakself.lineView.mas_bottom);
        
    }];
}
#pragma mark---懒加载
- (UILabel *)orderLabel{
    
    if (_orderLabel == nil) {
        
        _orderLabel = [[UILabel alloc]init];
        _orderLabel.font = ZYFontSize(13.0f);
        _orderLabel.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
    }
    return _orderLabel;
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
- (UILabel *)moneyLabel{
    
    if (_moneyLabel == nil) {
        
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.font = ZYFontSize(12.0f);
        _moneyLabel.textColor = [UIColor chains_colorWithHexString:kThemeColor alpha:1.0f];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _moneyLabel;
}

- (UILabel *)statusLabel{
    
    if (_statusLabel == nil) {
        
        _statusLabel = [[UILabel alloc]init];
        _statusLabel.font = ZYFontSize(13.0f);
        _statusLabel.textColor = [UIColor chains_colorWithHexString:@"#f24824" alpha:1.0f];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.text = @"已签收";
    }
    return _statusLabel;
}
@end
