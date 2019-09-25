//
//  EasyEmptyView.h
//  ArtMoFangProject
//
//  Created by 云创数字 on 2018/6/6.
//  Copyright © 2018年 云创数字. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyEmptyPart.h"
#import "EasyEmptyConfig.h"
#import "EasyEmptyTypes.h"

@interface EasyEmptyView : UIScrollView

+ (EasyEmptyView *)showEmptyInView:(UIView *)superview
                              item:(EasyEmptyPart *(^)(void))item ;

+ (EasyEmptyView *)showEmptyInView:(UIView *)superview
                              item:(EasyEmptyPart *(^)(void))item
                            config:(EasyEmptyConfig *(^)(void))config ;

+ (EasyEmptyView *)showEmptyInView:(UIView *)superview
                              item:(EasyEmptyPart *(^)(void))item
                            config:(EasyEmptyConfig *(^)(void))config
                          callback:(emptyViewCallback)callback ;


+ (void)hiddenEmptyInView:(UIView *)superView ;
+ (void)hiddenEmptyView:(EasyEmptyView *)emptyView ;
@end
