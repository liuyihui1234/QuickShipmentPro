//
//  UIScrollView+ZYMJRefresh.m
//  ZYSignContractPro
//
//  Created by 飞之翼 on 2019/7/29.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "UIScrollView+ZYMJRefresh.h"
#import "MJRefresh.h"
#import <objc/runtime.h>

typedef void(^RefreshBlock)(NSInteger pageIndex);
typedef void(^LoadMoreBlock)(NSInteger pageIndex);

@interface UIScrollView()
/**页码*/
@property (assign,nonatomic)NSInteger pageIndex;
/**下拉时候触发的block*/
@property (nonatomic,copy) RefreshBlock refreshBlock;
/**上拉时候触发的block*/
@property (nonatomic,copy)LoadMoreBlock loadMoreBlock;

@end

@implementation UIScrollView (ZYMJRefresh)
- (void)addHeaderWithHeaderWithBeginRefresh:(BOOL)beginRefresh animation:(BOOL)animation refreshBlock:(void(^)(NSInteger pageIndex))refreshBlock{
     WeakSelf(self);
    self.refreshBlock = refreshBlock;
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself resetPageNum];
        
        if (weakself.refreshBlock) {
            weakself.refreshBlock(weakself.pageIndex);
        }
        [weakself endHeaderRefresh];
    }];
    
    if (beginRefresh && animation) {
        //有动画的刷新
        [self beginHeaderRefresh];
    }else if (beginRefresh && !animation){
        //刷新，但是没有动画
        [self.mj_header executeRefreshingCallback];
    }
    
    header.mj_h = FitSize(50.0f);
    self.mj_header = header;
}

- (void)addFooterWithWithHeaderWithAutomaticallyRefresh:(BOOL)automaticallyRefresh loadMoreBlock:(void(^)(NSInteger pageIndex))loadMoreBlock{
    
    self.loadMoreBlock = loadMoreBlock;
    
    if (automaticallyRefresh) {
        MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self.pageIndex += 1;
            if (self.loadMoreBlock) {
                self.loadMoreBlock(self.pageIndex);
            }
            //            [self endFooterRefresh]
        }];
        
        footer.automaticallyRefresh = automaticallyRefresh;
        
        footer.stateLabel.font = ZYFontSize(13.0f);
        footer.stateLabel.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
        [footer setTitle:@"加载中…" forState:MJRefreshStateRefreshing];
        [footer setTitle:@"~~这是我的底线啦~~" forState:MJRefreshStateNoMoreData];
        
        self.mj_footer = footer;
    }
    else{
        MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.pageIndex += 1;
            if (self.loadMoreBlock) {
                self.loadMoreBlock(self.pageIndex);
            }
            //            [self endFooterRefresh]
        }];
        footer.stateLabel.font = ZYFontSize(13.0f);
        footer.stateLabel.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
        [footer setTitle:@"加载中…" forState:MJRefreshStateRefreshing];
        [footer setTitle:@"~~这是我的底线啦~~" forState:MJRefreshStateNoMoreData];
        self.mj_footer = footer;
    }
}
-(void)beginHeaderRefresh {
    
    [self resetPageNum];
    [self.mj_header beginRefreshing];
}

- (void)resetPageNum {
    self.pageIndex = 0;
}

- (void)resetNoMoreData {
    
    [self.mj_footer resetNoMoreData];
}

-(void)endHeaderRefresh {
    
    [self.mj_header endRefreshing];
    [self resetNoMoreData];
}

-(void)endFooterRefresh {
    [self.mj_footer endRefreshing];
}

- (void)endFooterNoMoreData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_footer endRefreshingWithNoMoreData];
    });
}


static void *pagaIndexKey = &pagaIndexKey;
- (void)setPageIndex:(NSInteger)pageIndex{
    objc_setAssociatedObject(self, &pagaIndexKey, @(pageIndex), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)pageIndex
{
    return [objc_getAssociatedObject(self, &pagaIndexKey) integerValue];
}

static void *RefreshBlockKey = &RefreshBlockKey;
- (void)setRefreshBlock:(void (^)(void))RefreshBlock{
    objc_setAssociatedObject(self, &RefreshBlockKey, RefreshBlock, OBJC_ASSOCIATION_COPY);
}

- (RefreshBlock)refreshBlock
{
    return objc_getAssociatedObject(self, &RefreshBlockKey);
}

static void *LoadMoreBlockKey = &LoadMoreBlockKey;
- (void)setLoadMoreBlock:(LoadMoreBlock)loadMoreBlock{
    objc_setAssociatedObject(self, &LoadMoreBlockKey, loadMoreBlock, OBJC_ASSOCIATION_COPY);
}

- (LoadMoreBlock)loadMoreBlock
{
    return objc_getAssociatedObject(self, &LoadMoreBlockKey);
}
@end
