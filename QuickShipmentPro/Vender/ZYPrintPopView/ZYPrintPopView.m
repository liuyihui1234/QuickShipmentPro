//
//  ZYPrintPopView.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/23.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZYPrintPopView.h"
@interface ZYPrintPopView()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIView *alertview;
@property(nonatomic,strong)UIImageView *printImageView;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *messageLabel;
@property(nonatomic,strong)UIButton *sureButton;
@property(nonatomic,strong)UIButton *cancelButton;
@property(nonatomic,strong)UIImageView *closeImageView;
@end

@implementation ZYPrintPopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //单击的手势
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        tapRecognize.numberOfTapsRequired = 1;
       // [tapRecognize setEnabled :YES];
      //  [tapRecognize delaysTouchesBegan];
        tapRecognize.delegate = self;
        [self addGestureRecognizer:tapRecognize];
        
        [self addSubview:self.alertview];
        [self.alertview addSubview:self.bgView];
        
        [self.alertview addSubview:self.printImageView];
        [self.alertview addSubview:self.closeImageView];
        
        [self.bgView addSubview:self.messageLabel];
        [self.bgView addSubview:self.sureButton];
        [self.bgView addSubview:self.cancelButton];
    }
    return self;
}
#pragma mark-------布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    WeakSelf(self);
    [self.alertview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(weakself);
        make.height.mas_equalTo(FitSize(320.0f));
        make.width.mas_equalTo(FitSize(280.0f));
        
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakself.alertview);
        make.top.mas_equalTo(FitSize(65.0f));
        make.height.mas_equalTo(FitSize(200.0f));
        make.width.mas_equalTo(FitSize(270.0f));
        
    }];

    [self.printImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.top.equalTo(weakself.alertview);
        make.height.mas_equalTo(FitSize(140.0f));
        make.width.mas_equalTo(FitSize(118.0f));
        
    }];
    [self.closeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakself.bgView);
        make.top.equalTo(weakself.bgView.mas_bottom).offset(FitSize(25.0f));
        make.height.width.mas_equalTo(FitSize(25.0f));
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(FitSize(90.0f));
        make.centerX.width.equalTo(weakself.bgView);
        make.height.mas_equalTo(FitSize(14.0f));
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(-FitSize(35.0f));
        make.left.mas_equalTo(FitSize(50.0f));
        make.width.mas_equalTo(FitSize(72.0f));
        make.height.mas_equalTo(FitSize(25.0f));
        
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-FitSize(50.0f));
        make.bottom.height.width.equalTo(weakself.sureButton);
    }];
}
- (void)sureAction:(UIButton *)sender{
    
    if (self.sureActionClickBlock) {
        [self dismissAlertView];
        self.sureActionClickBlock(sender);
    }
}
- (void)cancelAction:(UIButton *)sender{
    
    [self dismissAlertView];
    
}
#pragma mark-------懒加载
- (UIView *)alertview{
    if (_alertview == nil) {
        _alertview = [[UIView alloc]init];
        _alertview.backgroundColor = [UIColor clearColor];
    }
    return _alertview;
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];;
        _bgView.layer.cornerRadius = FitSize(3.0f);
        
    }
    return _bgView;
}
- (UIImageView *)closeImageView{
    
    if (_closeImageView == nil) {
        _closeImageView = [[UIImageView alloc]init];
        _closeImageView.image = [UIImage imageNamed:@"popclose"];
    }
    return _closeImageView;
    
}
- (UIImageView *)printImageView{
    
    if (_printImageView == nil) {
        _printImageView = [[UIImageView alloc]init];
        _printImageView.image = [UIImage imageNamed:@"printpopimg"];
        
    }
    return _printImageView;
    
}
- (UILabel *)messageLabel{
    if (_messageLabel == nil) {
        
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.text = @"确定上传收信息并打印吗？";
        _messageLabel.font = ZYFontSize(14.0f);
        _messageLabel.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}
- (UIButton *)sureButton{
 
    if (_sureButton == nil) {
        
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.backgroundColor = [UIColor chains_colorWithHexString:kThemeColor alpha:1.0f];
        _sureButton.titleLabel.font = ZYFontSize(13.0f);
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _sureButton;
}
- (UIButton *)cancelButton{
    
    if (_cancelButton == nil) {
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.titleLabel.font = ZYFontSize(13.0f);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor chains_colorWithHexString:kDarkGrayColor alpha:1.0f] forState:UIControlStateNormal];
        _cancelButton.layer.borderColor = [UIColor chains_colorWithHexString:kDarkGrayColor alpha:1.0f].CGColor;
        _cancelButton.layer.borderWidth = FitSize(0.5f);
        [_cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelButton;
}

- (void)show{
    self.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    
    self.alertview.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
    self.alertview.alpha = 0;
    [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        self.alertview.transform = transform;
        self.alertview.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)dismissAlertView{
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}
#pragma  mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self.bgView]) {
        return NO;
    }
    return YES;
}
- (void)handleTap:(UITapGestureRecognizer *)tap{
    
    [self dismissAlertView];
    
}
@end
