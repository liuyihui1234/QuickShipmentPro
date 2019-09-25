//
//  UIColor+Chains.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/6/19.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Chains)

/**
 *  从十六进制字符串获取颜色
 *
 *  @param color 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 */
+ (UIColor *)chains_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


@end

NS_ASSUME_NONNULL_END
