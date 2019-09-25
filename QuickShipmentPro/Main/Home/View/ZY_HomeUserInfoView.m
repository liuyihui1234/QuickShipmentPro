//
//  ZY_HomeUserInfoView.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/23.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_HomeUserInfoView.h"
#import "ZY_HomeUserInfoModel.h"
@interface ZY_HomeUserInfoView()
@property(strong,nonatomic)UIView *messageBGView;
@property(strong,nonatomic)UIImageView *iconImageView;
@property(strong,nonatomic)UILabel *nameLabel;
@property(strong,nonatomic)UILabel *telLabel;
@property(strong,nonatomic)UIView *lineView;
@property(strong,nonatomic)ZYCustomButton *locationButton;
@end
@implementation ZY_HomeUserInfoView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = FitSize(5.0f);
        
        [self addSubview:self.messageBGView];
        [self addSubview:self.lineView];
        [self addSubview:self.locationButton];
        
        [self.messageBGView addSubview:self.iconImageView];
        [self.messageBGView addSubview:self.nameLabel];
        [self.messageBGView addSubview:self.telLabel];
        //单击的手势
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        tapRecognize.numberOfTapsRequired = 1;
        [tapRecognize setEnabled :YES];
        [tapRecognize delaysTouchesBegan];
        [self.messageBGView addGestureRecognizer:tapRecognize];
    }
    return self;
}
#pragma mark----赋值
- (void)setHomeUserInfoObj:(ZY_HomeUserInfoModel *)homeUserInfoObj{
   
    [self refreshUserInfoDatasWithInfo:homeUserInfoObj];
}
#pragma mark-------布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    WeakSelf(self);
    CGFloat spaceX = FitSize(15.0f);
    [self.messageBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceX);
        make.centerY.equalTo(weakself);
        make.height.mas_equalTo(FitSize(71.0f));
        make.width.mas_equalTo(FitSize(230.0f));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.messageBGView.mas_right);
        make.top.height.equalTo(weakself);
        make.width.mas_equalTo(FitSize(1.0f));
    }];
    
    [self.locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakself);
        make.left.equalTo(weakself.lineView.mas_right);
        make.width.mas_equalTo(FitSize(100.0f));
        make.height.equalTo(weakself.messageBGView);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.height.equalTo(weakself.messageBGView);
        make.width.mas_equalTo(FitSize(70.0f));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.iconImageView.mas_right).offset(FitSize(12.0f));
        make.top.mas_equalTo(spaceX);
        make.height.mas_equalTo(FitSize(23.0f));
        make.width.mas_equalTo(FitSize(160.0f));
    }];
    [self.telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.equalTo(weakself.nameLabel);
        make.top.equalTo(weakself.nameLabel.mas_bottom).offset(FitSize(5.0f));
        make.height.mas_equalTo(FitSize(16.0f));
    }];
}
- (void)refreshUserInfoDatasWithInfo:(ZY_HomeUserInfoModel *)infoObj{
    
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",infoObj.portraitpath]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    self.nameLabel.text = infoObj.name;
    
    NSString *titleSting = [NSString stringWithFormat:@"%@  ",infoObj.tel];
    
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:titleSting];
    /**
     添加图片到指定的位置
     */
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    // 表情图片
    attchImage.image = [UIImage imageNamed:@"bianjiimg"];
    // 设置图片大小
    attchImage.bounds = CGRectMake(0,-FitSize(1.0f),FitSize(11.0f),FitSize(12.0f));
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
    [attriStr insertAttributedString:stringImage atIndex:titleSting.length];
    
    self.telLabel.attributedText = attriStr;
    
    [self.locationButton setTitle:infoObj.time forState:UIControlStateNormal];

}
#pragma mark---头像按钮事件
- (void)handleTap:(UITapGestureRecognizer *)tapView{
    
    if (self.editUserInfoGestureRecognizerBlock) {
        
        self.editUserInfoGestureRecognizerBlock();
    }
    
}
#pragma mark----自定义按钮事件
- (void)locationButtonAction:(UIButton *)sender{
    if (self.locationButtonClickBlock) {
        self.locationButtonClickBlock(sender);
    }
}
#pragma mark--懒加载
- (UIView *)messageBGView {
    
    if (_messageBGView == nil) {
        _messageBGView = [[UIView alloc]init];
        _messageBGView.backgroundColor = [UIColor clearColor];
        
    }
    return _messageBGView;
}
- (UIImageView *)iconImageView{
    
    if (_iconImageView == nil) {
        
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.layer.cornerRadius = FitSize(3.0f);
        _iconImageView.clipsToBounds = YES;
    }
    return _iconImageView;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = ZYFontSize(16.0f);
        _nameLabel.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
        
    }
    return _nameLabel;
}
- (UILabel *)telLabel{
    if (_telLabel == nil) {
        
        _telLabel = [[UILabel alloc]init];
        _telLabel.font = ZYFontSize(13.0f);
        _telLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
        
    }
    return _telLabel;
}
- (UIView *)lineView{
    
    if (_lineView == nil) {
        
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor chains_colorWithHexString:kBackgroundColor alpha:1.0f];
    }
    
    return _lineView;
}
- (ZYCustomButton *)locationButton{
    
    if (_locationButton == nil) {
        
        _locationButton = [ZYCustomButton buttonWithType:UIButtonTypeCustom];
        [_locationButton setTitleColor:[UIColor chains_colorWithHexString:kGrayColor alpha:1.0f] forState:UIControlStateNormal];
        _locationButton.titleLabel.font = ZYFontSize(11.0f);
        _locationButton.zy_spacing = FitSize(8.0f);
        [_locationButton addTarget:self action:@selector(locationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _locationButton.zy_buttonType = ZYCustomButtonImageTop;
        [_locationButton setImage:[UIImage imageNamed:@"dibiaoimg"] forState:UIControlStateNormal];
    }
    
    return _locationButton;
}
@end
