//
//  ZYChoiceGoodsInfoView.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/12.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZYChoiceGoodsInfoView.h"
@interface ZYChoiceGoodsInfoView()<UITextFieldDelegate>
@property(strong,nonatomic)UIImageView *markImageView;
@property(strong,nonatomic)UILabel *titleLabel;
@property(strong,nonatomic)UITextField *customTextFiled;
@end
@implementation ZYChoiceGoodsInfoView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.markImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.customTextFiled];
    }
    return self;
}
- (void)changeShowMessgeWithImage:(NSString *)imageName title:(NSString *)title message:(NSString *)message{
    
    self.markImageView.image = [UIImage imageNamed:imageName];
    self.titleLabel.text = [NSString stringWithFormat:@"%@",title];
    self.customTextFiled.text = [NSString stringWithFormat:@"%@",message];
}
#pragma mark-------布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    WeakSelf(self);
    [self.markImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakself);
        make.height.width.mas_equalTo(FitSize(18.0f));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(weakself.markImageView);
        make.left.equalTo(weakself.markImageView.mas_right).offset(FitSize(6.0f));
        make.width.mas_equalTo(FitSize(160.0f));
    }];
    [self.customTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.titleLabel.mas_bottom).offset(FitSize(8.0f));
        make.left.width.equalTo(weakself);
        make.height.mas_equalTo(FitSize(33.0f));
    }];
}
#pragma mark----代理事件
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    NSLog(@"-------%@",textField.text);
    return NO;
}
#pragma mark-----懒加载
- (UIImageView *)markImageView{
    
    if (_markImageView == nil) {
        _markImageView = [[UIImageView alloc]init];
        _markImageView.contentMode = UIViewContentModeCenter;
        _markImageView.image = [UIImage imageNamed:@"calendar"];
    }
    return _markImageView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = ZYFontSize(12.0f);
        _titleLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
        _titleLabel.text = @"付款方式";
    }
    return _titleLabel;
}
- (UITextField *)customTextFiled{
    if (_customTextFiled == nil) {
    
        _customTextFiled = [[UITextField alloc]init];
        _customTextFiled.font = [UIFont systemFontOfSize:FitSize(13.0f)];
        _customTextFiled.textColor = [UIColor chains_colorWithHexString:kDarkGrayColor alpha:1.0f];
        _customTextFiled.leftViewMode = UITextFieldViewModeAlways;
        _customTextFiled.rightViewMode = UITextFieldViewModeAlways;
        _customTextFiled.backgroundColor = [UIColor chains_colorWithHexString:@"#f7f7f7" alpha:1.0f];
        _customTextFiled.delegate = self;
        
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, FitSize(14.0f), FitSize(33.0f))];
        leftView.backgroundColor = [UIColor clearColor];
        _customTextFiled.leftView = leftView;
        
        UIImageView *rightImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"updownimg"]];
        rightImage.contentMode = UIViewContentModeCenter;
        rightImage.frame = CGRectMake(0.0, 0.0,FitSize(30.0f), FitSize(33.0f));
        _customTextFiled.rightView = rightImage;

    }
    return _customTextFiled;
}
@end
