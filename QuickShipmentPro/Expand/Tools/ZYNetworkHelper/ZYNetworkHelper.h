//
//  ZYNetworkHelper.h
//  ZYSignContractPro
//
//  Created by 飞之翼 on 2019/6/29.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,ZYClientRequestCachePolicy){//几种缓存情况
    
    ZYClientRequestCacheDataAndLoad = 0,//有缓存就先返回缓存，同步请求数据
    ZYClientRequestCacheDataIgnore,//忽略缓存，重新请求
    ZYClientRequestCacheDataElseLoad,//有缓存就用缓存，没有缓存就重新请求(用于数据不变时)
    ZYClientRequestCacheDataNoLoad,//有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
    
};

typedef NS_ENUM(NSInteger,ZYNetworkRequestType){
    ZYNetworkTypeGet,
    ZYNetworkTypePost
    
};
/********请求数据Block********/
typedef void (^ZYBlock)(id responseObject,NSError *error);
/*********刷新token******************/
typedef void (^ZYTokenBool)(BOOL ors);
@interface ZYNetworkHelper : NSObject
@property (nonatomic, assign) BOOL result;//是否需要重新请求数据
@property(nonatomic,copy)NSString *videoUploadProgress;//上传进度

/**
 单例初始化方法
 */
+ (ZYNetworkHelper *)shareHttpManager;

/*************普通请求****************/
- (void)requsetWithUrl:(NSString *)url withParams:(NSDictionary *)params withCacheType:(ZYClientRequestCachePolicy)cacheType withRequestType:(ZYNetworkRequestType)type withResult:(ZYBlock)resultBlock;
@end

NS_ASSUME_NONNULL_END
