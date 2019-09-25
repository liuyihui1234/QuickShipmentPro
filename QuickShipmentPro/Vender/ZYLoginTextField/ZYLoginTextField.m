//
//  ZYLoginTextField.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/28.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZYLoginTextField.h"
@implementation ZYLoginTextField{
    
    UILabel *_starLabel;
    UIImageView *_leftIconImage;//默认的leftIcon
    UIView *_customLeftView;//默认的leftView，是_leftIconBtn的父视图
    UIImageView *_rightIconImage;//默认的rightIcon
}

- (instancetype)init{
    
    self=[super init];
    
    if (self) {
        
        //初始化默认状态
        _isChangeBorder = YES;
        _defaultBorderColor=[UIColor chains_colorWithHexString:@"#e1e1e1" alpha:1.0f];
        _defaultBorderWidth=1;
        _selectBorderColor=[UIColor chains_colorWithHexString:kThemeColor alpha:1.0f];
        _placeholderColor=[UIColor chains_colorWithHexString:@"#cccccc" alpha:1.0f];
        self.layer.cornerRadius=3;
        self.layer.borderWidth=_defaultBorderWidth;
        self.layer.borderColor=_defaultBorderColor.CGColor;
        self.textColor=[UIColor chains_colorWithHexString:kBlackColor alpha:1.0f];
        self.tintColor=[UIColor chains_colorWithHexString:@"#cccccc" alpha:1.0f];
        self.layer.cornerRadius = FitSize(24.5f);
        
        self.leftViewMode = UITextFieldViewModeAlways;
        self.rightViewMode = UITextFieldViewModeAlways;
        [self settingLeftIcon];
        [self settingRightIcon];
        
        //添加通知监听文本状态
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:self];
    }
    
    return self;
}
- (void)setDefaultBorderColor:(UIColor *)defaultBorderColor
{
    _defaultBorderColor=defaultBorderColor;
    self.layer.borderColor=_defaultBorderColor.CGColor;
}

-( void)setDefaultBorderWidth:(CGFloat)defaultBorderWidth
{
    _defaultBorderWidth=defaultBorderWidth;
    self.layer.borderWidth=_defaultBorderWidth;
}
- (void)settingLeftIcon{
    
    //初始化默认leftview
    CGFloat height = FitSize(30.0f);
    _customLeftView=[[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0f,FitSize(60.0f), height)];
    _customLeftView.backgroundColor = [UIColor clearColor];
    self.leftView = _customLeftView;
    
    if (_starLabel == nil) {
        
        _starLabel = [[UILabel alloc]init];
        _starLabel.frame = CGRectMake(FitSize(15.0f),FitSize(5.0f),FitSize(10.0f),height-FitSize(5.0f));
        _starLabel.text = @"*";
        _starLabel.textAlignment = NSTextAlignmentCenter;
        _starLabel.textColor = [UIColor chains_colorWithHexString:kThemeColor alpha:1.0f];
        [_customLeftView addSubview:_starLabel];
    }
    if (_leftIconImage==nil)
    {
        
        _leftIconImage=[[UIImageView alloc]init];
        _leftIconImage.frame = CGRectMake(height, 0.0f, height, height);
        _leftIconImage.contentMode = UIViewContentModeCenter;
        [_customLeftView addSubview:_leftIconImage];
    }
}
- (void)settingRightIcon{
    
    if (_rightIconImage == nil) {
        _rightIconImage = [[UIImageView alloc]init];
        _rightIconImage.image = [UIImage imageNamed:@"arrow"];
        _rightIconImage.frame = CGRectMake(0,0,FitSize(50.0f), FitSize(30.0f));
        _rightIconImage.hidden = YES;
        _rightIconImage.contentMode = UIViewContentModeCenter;
        self.rightView = _rightIconImage;
    }
    
}
- (void)textBeginEditing:(NSNotification*)note{
    if (_isChangeBorder==NO)return;
    [self changBorderwithNote:note];
    
}
- (void)textDidEndEditing:(NSNotification*)note{
    if (_isChangeBorder==NO)return;
    [self changBorderwithNote:note];
}
- (void)textDidChange:(NSNotification*)note{
    [self changBorderwithNote:note];
}
- (void)setPlaceholder:(NSString *)placeholder{
    [super setPlaceholder:placeholder];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:_placeholderColor}];
}
- (void)setIsHidden:(BOOL)isHidden{
    
    _rightIconImage.hidden = isHidden;
    
}
- (void)setIsHiddenStar:(BOOL)isHiddenStar{
    
    _starLabel.hidden = isHiddenStar;
    
}
- (void)setLeftIconNameStr:(NSString *)leftIconNameStr{
    
    _leftIconImage.image = [UIImage imageNamed:leftIconNameStr];
    
}

- (void)changBorderwithNote:(NSNotification*)editing{
    if (![editing.object isEqual:self])return;
    if ([editing.name isEqualToString:UITextFieldTextDidBeginEditingNotification])
    {
        self.layer.borderColor=_selectBorderColor.CGColor;
        
        
    }else if ([editing.name isEqualToString:UITextFieldTextDidEndEditingNotification])
    {
        self.layer.borderColor=_defaultBorderColor.CGColor;
        
        
    }else if ([editing.name isEqualToString:UITextFieldTextDidChangeNotification]){
        
        if (self.maxTextLength!=0)
        {
            if (self.text.length >self.maxTextLength) {
                [self judemaxText];
            }
        }
    }
    
}
//限制最大输入字数
- (void)judemaxText{
    if (_maxTextLength>0)
    {
        // 键盘输入模式
        NSString *lang=[[UIApplication sharedApplication]textInputMode].primaryLanguage;
        if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
            UITextRange *selectedRange = [self markedTextRange];
            //获取高亮部分
            UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                if (self.text.length >= _maxTextLength) {
                    if (self.text.length>_maxTextLength)
                    {
                        [self addShakeAnimation];
                    }
                    NSString *newText=[self.text substringToIndex:_maxTextLength];
                    if (![self.text isEqualToString:newText])
                    {
                        self.text =newText;
                    }
                    
                }
            }
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
            else{
                
            }
        }
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        else{
            if (self.text.length >= _maxTextLength) {
                if (self.text.length>_maxTextLength)
                {
                    [self addShakeAnimation];
                }
                NSString *newText=[self.text substringToIndex:_maxTextLength];
                if (![self.text isEqualToString:newText])
                {
                    self.text =newText;
                }
            }
        }
        
    }
}
//添加抖动动画
- (void)addShakeAnimation{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat currentTx = self.transform.tx;
    
    //    animation.delegate = self;
    animation.duration = 0.5;
    animation.values = @[ @(currentTx), @(currentTx + 10), @(currentTx-8), @(currentTx + 8), @(currentTx -5), @(currentTx + 5), @(currentTx) ];
    animation.keyTimes = @[ @(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:animation forKey:@"kAFViewShakerAnimationKey"];
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"文本框释放");
}

@end
