//
//  ZYTextView.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/14.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYTextView : UITextView
@property (nonatomic,copy)NSString *placeHolder;
- (void)setPlaceHolderX:(CGFloat)x;
- (void)setPlaceHolderColor:(UIColor *)placeHolderColor;
@end

NS_ASSUME_NONNULL_END
