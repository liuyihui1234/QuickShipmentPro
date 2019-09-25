//
//  ZY_BaseViewController.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/23.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZY_BaseViewController : UIViewController
/**
 * 显示菊花
 */

- (void)showHud;

/**
 * 隐藏菊花
 */

- (void)hidHud;

/**
 * 定制菊花下方显示字体
 */

- (void)showHudWithString:(NSString *)loadingText;

/**
 * 提示框
 */
- (void)showToastMessage:(NSString *)message;



@end

NS_ASSUME_NONNULL_END
