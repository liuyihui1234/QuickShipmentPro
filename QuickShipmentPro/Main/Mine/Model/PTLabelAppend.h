//
//  PTLabelAppend.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/9/1.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <PrinterSDK/PrinterSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTLabelAppend : PTLabel
// CIAONIAO遗留接口
@property(strong,nonatomic,readwrite) NSString *code_number;        // 编号
@property(strong,nonatomic,readwrite) NSString *sender;
@property(strong,nonatomic,readwrite) NSString *sender_contact;
@property(strong,nonatomic,readwrite) NSString *receiver;
@property(strong,nonatomic,readwrite) NSString *receiver_contact;
@property(strong,nonatomic,readwrite) NSString *collection;
@property(strong,nonatomic,readwrite) NSString *date;
@property(strong,nonatomic,readwrite) NSString *print_time;

// TianTian
@property(copy,nonatomic,readwrite) NSString *referred;
@property(copy,nonatomic,readwrite) NSString *referred_width;
@property(copy,nonatomic,readwrite) NSString *city;
@property(copy,nonatomic,readwrite) NSString *number;
@property(copy,nonatomic,readwrite) NSString *receiver_address1;
@property(copy,nonatomic,readwrite) NSString *receiver_address2;
@property(copy,nonatomic,readwrite) NSString *receiver_address3;
@property(copy,nonatomic,readwrite) NSString *waybill;
@property(copy,nonatomic,readwrite) NSString *sender_address1;
@property(copy,nonatomic,readwrite) NSString *sender_address2;
@property(copy,nonatomic,readwrite) NSString *sender_address3;
@property(copy,nonatomic,readwrite) NSString *product_types;
@property(copy,nonatomic,readwrite) NSString *quantity;
@property(copy,nonatomic,readwrite) NSString *weight;
@end

NS_ASSUME_NONNULL_END
