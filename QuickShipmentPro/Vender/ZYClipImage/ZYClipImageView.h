//
//  ZYClipImageView.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/14.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYClipAreaView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZYClipImageView : UIView
@property (nonatomic, strong) UIImage *clipImage; /**< 需要被裁剪的图片*/
@property (nonatomic, assign) ClipAreaViewType clipType;/**< 裁剪区域的类型*/
// 若选择是圆形裁剪区域，下面的属性可以不用赋值
@property (nonatomic, strong) UIColor *midLineColor; /**< 中间线颜色*/



/**
 *  快速初始化ClipImageView类
 */
+ (instancetype)initWithFrame:(CGRect)frame;

/**
 *  获取裁剪后的图片
 */
- (UIImage *)getClipedImage;

@end

NS_ASSUME_NONNULL_END
