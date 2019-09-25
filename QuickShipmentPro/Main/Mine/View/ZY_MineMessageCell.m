//
//  ZY_MineMessageCell.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/10.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_MineMessageCell.h"
#import "ZY_MineMessageModel.h"

@interface ZY_MineMessageCell()
@property(strong,nonatomic)UILabel *titleLabel;
@property(strong,nonatomic)UILabel *versonLabel;
@property(strong,nonatomic)UIImageView *arrowImageView;

@end

@implementation ZY_MineMessageCell
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    
        [self addSubview:self.titleLabel];
        [self addSubview:self.versonLabel];
        [self addSubview:self.arrowImageView];
     
    }
    return self;
}
#pragma mark----赋值
- (void)setMineMessageObj:(ZY_MineMessageModel *)mineMessageObj{

    self.titleLabel.text = mineMessageObj.title;
    self.versonLabel.text = [NSString stringWithFormat:@"%@",mineMessageObj.versonNum];
}
#pragma mark-------布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    WeakSelf(self);
    CGFloat spaceX = FitSize(12.0f);

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(spaceX);
        make.top.height.equalTo(weakself);
        make.width.mas_equalTo(FitSize(180.0f));
    
    }];

    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-spaceX);
        make.centerY.height.equalTo(weakself);
        make.width.mas_equalTo(FitSize(10.0f));
    }];
    
    [self.versonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.arrowImageView.mas_left).offset(-FitSize(5.0f));
        make.top.height.equalTo(weakself);
        make.width.mas_equalTo(FitSize(140.0f));
        
    }];

}
#pragma mark-----懒加载
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = ZYFontSize(13.0f);
        _titleLabel.textColor = [UIColor chains_colorWithHexString:kDarkGrayColor alpha:1.0f];
        
    }
    return _titleLabel;
}
- (UIImageView *)arrowImageView{
    
    if (_arrowImageView == nil) {
        
        _arrowImageView = [[UIImageView alloc]init];
        _arrowImageView.contentMode = UIViewContentModeRight;
        _arrowImageView.image = [UIImage imageNamed:@"mineArrow"];
        
    }
    return _arrowImageView;
}
- (UILabel *)versonLabel{
    if (_versonLabel == nil) {
        
        _versonLabel = [[UILabel alloc]init];
        _versonLabel.font = ZYFontSize(12.0f);
        _versonLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
        _versonLabel.textAlignment = NSTextAlignmentRight;
        
    }
    return _versonLabel;
}
@end
