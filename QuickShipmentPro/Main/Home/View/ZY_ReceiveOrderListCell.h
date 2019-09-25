//
//  ZY_ReceiveOrderListCell.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/27.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZY_ReceiveOrderListModel;
@interface ZY_ReceiveOrderListCell : UICollectionViewCell
@property(strong,nonatomic)ZY_ReceiveOrderListModel *receiveOrderListObj;
@property(nonatomic,copy)void(^customButtonBlock)(NSInteger senderTag);

@end

NS_ASSUME_NONNULL_END
