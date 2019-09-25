//
//  UIScrollView+ZYMJRefresh.h
//  ZYSignContractPro
//
//  Created by 飞之翼 on 2019/7/29.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (ZYMJRefresh)
/**
 下拉刷新
 
 @param beginRefresh 是否自动刷新
 @param animation 是否需要动画
 @param refreshBlock 刷新回调
 */
- (void)addHeaderWithHeaderWithBeginRefresh:(BOOL)beginRefresh animation:(BOOL)animation refreshBlock:(void(^)(NSInteger pageIndex))refreshBlock;


/**
 上啦加载
 
 @param automaticallyRefresh 是否自动加载
 @param loadMoreBlock 加载回调
 */
- (void)addFooterWithWithHeaderWithAutomaticallyRefresh:(BOOL)automaticallyRefresh loadMoreBlock:(void(^)(NSInteger pageIndex))loadMoreBlock;


/**
 普通请求结束刷新
 */
- (void)endFooterRefresh;


/**
 没有数据结束刷新
 */
- (void)endFooterNoMoreData;
@end

NS_ASSUME_NONNULL_END
