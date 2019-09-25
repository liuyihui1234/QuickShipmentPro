//
//  ZY_SendPieceListModel.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/29.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_BaseModel.h"
#import "ZY_EforcesOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZY_SendPieceListModel : ZY_BaseModel
@property (nonatomic,copy)NSString *amount;
@property (nonatomic,copy)NSString *billsnumber;
@property (nonatomic,copy)NSString *bz;
@property (nonatomic,copy)NSString *createtime;
@property (nonatomic,strong)ZY_EforcesOrderModel *eforcesOrder;
@property (nonatomic,copy)NSString *expressid;
@property (nonatomic,copy)NSString *expresstype;
@property (nonatomic,copy)NSString *flightsnumber;
@property (nonatomic,copy)NSString *goodstype;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *incid;
@property (nonatomic,copy)NSString *incname;
@property (nonatomic,copy)NSString *postman;
@property (nonatomic,copy)NSString *postmanid;
@property (nonatomic,copy)NSString *scannerid;
@property (nonatomic,copy)NSString *scanners;
@property (nonatomic,copy)NSString *scantime;
@property (nonatomic,copy)NSString *scantype;



@end

NS_ASSUME_NONNULL_END
