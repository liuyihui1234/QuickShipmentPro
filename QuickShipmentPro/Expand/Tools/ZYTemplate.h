//
//  ZYTemplate.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/9/1.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYTemplate : NSObject
+ (NSData *)printZhongJiTemplate_CPCL;
+ (NSData *)printZhongJiTemplate_TSPL;
+ (NSData *)printTianTianTemplate;
+ (NSData *)printShenTongTemplate;
+ (NSData *)printZhongTongTemplate;
+ (NSData *)printKuaiDaTemplate_CPCL;
@end

NS_ASSUME_NONNULL_END
