//
//  ZY_SendPieceListCell.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/29.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZY_SendPieceListModel;
@interface ZY_SendPieceListCell : UICollectionViewCell
@property(strong,nonatomic)ZY_SendPieceListModel *sendPieceListObj;
@property(nonatomic,copy)void(^customButtonActionBlock)(NSInteger senderTag);
@end

NS_ASSUME_NONNULL_END
