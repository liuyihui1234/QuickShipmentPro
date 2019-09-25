//
//  ZYNetworkClient.h
//  ZYSignContractPro
//
//  Created by 飞之翼 on 2019/6/29.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface ZYNetworkClient : AFHTTPSessionManager

/**
 单例类
 
 @return 初始化方法
 */
+(instancetype)sharedHTTPClient;
/**
 当前网络状态
 */
@property (nonatomic, assign)AFNetworkReachabilityStatus currentState;

/**
 是否移动网络
 */
@property (nonatomic, assign) BOOL viaWWANReachability;
@end

NS_ASSUME_NONNULL_END
