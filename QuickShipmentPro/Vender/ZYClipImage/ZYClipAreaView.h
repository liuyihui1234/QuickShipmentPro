//
//  ZYClipAreaView.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/14.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define CLIP_WIDTH self.frame.size.width
#define CLIP_HEIGHT self.frame.size.height

typedef NS_ENUM(NSUInteger, ClipAreaViewType)
{
    ClipAreaViewTypeRect = 0, /**< 裁剪区域是矩形*/
    ClipAreaViewTypeArc, /**< 裁剪区域是圆形*/
};

@interface ZYClipAreaView : UIView
@property (nonatomic, strong) UIView *clipView; /**< 裁剪区域*/
@property (nonatomic, assign) ClipAreaViewType clipAreaType;

/**
 *  快速初始化ClipAreaView类
 */
+ (instancetype)initWithFrame:(CGRect)frame;

- (void)resetClipViewFrame;
@end

NS_ASSUME_NONNULL_END
