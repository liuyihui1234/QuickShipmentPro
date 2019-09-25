//
//  NSString+Extension.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/6/19.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)
/**
 测量文本的尺寸
 */
- (CGSize)getSpaceLabelHeight:(CGFloat)space withFont:(UIFont*)font withMaxSize:(CGSize)maxSize;
/**
 编辑文本
 */
- (NSMutableAttributedString *)getSpaceLabelText:(NSString *)text withSpace:(CGFloat)space Font:(UIFont*)font;

/**
 自定义文本显示
 */
- (NSMutableAttributedString *)zy_changeFontArr:(NSArray *)fontArr ColorArr:(NSArray *)colorArr TotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray Alignment:(NSInteger)alignment Space:(CGFloat)space;
/**
 拼接成中间有空格的字符串
 */
- (NSString *)jointWithString:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
