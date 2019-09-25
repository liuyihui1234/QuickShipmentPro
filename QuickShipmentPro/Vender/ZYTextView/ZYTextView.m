//
//  ZYTextView.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/14.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZYTextView.h"
@interface ZYTextView ()
@property (nonatomic,assign) CGFloat placeholdX;

@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation ZYTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addAllSubview];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer
{
    if (self = [super initWithFrame:frame textContainer:textContainer]) {
        [self addAllSubview];
    }
    return self;
}

- (void)addAllSubview
{
    self.placeholdX = FitSize(12.0f);
    CGFloat fontSize = FitSize(13.0f);
    self.textContainerInset = UIEdgeInsetsMake(FitSize(5.0f),FitSize(5.0f), 0, 0);
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.alwaysBounceVertical = YES;
    self.font = [UIFont systemFontOfSize:fontSize];
    
    // 1.添加提示文字
    UILabel *placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.backgroundColor = [UIColor clearColor];
    placeholderLabel.textColor = [UIColor chains_colorWithHexString:@"#acacac" alpha:1.0f];
    placeholderLabel.hidden = NO;
    placeholderLabel.numberOfLines = 0;
    placeholderLabel.font = ZYFontSize(13.0f);
    [self insertSubview:placeholderLabel atIndex:0];
    self.placeholderLabel = placeholderLabel;
    // 2.监听textView文字改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidChange)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat placeholderX = self.placeholdX ;
    CGFloat placeholderY = FitSize(10.0f);
    CGFloat maxW = self.frame.size.width - 2.0f * placeholderX;
    CGFloat fontSize = 13.0f;
    CGSize placeholderSize = [self.placeHolder getSpaceLabelHeight:0.0f withFont:ZYFontSize(fontSize) withMaxSize:CGSizeMake(maxW, FitSize(10.0f))];
    self.placeholderLabel.frame = CGRectMake(placeholderX, placeholderY, placeholderSize.width, placeholderSize.height);
}

- (void)updateConstraints
{
    CGFloat placeholderX = self.placeholdX ;
    CGFloat placeholderY = FitSize(5.0f);
    CGFloat maxW = KSCREEN_WIDTH - 2 * placeholderX;
    CGFloat fontSize = FitSize(14.0f);
    CGSize placeholderSize = [self.placeHolder getSpaceLabelHeight:0.0f withFont:[UIFont systemFontOfSize:fontSize] withMaxSize:CGSizeMake(maxW, FitSize(20.0f))];
    
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(placeholderX));
        make.top.equalTo(@(placeholderY));
        make.width.equalTo(@(placeholderSize.width));
        make.height.equalTo(@(placeholderSize.height));
    }];
    
    [super updateConstraints];
}

- (void)setPlaceHolderX:(CGFloat)x
{
    self.placeholdX = x;
    [self setNeedsLayout];
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    
    self.placeholderLabel.text = placeHolder;
    if (placeHolder.length && self.text.length < 1) { // 需要显示
        self.placeholderLabel.hidden = NO;
    } else {
        self.placeholderLabel.hidden = YES;
    }
    [self layoutIfNeeded];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    if (![text isKindOfClass:[NSString class]])
    {
        self.placeholderLabel.hidden = YES;
    }
    else
    {
        self.placeholderLabel.hidden = NO;
    }
}
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    if (![attributedText isKindOfClass:[NSAttributedString class]])
    {
        self.placeholderLabel.hidden = YES;
    }
    else
    {
        self.placeholderLabel.hidden = NO;
    }
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    if (placeHolderColor) {
        self.placeholderLabel.textColor = placeHolderColor;
    }
}

- (void)textDidChange{
    
    self.placeholderLabel.hidden = (self.text.length != 0);
    if (IOS_VERSION >= 8.0)
    {
        CGRect line = [self caretRectForPosition:
                       self.selectedTextRange.start];
        CGFloat overflow = line.origin.y + line.size.height
        - ( self.contentOffset.y + self.bounds.size.height
           - self.contentInset.bottom - self.contentInset.top );
        if ( overflow > 0 ) {
            // We are at the bottom of the visible text and introduced a line feed, scroll down (iOS 7 does not do it)
            // Scroll caret to visible area
            CGPoint offset = self.contentOffset;
            offset.y += overflow + 7.0f; // leave 7 pixels margin
            // Cannot animate with setContentOffset:animated: or caret will not appear
            [UIView animateWithDuration:.2 animations:^{
                [self setContentOffset:offset];
            }];
        }
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
