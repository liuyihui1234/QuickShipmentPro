//
//  ZY_MineMessageHeaderView.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/10.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_MineMessageHeaderView.h"
@interface ZY_MineMessageHeaderView()
@property(strong,nonatomic)UIImageView *bgImageView;
@property(strong,nonatomic)UIView *bgView;
@property(strong,nonatomic)UILabel *themeLabel;
@property(strong,nonatomic)UILabel *messageLabel;
@property(strong,nonatomic)UIView *lineView;
@property(strong,nonatomic)ZYCustomButton *printerButton;

@end

@implementation ZY_MineMessageHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bgImageView];
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.themeLabel];
        [self.bgView addSubview:self.messageLabel];
        [self.bgView addSubview:self.lineView];
        [self.bgView addSubview:self.printerButton];
    }
    return self;
}
#pragma mark-------布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    WeakSelf(self);
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(weakself);
        make.height.mas_equalTo(FitSize(150.0f));
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself);
        make.top.mas_equalTo(FitSize(64.0f));
        make.width.mas_equalTo(KSCREEN_WIDTH-FitSize(24.0f));
        make.height.mas_equalTo(FitSize(125.0f));
        
    }];
    [self.themeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FitSize(23.0f));
        make.top.equalTo(weakself.bgView);
        make.height.mas_equalTo(FitSize(54.0f));
        make.width.mas_equalTo(FitSize(120.0f));
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-FitSize(18.0f));
        make.top.height.equalTo(weakself.themeLabel);
        make.width.mas_equalTo(FitSize(220.0f));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.width.equalTo(weakself.bgView);
        make.top.equalTo(weakself.themeLabel.mas_bottom);
        make.height.mas_equalTo(FitSize(0.5f));
    }];
    [self.printerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.bgView);
        make.top.equalTo(weakself.lineView.mas_bottom);
        make.height.mas_equalTo(FitSize(65.0f));
        make.width.mas_equalTo(FitSize(160.0f));
    }];
}
- (void)setPriterName:(NSString *)priterName{
    
    self.messageLabel.text = priterName;

}
- (void)setIconImageUrl:(NSString *)iconImageUrl{
    
    if (iconImageUrl.length != 0) {
        
    NSData *data = [NSData  dataWithContentsOfURL:[NSURL URLWithString:iconImageUrl]];
    UIImage *imageV =  [UIImage imageWithData:data];
    UIImage *image = [ZYTools boxblurImage:imageV withBlurNumber:0.8];
    self.bgImageView.image = image;
    }
}
#pragma mark----扫描打印机事件
- (void)printerButtonClick:(ZYCustomButton *)sender{
    
    if (self.scanningPrinterButtonBlock) {
        self.scanningPrinterButtonBlock();
    }
    
}
#pragma mark----懒加载
- (UIImageView *)bgImageView{
    
    if (_bgImageView == nil) {
        
        _bgImageView = [[UIImageView alloc]init];
        //_bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _bgImageView;
}
- (UIView *)bgView{
    
    if (_bgView == nil) {
        
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = FitSize(5.0f);
        // 阴影颜色
        _bgView.layer.shadowColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f].CGColor;
        // 阴影偏移，默认(0, -3)
        _bgView.layer.shadowOffset = CGSizeMake(FitSize(1.0f),FitSize(1.0f));
        // 阴影透明度，默认0
        _bgView.layer.shadowOpacity = FitSize(0.5f);
        // 阴影半径，默认3
        _bgView.layer.shadowRadius = FitSize(3.0f);
    }
    return _bgView;
}
- (UILabel *)themeLabel{
    if (_themeLabel == nil) {
        
        _themeLabel = [[UILabel alloc]init];
        _themeLabel.font = ZYFontSize(15.0f);
        _themeLabel.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
        _themeLabel.text = @"打印机状态：";
    }
    return _themeLabel;
}
- (UIView *)lineView{
    
    if (_lineView == nil) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor chains_colorWithHexString:kLineColor alpha:1.0f];
    }
    return _lineView;
}
- (UILabel *)messageLabel{
    if (_messageLabel == nil) {
        
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.font = ZYFontSize(14.0f);
        _messageLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
        _messageLabel.textAlignment = NSTextAlignmentRight;
    }
    return _messageLabel;
}
- (ZYCustomButton *)printerButton{
    if (_printerButton == nil) {
        
        _printerButton = [ZYCustomButton buttonWithType:UIButtonTypeCustom];
        [_printerButton setTitleColor:[UIColor chains_colorWithHexString:kThemeColor alpha:1.0f] forState:UIControlStateNormal];
        _printerButton.titleLabel.font = ZYFontSize(16.0f);
        _printerButton.zy_spacing = FitSize(5.0f);
        [_printerButton addTarget:self action:@selector(printerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _printerButton.zy_buttonType = ZYCustomButtonImageLeft;
        [_printerButton setImage:[UIImage imageNamed:@"dayinjiimg"] forState:UIControlStateNormal];
        [_printerButton setTitle:@"扫描打印机" forState:UIControlStateNormal];
    }
    
    return _printerButton;
}

@end
