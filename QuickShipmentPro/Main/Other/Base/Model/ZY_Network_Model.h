//
//  ZY_Network_Model.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/6/19.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZY_Network_Model<ObjectType> : ZY_BaseModel
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,assign)NSInteger code;

@property(nonatomic,strong)ObjectType data;//数据数组
@property(nonatomic,assign)BOOL hasSigned;

@property(nonatomic,assign)NSInteger count;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)NSInteger size;
@property(nonatomic,assign)NSInteger totalpage;

@end

NS_ASSUME_NONNULL_END
