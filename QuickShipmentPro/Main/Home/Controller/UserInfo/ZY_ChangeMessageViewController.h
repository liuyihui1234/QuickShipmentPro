//
//  ZY_ChangeMessageViewController.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/23.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZY_ChangeMessageViewController : ZY_BaseViewController
@property(copy,nonatomic)NSString *titleString;
@property(copy,nonatomic)NSString *textString;
@property(nonatomic,copy)void(^changeUserInfoClickBlock)(NSString *changeMes);

@end

NS_ASSUME_NONNULL_END
