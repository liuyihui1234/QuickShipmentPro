//
//  ZY_NoPayMentListCell.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/10.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZY_LoansSettlementModel;
@interface ZY_NoPayMentListCell : UICollectionViewCell
@property(strong,nonatomic)ZY_LoansSettlementModel *locansSettlementObj;
@property(nonatomic,copy)void(^selectedGoodsButtonBlock)(BOOL isClick);
@property(nonatomic,copy)void(^locationNavButtonBlock)(UIButton *sender);
@end

NS_ASSUME_NONNULL_END
