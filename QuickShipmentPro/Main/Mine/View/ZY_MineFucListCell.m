//
//  ZY_MineFucListCell.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/10.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_MineFucListCell.h"
#import "ZY_MineMessageModel.h"
@interface ZY_MineFucListCell()
@property(strong,nonatomic)UIImageView *iconImageView;
@property(strong,nonatomic)UILabel *titleLabel;
@end

@implementation ZY_MineFucListCell
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.iconImageView];
        [self addSubview:self.titleLabel];
    }
    return self;
}
#pragma mark----赋值
- (void)setMineMessageObj:(ZY_MineMessageModel *)mineMessageObj{
    
    self.iconImageView.image = [UIImage imageNamed:mineMessageObj.iconImage];
    self.titleLabel.text = mineMessageObj.title;
    
}
#pragma mark-------布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    WeakSelf(self);

    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(weakself);
      
        make.height.mas_equalTo(FitSize(58.0f));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.equalTo(weakself);
        make.top.equalTo(weakself.iconImageView.mas_bottom);
        make.height.mas_equalTo(FitSize(13.0f));
        
    }];

}
#pragma mark-----懒加载
- (UIImageView *)iconImageView{
    
    if (_iconImageView == nil) {
        
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.contentMode = UIViewContentModeCenter;
        
    }
    return _iconImageView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = ZYFontSize(14.0f);
        _titleLabel.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
