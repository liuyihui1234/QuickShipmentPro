//
//  ZYPrintPopView.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/23.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYPrintPopView : UIView
- (void)show;
@property(nonatomic,copy)void(^sureActionClickBlock)(UIButton *sender);

@end

NS_ASSUME_NONNULL_END
