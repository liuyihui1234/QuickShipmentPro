//
//  ZY_MineFooterView.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/10.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZY_MineFooterView : UICollectionReusableView
@property(nonatomic,copy)void(^logoutClickBlock)(UIButton *sender);
@end

NS_ASSUME_NONNULL_END
