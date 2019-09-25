//
//  ApiConfig.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/28.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApiConfig : NSObject
/**
 *  用户登录接口
 */
+ (NSString *)zy_UserLoginAccount_URL;

/**
 *  更换用户信息
 */
+ (NSString *)zy_ChangePersonalInformation_URL;

/**
 *  发送验证码接口
 */
+ (NSString *)zy_SendSMSCode_URL;


/**
 *  实名认证接口接口
 */
+ (NSString *)zy_UpdateUserIdentity_URL;


/**
 *  首页轮播接口接口
 */
+ (NSString *)zy_HomeCarouselShow_URL;

/**
 *  派件列表接口
 */
+ (NSString *)zy_FindDisByPostmanId_URL;
/**
 *  接单列表接口
 */
+ (NSString *)zy_FindAppointmentByStreet_URL;

/**
 *  接单功能接口
 */
+ (NSString *)zy_AlterStatus1ById_URL;

/**
 *  取件列表接口
 */
+ (NSString *)zy_PickUpPieceList_URL;

/**
 *  未支付订单列表接口
 */
+ (NSString *)zy_DidNotPayOrderList_URL;

/**
 *  已支付订单列表接口
 */
+ (NSString *)zy_HaveToPayOrderList_URL;

/**
 *  我的收件列表接口
 */
+ (NSString *)zy_MyReceiptOrderList_URL;

/**
 *  我的派件列表接口
 */
+ (NSString *)zy_MySendOrderList_URL;

/**
 *  投诉记录列表接口信息
 */
+ (NSString *)zy_ComplaintsRecordList_URL;


@end

NS_ASSUME_NONNULL_END
