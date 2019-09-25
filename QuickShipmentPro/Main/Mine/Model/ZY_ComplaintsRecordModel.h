//
//  ZY_ComplaintsRecordModel.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/13.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZY_ComplaintsRecordModel : ZY_BaseModel
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *remark;
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString *customername;
@property (nonatomic,copy)NSString *crttime;
@property (nonatomic,copy)NSString *status;//1 待处理 2已处理
@property (nonatomic,copy)NSString *incnumber;
@end

NS_ASSUME_NONNULL_END
