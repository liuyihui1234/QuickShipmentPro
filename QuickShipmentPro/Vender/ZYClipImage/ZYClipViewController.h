//
//  ZYClipViewController.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/14.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ClipViewControllerDelegate <NSObject>

- (void)didSuccessClipImage:(UIImage *)clipedImage;

@end
@interface ZYClipViewController : ZY_BaseViewController
@property (nonatomic, strong) UIImage *needClipImage;
@property (nonatomic, weak) id<ClipViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
