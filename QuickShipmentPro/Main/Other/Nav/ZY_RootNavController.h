//
//  ZY_RootNavController.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/6/19.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 导航控制器基类
 */
@interface ZY_RootNavController : UINavigationController

/*!
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 */
- (BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated;


@end

NS_ASSUME_NONNULL_END
