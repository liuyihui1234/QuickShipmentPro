//
//  ZYTools.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/10.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZYTools.h"
#import <Accelerate/Accelerate.h>
@implementation ZYTools
/**
 *  判断字符串是否为空
 *
 *  @param returnStr 字符串
 *
 *  @return 结果值
 */
+ (BOOL)judgeString:(NSString *)returnStr {
    
    if (returnStr) {
        returnStr = [NSString stringWithFormat:@"%@", returnStr];
    }
    if ([returnStr isEqual:[NSNull null]] || returnStr.length == 0 || returnStr == nil || [returnStr isEqualToString:@""] ||[returnStr isEqualToString:@" "]|| !returnStr || [returnStr isEqualToString: @"<null>"]||[returnStr isEqualToString: @"(null)"]||[returnStr isEqualToString: @"null"]) {
        return NO;
    }
    return YES;
}
#pragma mark - 改变日期格式
+ (NSString *)changeCreateTimeFormat:(NSString*)createTime{
    
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    fmt.dateFormat = @"yyyy-MM-dd";
    // NSString * -> NSDate *
    NSDate *date = [fmt dateFromString:createTime];
    NSString *newStr = [fmt stringFromDate:date];
    return newStr;
}

//图片模糊
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}
#pragma mark  判断是否是手机号
/**
 *  判断手机号,只判断首位为1的11为数字
 *
 *  @param mobileNum 需要判断的手机号
 *
 *  @return 返回BOOL
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum{
    
    NSString * MOBILE = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if ([regextestmobile evaluateWithObject:mobileNum] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
#pragma mark-----------存储token
+ (void)saveToken:(NSString *)token withKey:(NSString *)key{
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSData *tokenData =[token dataUsingEncoding:NSUTF8StringEncoding];
    
    [userDefaults setObject:tokenData forKey:key];
    
    [userDefaults synchronize];
}
#pragma mark-----------读取token
+ (NSString *)getTokenWithKey:(NSString *)key{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *tokenData = [userDefaults objectForKey:key];
    
    NSString *token = [[NSString alloc]initWithData:tokenData encoding:NSUTF8StringEncoding];
    
    [userDefaults synchronize];
    return token;
}
#pragma mark-----------清空token
+ (void)cleanTokenWithKey:(NSString *)key{
    
    NSUserDefaults *userLoginState = [NSUserDefaults standardUserDefaults];
    [userLoginState removeObjectForKey:key];
    [userLoginState synchronize];
}
@end
