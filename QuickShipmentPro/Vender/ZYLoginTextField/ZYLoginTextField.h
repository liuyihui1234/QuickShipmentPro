//
//  ZYLoginTextField.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/28.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYLoginTextField : UITextField
/**
 左边的icon,不传则不显示
 */
@property(nonatomic,copy)NSString *leftIconNameStr;

/**
 控制当在编辑时，是否高亮文本框的Border,默认是YES
 */
@property(nonatomic,assign)BOOL isChangeBorder;

/**默认边框颜色*/
@property(nonatomic,copy)UIColor *defaultBorderColor;
/**默认边框宽度*/
@property(nonatomic,assign)CGFloat defaultBorderWidth;
/**编辑时边框颜色*/
@property(nonatomic,copy)UIColor *selectBorderColor;
/**占位文本的颜色*/
@property(nonatomic,copy)UIColor *placeholderColor;
/**最多输入长度*/
@property(nonatomic,assign)int maxTextLength;

/**是否隐藏*/
@property(nonatomic,assign)BOOL isHidden;

/**是否隐藏星号*/
@property(nonatomic,assign)BOOL isHiddenStar;
@end

NS_ASSUME_NONNULL_END
