//
//  NSString+Extension.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/6/19.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
#pragma mark------ 测量文本的尺寸
- (CGSize)getSpaceLabelHeight:(CGFloat)space withFont:(UIFont*)font withMaxSize:(CGSize)maxSize{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc]init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.lineSpacing = space;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    
    CGSize size = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    
    return size;
}
#pragma mark------ 编辑文本
- (NSMutableAttributedString *)getSpaceLabelText:(NSString *)text withSpace:(CGFloat)space Font:(UIFont*)font{
    
    NSMutableParagraphStyle  *contentParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 行间距设置
    [contentParagraphStyle setLineSpacing:space];
    NSMutableAttributedString  *setConString = [[NSMutableAttributedString alloc] initWithString:text];
    [setConString addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, [text length])];
    [setConString addAttribute:NSParagraphStyleAttributeName value:contentParagraphStyle range:NSMakeRange(0, [text length])];
    // 设置Label要显示的text
    return setConString;
}
#pragma mark------ 自定义文本显示
- (NSMutableAttributedString *)zy_changeFontArr:(NSArray *)fontArr ColorArr:(NSArray *)colorArr TotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray Alignment:(NSInteger)alignment Space:(CGFloat)space{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //0左对齐 1中间对齐 2右对齐
    paragraphStyle.alignment = alignment;//设置对齐方式
    paragraphStyle.lineSpacing = space;
    NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    
    [subArray enumerateObjectsUsingBlock:^(NSString *rangeStr, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSRange range = [totalString rangeOfString:rangeStr options:NSBackwardsSearch];
        
        [mutableStr addAttribute:NSForegroundColorAttributeName value:[UIColor chains_colorWithHexString:colorArr[idx] alpha:1.0] range:range];
        [mutableStr addAttribute:NSFontAttributeName value:fontArr[idx] range:range];
        
        [mutableStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    }];
    
    return mutableStr;
}
#pragma mark - 拼接成中间有空格的字符串
- (NSString *)jointWithString:(NSString *)str{
    NSString *getString = @"";
    
    int a = (int)str.length/4;
    int b = (int)str.length%4;
    int c = a;
    if (b>0)
    {
        c = a+1;
    }
    else
    {
        c = a;
    }
    for (int i = 0 ; i<c; i++)
    {
        NSString *string = @"";
        
        if (i == (c-1))
        {
            if (b>0)
            {
                string = [str substringWithRange:NSMakeRange(4*(c-1), b)];
            }
            else
            {
                string = [str substringWithRange:NSMakeRange(4*i, 4)];
            }
        }
        else
        {
            string = [str substringWithRange:NSMakeRange(4*i, 4)];
        }
        getString = [NSString stringWithFormat:@"%@ %@",getString,string];
    }
    return getString;
}

@end
