//
//  ZY_HomeUserInfoView.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/23.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZY_HomeUserInfoModel;

@interface ZY_HomeUserInfoView : UIView
@property(strong,nonatomic)ZY_HomeUserInfoModel *homeUserInfoObj;
@property(nonatomic,copy)void(^editUserInfoGestureRecognizerBlock)(void);
@property(nonatomic,copy)void(^locationButtonClickBlock)(UIButton *sender);
- (void)refreshUserInfoDatasWithInfo:(ZY_HomeUserInfoModel *)infoObj;

@end

NS_ASSUME_NONNULL_END
