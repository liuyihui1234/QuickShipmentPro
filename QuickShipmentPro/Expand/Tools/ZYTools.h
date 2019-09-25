//
//  ZYTools.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/10.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYTools : NSObject
#pragma mark--空字符串判断
+ (BOOL)judgeString:(NSString *)returnStr;
#pragma mark - 改变日期格式
+ (NSString *)changeCreateTimeFormat:(NSString*)createTime;

//图片模糊
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;
#pragma mark - 手机号验证
+(BOOL)isMobileNumber:(NSString *)mobileNum;
//数据存储
+ (void)saveToken:(NSString *)token withKey:(NSString *)key;
+ (NSString *)getTokenWithKey:(NSString *)key;
+ (void)cleanTokenWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
