//
//  EasyShowUtils.m
//  ArtMoFangProject
//
//  Created by 云创数字 on 2018/6/6.
//  Copyright © 2018年 云创数字. All rights reserved.
//

#import "EasyShowUtils.h"

@implementation EasyShowUtils
+ (CGSize)textWidthWithStirng:(NSString *)string font:(UIFont *)font maxWidth:(CGFloat)maxWidth
{
    CGSize size = [string boundingRectWithSize:CGSizeMake(maxWidth, KSCREEN_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine
        attributes:@{NSFontAttributeName:font}
                                       context:nil].size;
    if (size.width < 60) {
        size.width = 60 ;
    }
    return size ;
}

+ (UIViewController *)easyShowViewTopViewController {
    UIViewController *resultVC = [self tempEasyShowViewTopVC:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self tempEasyShowViewTopVC:resultVC.presentedViewController];
    }
    return resultVC;
}
+ (UIViewController *)tempEasyShowViewTopVC:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self tempEasyShowViewTopVC:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self tempEasyShowViewTopVC:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
@end
