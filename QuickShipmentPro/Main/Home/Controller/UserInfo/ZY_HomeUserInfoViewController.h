//
//  ZY_HomeUserInfoViewController.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/23.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class ZY_HomeUserInfoModel;
@interface ZY_HomeUserInfoViewController : ZY_BaseViewController
@property(nonatomic,copy)void(^changeUserInfoClickBlock)(void);
@end

NS_ASSUME_NONNULL_END
