//
//  ZY_SendPieceListCell.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/29.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_SendPieceListCell.h"
#import "ZY_SendPieceListModel.h"

@interface ZY_SendPieceListCell()
@property(strong,nonatomic)UIButton *phoneButton;
@property(strong,nonatomic)UILabel *nameLabel;
@property(strong,nonatomic)UILabel *timeLabel;
@property(strong,nonatomic)UIView *bgView;
@property(strong,nonatomic)UILabel *originLabel;
@property(strong,nonatomic)UILabel *destinationLabel;
@property(strong,nonatomic)UILabel *orderLabel;
@property(strong,nonatomic)UIView *lineView;
@property(strong,nonatomic)UILabel *statusLabel;
@property(strong,nonatomic)UIButton *customButton;

@end

@implementation ZY_SendPieceListCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.layer.cornerRadius = FitSize(5.0f);
        [self addSubview:self.phoneButton];
        [self addSubview:self.nameLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.bgView];
        [self addSubview:self.customButton];
        [self.bgView addSubview:self.originLabel];
        [self.bgView addSubview:self.destinationLabel];
        [self.bgView addSubview:self.orderLabel];
        [self.bgView addSubview:self.lineView];
        [self.bgView addSubview:self.statusLabel];
        
    }
    return self;
}
- (void)setSendPieceListObj:(ZY_SendPieceListModel *)sendPieceListObj{
    
    NSString *fromAddress = [NSString stringWithFormat:@"%@",sendPieceListObj.eforcesOrder.fromprovincename];
    NSString *fromName = [NSString stringWithFormat:@"%@",sendPieceListObj.eforcesOrder.fromname];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@",fromName];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",sendPieceListObj.createtime];
    [self.customButton setTitle:@"派件" forState:UIControlStateNormal];
    
    NSString *oriTotalStr = [NSString stringWithFormat:@"%@\n%@",fromAddress,fromName];
    
    NSMutableAttributedString *string = [oriTotalStr zy_changeFontArr:@[ZYFontSize(14.0f),ZYFontSize(12.0f)] ColorArr:@[kDarkColor,kGrayColor] TotalString:oriTotalStr SubStringArray:@[fromAddress,fromName] Alignment:2 Space:FitSize(3.0f)];
    self.originLabel.attributedText = string;
    
    self.orderLabel.text = [NSString stringWithFormat:@"%@",sendPieceListObj.billsnumber];
    self.statusLabel.text = [NSString stringWithFormat:@"运费：%@元  货款：%@元",sendPieceListObj.amount,sendPieceListObj.bz];
    
    NSString *endArress = [NSString stringWithFormat:@"%@",sendPieceListObj.eforcesOrder.toprovincename];
    NSString *endName = [NSString stringWithFormat:@"%@",sendPieceListObj.eforcesOrder.toname];
    NSString *destinationString = [NSString stringWithFormat:@"%@\n%@",endArress,endName];
    NSMutableAttributedString *destString = [destinationString zy_changeFontArr:@[ZYFontSize(14.0f),ZYFontSize(12.0f)] ColorArr:@[kDarkColor,kGrayColor] TotalString:destinationString SubStringArray:@[endArress,endName] Alignment:0 Space:FitSize(3.0f)];
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
        make.width.mas_equalTo(FitSize(125.0f));
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.phoneButton.mas_bottom).offset(FitSize(6.0f));
        make.left.width.equalTo(weakself);
        make.height.mas_equalTo(FitSize(90.0f));
    }];
    
    [self.customButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-spaceX);
        make.top.equalTo(weakself.bgView.mas_bottom).offset(FitSize(10.0f));
        make.height.mas_equalTo(FitSize(27.0f));
        make.width.mas_equalTo(FitSize(64.0f));
        
    }];
    [self.originLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(FitSize(20.0f));
        make.top.height.equalTo(weakself.bgView);
        make.width.mas_equalTo(FitSize(60.0f));
    }];
    [self.destinationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-FitSize(20.0f));
        make.top.height.width.equalTo(weakself.originLabel);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakself.bgView);
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
#pragma mark---点击事件
- (void)customButtonAction:(UIButton *)sender{
    //1000 电话 2000派件
    if (self.customButtonActionBlock) {
        self.customButtonActionBlock(sender.tag);
    }

}
#pragma mark-----懒加载
- (UIButton *)phoneButton{
    
    if (_phoneButton == nil) {
        _phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneButton setImage:[UIImage imageNamed:@"telphone"] forState:UIControlStateNormal];
        _phoneButton.tag = 1000;
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
- (UIView *)bgView{
    
    if (_bgView == nil) {
        
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor chains_colorWithHexString:@"#fbfbfb" alpha:1.0f];
    }
    return _bgView;
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
- (UIButton *)customButton{
    
    if (_customButton == nil) {
        
        _customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _customButton.layer.borderColor = [UIColor chains_colorWithHexString:kThemeColor alpha:1.0f].CGColor;
        _customButton.layer.borderWidth = FitSize(1.0f);
        _customButton.titleLabel.font = ZYFontSize(14.0f);
        _customButton.tag = 2000;
        [_customButton setTitleColor:[UIColor chains_colorWithHexString:kThemeColor alpha:1.0f] forState:UIControlStateNormal];
        [_customButton addTarget:self action:@selector(customButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _customButton;
}

@end
