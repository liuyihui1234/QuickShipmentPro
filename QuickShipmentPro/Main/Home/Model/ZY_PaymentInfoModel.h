//
//  ZY_PaymentInfoModel.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/12.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZY_PaymentInfoModel : ZY_BaseModel
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *sendName;
@property(nonatomic,copy)NSString *sendPhone;
@property(nonatomic,copy)NSString *sendAddress;
@property(nonatomic,copy)NSString *receiveName;
@property(nonatomic,copy)NSString *receivePhone;
@property(nonatomic,copy)NSString *receiveAddress;
@end

NS_ASSUME_NONNULL_END
