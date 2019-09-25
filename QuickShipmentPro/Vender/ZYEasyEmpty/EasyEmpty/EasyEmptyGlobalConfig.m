//
//  EasyEmptyGlobalConfig.m
//  ArtMoFangProject
//
//  Created by 云创数字 on 2018/6/6.
//  Copyright © 2018年 云创数字. All rights reserved.
//

#import "EasyEmptyGlobalConfig.h"
@implementation EasyEmptyGlobalConfig
easyShowView_singleton_implementation(EasyEmptyGlobalConfig)

- (instancetype)init
{
    if (self = [super init]) {
        
        _bgColor = [UIColor clearColor];
        _tittleFont = ZYFontSize(13.0f);
        _titleColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
        _subtitleFont = ZYFontSize(13.0f);
        _subTitleColor = [UIColor chains_colorWithHexString:kDarkGrayColor alpha:1.0f];
        _buttonFont = ZYFontSize(12.0f);
        _buttonColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
        _buttonBgColor = [UIColor chains_colorWithHexString:kThemeColor alpha:1.0f];
        _buttonEdgeInsets = UIEdgeInsetsMake(FitSize(15.0f),FitSize(20.0f),FitSize(15.0f),FitSize(20.0f));
        _scrollVerticalEnable = YES;
    }
    return self ;
}
@end
