//
//  ZY_HomeSliderModel.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/28.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZY_HomeSliderModel : ZY_BaseModel
@property (nonatomic,copy)NSString *crttime;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *picpath;
@property (nonatomic,copy)NSString *remark;
@property (nonatomic,copy)NSString *sort;
@property (nonatomic,copy)NSString *type;

@property (nonatomic,copy)NSString *receivedscan;
@property (nonatomic,copy)NSString *sentscan;
@end

NS_ASSUME_NONNULL_END
