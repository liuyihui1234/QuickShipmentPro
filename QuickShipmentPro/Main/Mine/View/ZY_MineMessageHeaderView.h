//
//  ZY_MineMessageHeaderView.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/10.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZY_MineMessageHeaderView : UICollectionReusableView
@property(copy,nonatomic)NSString *iconImageUrl;
@property(copy,nonatomic)NSString *priterName;
@property(nonatomic,copy)void(^scanningPrinterButtonBlock)(void);
@end

NS_ASSUME_NONNULL_END
