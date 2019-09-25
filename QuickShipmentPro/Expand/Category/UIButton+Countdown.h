//
//  UIButton+Countdown.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/12.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSendVerifyCode             @"获取验证码"
#define kResendVerifyCode(sec)      [NSString stringWithFormat:@"重新发送(%ds)", sec]
#define kColor(color)               [UIColor color]
#define kCGColor(color)             [UIColor color].CGColor

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Countdown)
/**
 *  倒计时
 *
 *  title    按钮title
 *  sec      倒计时时间，单位为s
 *  color    按钮backgroundColor
 *  subTitle 倒计时中的按钮子标题（时间后）
 *  cColor   倒计时中的按钮backgroundColor
 */
- (void)startWithSeconds:(int)seconds;
@end

NS_ASSUME_NONNULL_END
