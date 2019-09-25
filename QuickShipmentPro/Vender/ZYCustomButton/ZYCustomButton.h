//
//  ZYCustomButton.h
//  ZYSignContractPro
//
//  Created by 飞之翼 on 2019/6/24.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger) {
    ZYCustomButtonImageTop    = 0 , //图片在上边
    ZYCustomButtonImageLeft   = 1 , //图片在左边
    ZYCustomButtonImageBottom = 2 , //图片在下边
    ZYCustomButtonImageRight  = 3   //图片在右边
}ZYCustomButtonType;

@interface ZYCustomButton : UIButton
/** 图片和文字间距 默认10px*/
@property (nonatomic , assign) CGFloat zy_spacing;

/** 按钮类型 默认YSLCustomButtonImageTop 图片在上边*/
@property (nonatomic , assign) ZYCustomButtonType zy_buttonType;
@end

NS_ASSUME_NONNULL_END
