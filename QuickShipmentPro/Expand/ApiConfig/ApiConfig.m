//
//  ApiConfig.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/28.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ApiConfig.h"
#pragma mark---- 测试链接
static NSString *const kBaseFZYUrl = KBHOST;
@implementation ApiConfig
#pragma mark----用户登录接口
+ (NSString *)zy_UserLoginAccount_URL{
    
    return [kBaseFZYUrl stringByAppendingString:@"login/dologin"];
    
}
#pragma mark---- 更换用户信息
+ (NSString *)zy_ChangePersonalInformation_URL{
    
    return [kBaseFZYUrl stringByAppendingString:@"login/updateUserMsg"];
}
#pragma mark---- 发送验证码接口
+ (NSString *)zy_SendSMSCode_URL{
    
    return [kBaseFZYUrl stringByAppendingString:@"login/sendSMS/SendPhone"];
    
}
#pragma mark----  实名认证接口接口
+ (NSString *)zy_UpdateUserIdentity_URL{
    
     return [kBaseFZYUrl stringByAppendingString:@"login/updateUserIdentity"];
    
}
#pragma mark---- 首页轮播接口接口
+ (NSString *)zy_HomeCarouselShow_URL{
    
    return [kBaseFZYUrl stringByAppendingString:@"Homepage/checkHome"];
}
#pragma mark---- 派件列表接口
+ (NSString *)zy_FindDisByPostmanId_URL{
    
    return [kBaseFZYUrl stringByAppendingString:@"app/distributed/findDisByPostmanId"];

}
#pragma mark---- 接单列表接口
+ (NSString *)zy_FindAppointmentByStreet_URL{
    
    return [kBaseFZYUrl stringByAppendingString:@"app/appoinment/findAppointmentByStreet"];
}
#pragma mark---- 接单功能接口
+ (NSString *)zy_AlterStatus1ById_URL{
    
    return [kBaseFZYUrl stringByAppendingString:@"app/appoinment/alterStatus1ById"];
}
#pragma mark---- 取件列表接口
+ (NSString *)zy_PickUpPieceList_URL{
    
    return [kBaseFZYUrl stringByAppendingString:@"app/appoinment/findAppointment1ByAcceptid"];
    
}
#pragma mark----  未支付订单列表接口
+ (NSString *)zy_DidNotPayOrderList_URL{

    return [kBaseFZYUrl stringByAppendingString:@"app/order/getNotPayment"];
}

#pragma mark----  已支付订单列表接口
+ (NSString *)zy_HaveToPayOrderList_URL{
    
    return [kBaseFZYUrl stringByAppendingString:@"app/order/getYetPayment"];
}
#pragma mark----  我的收件列表接口
+ (NSString *)zy_MyReceiptOrderList_URL{
    
    return [kBaseFZYUrl stringByAppendingString:@"app/achievement/getByCreateUserId"];
}
#pragma mark----  我的派件列表接口
+ (NSString *)zy_MySendOrderList_URL{
    
    return [kBaseFZYUrl stringByAppendingString:@"app/achievement/getByDeliveryUserId"];
}
#pragma mark----投诉记录列表接口信息
+ (NSString *)zy_ComplaintsRecordList_URL{
    
    return [kBaseFZYUrl stringByAppendingString:@"app/comPlaint/getMsg"];
    
}
@end
