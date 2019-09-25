//
//  ProvinceModel.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/9/2.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProvinceModel : ZY_BaseModel
@property(nonatomic,copy)NSString *created_time;
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,assign)NSInteger is_enabled;
@property(nonatomic,copy)NSString *province_name;
@property(nonatomic,assign)NSInteger seq_no;
@property(nonatomic,copy)NSString *updated_time;
@property(nonatomic,assign)NSInteger updated_user;
@end

NS_ASSUME_NONNULL_END
